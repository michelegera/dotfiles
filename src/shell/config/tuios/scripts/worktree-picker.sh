#!/bin/sh
# Pick a worktree of the repository the focused pane is in.
#
# The list holds the worktree sessions of that repository. Enter on a match
# switches to its session. Enter with a name that matches nothing makes a
# new worktree on that branch, with a session in it, and switches to it.
# ctrl-n makes the typed name a new worktree even when the list matches it.
#
# A new worktree is made in the project, under .worktrees/, on a branch of
# its own. The branch is the one that is here, or the one on a remote, and a
# branch that is only on a remote tracks it. Its session is named
# <repo>-<branch>, the way 'tuios worktree new' names it.

set -u

PATH="$PATH:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin"
export PATH

# The picker closes on its own, so a message has to be read before it goes.
die() {
    printf '%s\n' "$1" >&2
    printf '\npress enter to close\n'
    read -r _ || true
    exit 1
}

command -v fzf >/dev/null 2>&1 || die "fzf is not installed."
command -v jq >/dev/null 2>&1 || die "jq is not installed."

pane_dir=${TUIOS_ACTIVE_PANE_CWD:-$PWD}

# The physical folder of the pane. A symlinked path, such as ~/.config, makes
# git answer with a path that is relative to the real folder, and tuios
# joins that answer to the path it was given, so only the physical one is of
# any use.
repo_dir=$(cd -P "$pane_dir" 2>/dev/null && pwd) || die "Not a folder: $pane_dir"

git -C "$repo_dir" rev-parse --git-dir >/dev/null 2>&1 ||
    die "Not a git repository: $pane_dir"

# The main checkout of the repository, even when the pane sits in one of its
# worktrees.
common_dir=$(git -C "$repo_dir" rev-parse --path-format=absolute --git-common-dir 2>/dev/null) ||
    common_dir=""
if [ -z "$common_dir" ]; then
    # Git older than 2.31 has no --path-format.
    common_dir=$(git -C "$repo_dir" rev-parse --git-common-dir 2>/dev/null) ||
        die "Not a git repository: $pane_dir"
    case $common_dir in
        /*) ;;
        *) common_dir="$repo_dir/$common_dir" ;;
    esac
fi
common_dir=$(cd -P "$common_dir" 2>/dev/null && pwd) || die "Not a git repository: $pane_dir"

case $(basename "$common_dir") in
    .git) main_root=$(dirname "$common_dir") ;;
    *) main_root=$common_dir ;;
esac
repo_name=$(basename "$main_root")

# The worktree sessions of this repository: the branch, a tab, the session.
worktrees=$(tuios worktree ls --json 2>/dev/null | jq -r --arg repo "$repo_name" '
    .[]
    | select((.repo == $repo) or ((.repo_root // "") | endswith("/" + $repo)))
    | select(.gone != true)
    | [.branch, .session]
    | @tsv')

tab=$(printf '\t')

if [ -n "$worktrees" ]; then
    items=$(printf '%s\n' "$worktrees")
else
    items=""
fi

# The query, the key that closed the picker, and the match, when there was
# one. The key is empty unless it was one of the expected ones.
choice=$(printf '%s' "$items" | fzf \
    --print-query \
    --expect=ctrl-n \
    --delimiter="$tab" \
    --with-nth=1 \
    --prompt='worktree> ' \
    --header='enter: switch to the match, or make the name   ctrl-n: make the name   esc: cancel')
status=$?

# fzf exits 1 when nothing matched, which is the name of a new worktree, and
# 130 when the picker was closed without a choice.
case $status in
    0 | 1) ;;
    *) exit 0 ;;
esac

query=$(printf '%s\n' "$choice" | sed -n '1p')
pressed=$(printf '%s\n' "$choice" | sed -n '2p')
selected=$(printf '%s\n' "$choice" | sed -n '3p')

# ctrl-n asks for the typed name, whatever the list matched.
if [ "$pressed" = "ctrl-n" ]; then
    selected=""
fi

if [ -n "$selected" ]; then
    exec tuios switch-session "$(printf '%s' "$selected" | cut -f2)"
fi

name=$query
[ -n "$name" ] || exit 0

# The worktree goes in the project, under .worktrees/. It is made here, and
# not by 'tuios worktree new', because that one keeps its worktrees in a
# directory of its own, where the project cannot hold them.
slug() {
    printf '%s' "$1" | sed -E 's/[^A-Za-z0-9._]+/-/g; s/^[.-]+//; s/[.-]+$//'
}

# The remote that holds the branch, origin first. A branch that is on a
# remote but was never fetched is not found here, the same way git's own
# checkout does not find it: fetch it first.
remote_holding() {
    for remote in origin $(git -C "$main_root" remote | grep -v '^origin$'); do
        if git -C "$main_root" show-ref --verify --quiet "refs/remotes/$remote/$1"; then
            printf '%s' "$remote"
            return 0
        fi
    done
    return 0
}

branch_slug=$(slug "$name")
[ -n "$branch_slug" ] || branch_slug=branch
session="$(slug "$repo_name")-$branch_slug"
worktree_path="$main_root/.worktrees/$branch_slug"

[ -e "$worktree_path" ] && die "There is already something at $worktree_path."

# A branch that is here is checked out. One that is only on a remote is made
# here from the remote, and tracks it. One that is nowhere is made from the
# head of the main checkout.
if git -C "$main_root" show-ref --verify --quiet "refs/heads/$name"; then
    git -C "$main_root" worktree add -- "$worktree_path" "$name" ||
        die "Could not make the worktree $name."
else
    remote=$(remote_holding "$name")
    if [ -n "$remote" ]; then
        git -C "$main_root" worktree add -b "$name" -- "$worktree_path" "$remote/$name" ||
            die "Could not make the worktree $name."
    else
        git -C "$main_root" worktree add -b "$name" -- "$worktree_path" ||
            die "Could not make the worktree $name."
    fi
fi

# The session in it, and the client moves there.
exec tuios switch-session --create --cwd "$worktree_path" "$session"
