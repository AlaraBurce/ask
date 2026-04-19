
# Contributing to ask

We’d love to hear your contributions! Please make sure to follow these guidelines.

## Getting Started

1. Fork the repository on GitHub
2. Clone your fork:
   ```bash
   git clone https://github.com/your-username/ask.git
   ```
3. Create new branch:
   ```bash
   git checkout -b fix/your-fix-name
   ```
4. Make your changes
5. Test your changes (look at Testing section)
6. Commit with a clear message:
   ```bash
   git commit -m "describe what you changed and why"
   ```
7. Open a pull request against the `main` branch

## Code Style

- Quote all variables: `"$var"` not `$var`
- Use `[[ ]]` over `[ ]` for conditionals
- Keep `set -euo pipefail` at the top
- Keep the script dependency-free except for `curl` and `jq`
- Add comments for any non-obvious logic

## Testing

Test the cases below before submitting:

```bash
./ask "hello"
echo "hello" | ./ask
echo "world" | ./ask "hello"
./ask  # should print usage error
```

In addition make sure missing environment variables show a clear error message.

## Reporting Issues

Open a GitHub Issue and include:
- What you ran
- What you expected
- What actually happened
- Your OS and Bash version (`bash --version`)

