# GPG and Git on macOS

## Setup

1. Create or import a key (see below)
2. Run `gpg --list-secret-keys` and look for `sec`, use the key ID for the next step
3. Configure `git` to use GPG – replace the key with the one from `gpg --list-secret-keys`
    ```
    git config --global user.signingkey <key-id>
    ```
4. Add this line to ~/.gnupg/gpg.conf
    ```
    no-tty
    ```

## Keybase.io

### Import key to GPG on another host

```
% keybase pgp export
% keybase pgp export -q <key-id> | gpg --import
% keybase pgp export -q <key-id> --secret | gpg --allow-secret-key-import --import
```

### Add public GPG key to GitHub

```
% open https://github.com/settings/keys
% keybase pgp export -q <key-id> | pbcopy
```
