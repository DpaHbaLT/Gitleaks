# Pre-commit Hook for Gitleaks

This repository includes a pre-commit hook that automatically checks for secrets in your code using [Gitleaks](https://github.com/gitleaks/gitleaks). The hook will prevent commits if any secrets are detected.

## Features

- Automatically installs Gitleaks if it is not already installed.
- Can be enabled or disabled using `git config`.
- Checks for secrets before each commit and rejects the commit if secrets are found.

## Installation

1. **Add the pre-commit hook script:**

   Save the script to `.git/hooks/pre-commit` in your repository.

2. **Make the script executable:**

    ```bash
    chmod +x .git/hooks/pre-commit
    ```

3. **Enable the Gitleaks pre-commit hook:**

    ```bash
    git config hooks.gitleaks-enabled true
    ```

## Usage

1. **Enable or disable the hook:**

    - To enable the hook:
        ```bash
        git config hooks.gitleaks-enabled true
        ```

    - To disable the hook:
        ```bash
        git config hooks.gitleaks-enabled false
        ```

2. **Testing the hook:**

    To test the hook, add a file with a sample secret, such as a Telegram bot token, and attempt to commit it. For example, add the following line to a file:

    ```plaintext
    telegram_bot_token = "123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11"
    ```

    When you try to commit, the hook should detect the token and reject the commit if the secret is found.

## Troubleshooting

- If you encounter issues with Gitleaks installation, ensure that `curl` is installed and that you have the necessary permissions to move files to `/usr/local/bin`.
- If Gitleaks is already installed but not found, ensure that it is in your system's `PATH`.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
