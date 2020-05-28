# [michelegera](https://github.com/michelegera)’s dotfiles

These are the base dotfiles that I start with when I set up a
new environment. For more specific local needs I use the `.local`
files described in the [`Local Settings`](#local-settings) section.

## Setup

To setup the dotfiles just run the following command in the
terminal:

(**DO NOT** run the command if you don’t fully
understand [what it does](dotfiles). Seriously, **DON’T**!)

`bash -c "$(curl -LsS https://raw.github.com/michelegera/dotfiles/master/dotfiles)"`

That’s it!

The setup process will:

- Download the dotfiles on your computer (by default it will suggest
  `~/.dotfiles`)
- Create some additional [directories](os/create_directories.sh)
- [Symlink](os/create_symbolic_links.sh) the
  [git](git), and
  [shell](shell) files
- Install applications / command-line tools for
  [macOS](os/installs/main.sh)
- Install the
  [Bash](https://www.gnu.org/software/bash/) shell
- Set custom
  [macOS](os/preferences/main.sh) preferences

## Customize

### Local Settings

The dotfiles can be easily extended to suit additional local
requirements by using the following files:

#### `~/.gitconfig.local`

If the `~/.gitconfig.local` file exists, it will be automatically
included after the configurations from `~/.gitconfig`, thus, allowing
its content to overwrite or add to the existing `git` configurations.

**Note:** Use `~/.gitconfig.local` to store sensitive information such
as the `git` user credentials, e.g.:

```bash
[user]
  name = John Appleseed
  email = john.appleseed@apple.com
  signingkey = XXXXXXXX
```

#### `~/.ssh/config.local`

If the `~/.ssh/config.local` file exists, it will be automatically included in
the SSH configuration.

**Note:** Use `~/.ssh/config.local` to store sensitive information such as
server names and credentials.

### Forks

If you decide to fork this project, don’t forget to substitute my
username with your own in the [setup snippets](#setup), [in the
`dotfiles` script](https://github.com/michelegera/dotfiles/blob/b45ae1a2ad505318588a347d4b11b4fdddbfbefc/dotfiles#L3)
and [in the iTerm preferences](https://github.com/michelegera/dotfiles/blob/49c2d9a97434d0eebba511f324c3af63c7340463/prefs/iterm2/com.googlecode.iterm2.plist#L1098).

## Update

To update the dotfiles you can either run the [`dotfiles`
script](dotfiles) or, if you want to just update one particular part,
run the appropriate [`os` script](os).

## Acknowledgements

Inspiration and code was taken from many sources, including:

- [Cătălin Mariș’](https://github.com/alrra)
  [dotfiles](https://github.com/alrra/dotfiles)
- [Mathias Bynens’](https://github.com/mathiasbynens)
  [dotfiles](https://github.com/mathiasbynens/dotfiles)
- [Nicolas Gallagher’s](https://github.com/necolas)
  [dotfiles](https://github.com/necolas/dotfiles)

## License

The code is available under the [MIT license](LICENSE.txt).
