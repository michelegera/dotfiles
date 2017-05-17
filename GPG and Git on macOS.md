# GPG and Git on macOS

These instructions assume you have a [Keybase account][1]. If you don’t, please
follow GitHub’s instructions for [generating a new GPG key][2] and [adding it to
your account][3].

1. Sign into your Keybase account
2. Click on the `Edit` link next to the PGP key
3. Select `Export my private key from Keybase`
4. Save the key into a `keybase-private.key` file
5. Run `gpg --allow-secret-key-import --import keybase-private.key`
6. Run `gpg --list-secret-keys` and look for the key ID in the `sec` line
7. In `.gitconfig.local`, replace the `signingkey` with the key ID from the
   previous step
    ```
    signingkey = <your-key-id>
    ```
[1]: https://keybase.io/
[2]: https://help.github.com/articles/generating-a-new-gpg-key/
[3]: https://help.github.com/articles/adding-a-new-gpg-key-to-your-github-account/
