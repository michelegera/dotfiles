# GPG and Git on macOS

1. [Generate a new GPG key][1]
2. [Add the new key to your account][2]
3. Run `gpg --list-secret-keys --keyid-format LONG` and look for the key ID in
    the `sec` line
4. In `.gitconfig.local`, replace the `signingkey` with the key ID from the
   previous step
    ```
    signingkey = <your-key-id>
    ```
5. Add this line to ~/.gnupg/gpg.conf
    ```
    no-tty
    ```

[1]: https://help.github.com/articles/generating-a-new-gpg-key/
[2]: https://help.github.com/articles/adding-a-new-gpg-key-to-your-github-account/
