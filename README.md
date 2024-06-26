# [michelegera][github profile]’s dotfiles [![Build Status][ci badge]][ci link]

These are the base dotfiles that I start with when I set up a new environment.
For more specific local needs I use the `*.local` files described in the
[Local Settings](#local-settings) section.

## Table of Contents

- [0️⃣ Before getting started](#before-getting-started)
- [🔧 Setup](#setup)
- [🎛 Customize](#customize)
  - [🌍 Local Settings](#local-settings)
    - [🐟 `~/.fishconfig.local`](#fishconfiglocal)
    - [🐙 `~/.gitconfig.local`](#gitconfiglocal)
  - [🔀 Forks](#forks)
- [↕️ Update](#update)
- [🥇 Acknowledgements](#acknowledgements)
- [⚖️ License](#license)

## Before getting started

Some commands (e.g. `defaults write`) won’t work unless the terminal has full
disk access. To grant full disk access to the terminal, go to
`System Settings > Privacy & Security > Full Disk Access` and add the terminal
to the list of apps.

## Setup

To set up the dotfiles run the appropriate snippet in the terminal:

[!CAUTION]
**DO NOT** run the `setup` snippet if you do not fully understand
[what it does][setup]. Seriously, **DON’T**!

```shell
bash -c "$(curl -LsS https://setup.dotfiles.michelegera.dev)"
```

That’s it! ✨

The setup process will:

- Download the dotfiles on your computer (by default it will suggest
  `~/Code/$(whoami)/dotfiles`)
- Create some additional [directories][dirs]
- [Symlink][symlink] the [Git][git], [prefs][prefs], and [shell][shell] files
- Install [applications and command-line tools][installs]
- Set custom [preferences][preferences] preferences

## Customize

### Local Settings

The dotfiles can be easily extended to suit additional local requirements by
using the following files:

#### `~/.fishconfig.local`

The `~/.fishconfig.local` file will be automatically sourced after the standard
[Fish configuration][fish], thus, allowing its content to add to or overwrite
the existing aliases, settings, `PATH`, environment variables etc.

Here is an example:

```shell
# Set local aliases.

alias g="git"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set environment variables.

set -x NPMJS_AUTH_TOKEN xxxxxxxx

```

#### `~/.gitconfig.local`

The `~/.gitconfig.local` file will be automatically included after the
configurations from `~/.gitconfig`, thus, allowing its content to overwrite or
add to the existing Git configurations.

**Note:** Use `~/.gitconfig.local` to store sensitive information such as the
Git user credentials, e.g.:

```gitconfig
[commit]

    # Sign commits using GPG.
    # https://help.github.com/articles/signing-commits-using-gpg/

    gpgSign = true

[user]

    name = John Appleseed
    email = john.appleseed@apple.com
    signingKey = XXXXXXXX
```

### Set up GPG signing for Git commits

First, make sure permissions are set correctly on the `.gnupg` directory:

```shell
chmod -R go= ~/.gnupg/
```

Next, import your private GPG key:

```shell
gpg --import <key-file>
```

Finally, set `user.signingKey` in `~/.gitconfig.local` to the short id of your
key. You can find it by running:

```shell
gpg --list-secret-keys --keyid-format SHORT
```

### Forks

If you decide to [fork] this project, do not forget to substitute my username
with your own in the `setup` script.

## Update

To update the dotfiles you can either run the [`setup` script][setup] or, if you
want to update one particular part, run the appropriate [`os` script][os].

## Acknowledgements

Inspiration and code was taken from many sources, but mainly
[Cătălin Mariș’ dotfiles][alrra]. Thank you for your amazing work!

## License

The code is available under the [MIT license][license].

<!-- Link labels -->

[alrra]: https://github.com/alrra/dotfiles
[ci badge]: https://github.com/michelegera/dotfiles/workflows/tests/badge.svg
[ci link]: https://github.com/michelegera/dotfiles/actions
[dirs]: src/os/create_directories.sh
[fish]: src/shell/config/fish/config.fish
[fork]: https://help.github.com/en/github/getting-started-with-github/fork-a-repo
[git]: src/git
[github profile]: https://github.com/michelegera
[installs]: src/os/installs
[license]: LICENSE.txt
[os]: src/os
[preferences]: src/os/preferences
[prefs]: src/prefs
[setup]: src/setup.sh
[shell]: src/shell
[symlink]: src/os/create_symbolic_links.sh
