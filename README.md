# Last9 Homebrew Formula

This repository contains the Homebrew formula for installing the Last9 tools. This is the official Homebrew tap for Last9 tools.

## Prerequisites
- curl (recommended)
- jq (recommended)

## System Requirements
Supported platforms:
- macOS (Apple Silicon/ARM64 and Intel/x86_64)
- Linux (ARM64 and x86_64)

## Security Notice

This tap is intentionally public and contains:
- Public URLs to official Last9 GitHub releases
- SHA256 checksums for binary verification
- Installation and usage instructions
- No sensitive information or internal code

## Installation

```bash
# Add the Last9 tap
brew tap last9/tap

# Install the Last9 MCP Server
brew install last9-mcp
```

## Post-Installation Setup

Follow the instructions [here](https://last9.io/docs/mcp/).

## Shell Completion
Last9 MCP comes with shell completion support for:
- Bash
- Zsh
- Fish

The completions are automatically installed with the package.

## Security Best Practices

1. API Key Management:
   - Never commit your API key to version control
   - Store your API key in a secure credential manager
   - Use environment variables in CI/CD pipelines

2. Binary Verification:
   - The formula automatically verifies SHA256 checksums
   - All binaries are downloaded via HTTPS
   - Binaries are sourced only from official Last9 releases

3. Updates:
   - Keep the CLI updated for latest security patches
   - Use `brew update` and `brew upgrade` regularly

## Features

- Cross-platform support (macOS and Linux)
- Architecture support for both ARM and Intel processors
- Shell completion for bash, zsh, and fish
- Recommended dependencies (curl, jq) for enhanced functionality
- Automatic binary verification via checksums

## Updating

To update to the latest version:

```bash
brew update
brew upgrade last9-mcp
```

## Documentation

For more information about using Last9 MCP, visit:
- [Last9 MCP Server Documentation](https://last9.io/docs/mcp)
- [GitHub Repository](https://github.com/last9/last9-mcp-server)

## Support

For issues, questions, or contributions:
- Open an issue in this repository
- Contact Last9 support at cs@last9.io

## License

This formula is distributed under the Apache-2.0 License.

## Disclaimer

This Homebrew tap is maintained by Last9. While the tap repository is public (as required by Homebrew), it only contains public information and is safe to be public. 