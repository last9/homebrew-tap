# Last9 Homebrew Formula

This repository contains the Homebrew formula for installing the Last9 tools. This is the official Homebrew tap for Last9 tools.

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

1. Set up your Last9 API key securely:
```bash
# Option 1: Set in your shell session
export LAST9_API_KEY=your_api_key

# Option 2: Add to your shell profile (.bashrc, .zshrc, etc.)
echo 'export LAST9_API_KEY=your_api_key' >> ~/.zshrc  # or ~/.bashrc

# Option 3: Use your OS's credential manager (recommended)
security add-generic-password -a "$USER" -s "last9-mcp" -w "your_api_key"  # macOS
```

2. Verify the installation:
```bash
last9-mcp version
```

## Security Best Practices

1. API Key Management:
   - Never commit your API key to version control
   - Store your API key in a secure credential manager
   - Use environment variables in CI/CD pipelines
   - Add `LAST9_API_KEY` to your `.gitignore`

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

## Usage

Here are some common commands:

```bash
# Show help
last9-mcp --help

# Initialize configuration
last9-mcp init

# Check status
last9-mcp status

# View version
last9-mcp version
```

## Updating

To update to the latest version:

```bash
brew update
brew upgrade last9-mcp
```

## Development

To install from HEAD:

```bash
brew install --HEAD last9-mcp
```

## CI/CD Integration

When using Last9 MCP in CI/CD environments:

1. Set the API key as a secure environment variable
2. Never print or log the API key
3. Use secure secrets management services
4. Rotate API keys regularly

Example GitHub Actions setup:
```yaml
env:
  LAST9_API_KEY: ${{ secrets.LAST9_API_KEY }}
```

## Documentation

For more information about using Last9 MCP, visit:
- [Last9 Documentation](https://last9.io/docs)
- [Last9 Security Guidelines](https://last9.io/docs/security)
- [GitHub Repository](https://github.com/last9/last9-mcp-server)

## Support

For issues, questions, or contributions:
- Open an issue in this repository
- Contact Last9 support at support@last9.io
- Visit our [Community Forum](https://community.last9.io)

## License

This formula is distributed under the Apache-2.0 License.

## Disclaimer

This Homebrew tap is maintained by Last9. While the tap repository is public (as required by Homebrew), it only contains public information and is safe to be public. 