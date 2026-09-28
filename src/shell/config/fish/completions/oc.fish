# Override fish's built-in `oc` completion (intended for OpenConnect VPN).
#
# In this dotfiles repo, `oc` is an alias for `opencode` (see aliases.fish),
# so the built-in — which is just `oc completion fish | source` — breaks:
# opencode has no `completion` subcommand, the call dumps its help text,
# and `source` interprets that help as fish code, producing "Unknown
# command" errors for every line and silently executing words from the help
# (e.g. `serve`, `uninstall`, `run`, `upgrade`).
#
# Delegate to opencode's proper completion generator instead.
opencode --completions fish | source