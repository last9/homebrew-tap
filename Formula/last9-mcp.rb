class Last9Mcp < Formula
  desc "Last9 MCP Server CLI tool for monitoring and observability"
  homepage "https://last9.io"
  version "0.7.3"
  license "Apache-2.0"
  head "https://github.com/last9/last9-mcp-server.git", branch: "main"

  # Stable version check
  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  # Binary downloads for different architectures
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/last9/last9-mcp-server/releases/download/v#{version}/last9-mcp-server_Darwin_arm64.tar.gz"
    sha256 "67abf47b6177c5d8470286b8be8cf20fa0fc2aaee6b46ebdcc8f34cf397e0711"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/last9/last9-mcp-server/releases/download/v#{version}/last9-mcp-server_Darwin_x86_64.tar.gz"
    sha256 "9ffe8e90922898fabd40a2fca6aa3f729fcc33976657543bbdf41dddb593a6a6"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/last9/last9-mcp-server/releases/download/v#{version}/last9-mcp-server_Linux_x86_64.tar.gz"
    sha256 "67abf47b6177c5d8470286b8be8cf20fa0fc2aaee6b46ebdcc8f34cf397e0711"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/last9/last9-mcp-server/releases/download/v#{version}/last9-mcp-server_Linux_arm64.tar.gz"
    sha256 "67abf47b6177c5d8470286b8be8cf20fa0fc2aaee6b46ebdcc8f34cf397e0711"
  end

  # Optional but recommended dependencies
  depends_on "curl" => :recommended
  depends_on "jq" => :recommended

  def install
    # Extract the binary from the tarball
    bin.install "last9-mcp-server" => "last9-mcp"

    # Generate and install shell completions
    output = Utils.safe_popen_read("#{bin}/last9-mcp", "completion", err: :out)
    (bash_completion/"last9-mcp").write output
    (zsh_completion/"_last9-mcp").write output
    (fish_completion/"last9-mcp.fish").write output
  rescue
    # Ignore completion generation errors as the binary might not support it yet
    opoo "Shell completion installation was skipped. This is not critical for core functionality."
  end

  def caveats
    <<~EOS
      To use Last9 MCP, please refer to the documentation at:
        https://last9.io/docs/mcp
    EOS
  end

  test do
    # Test version output
    assert_match "v#{version}", shell_output("#{bin}/last9-mcp version 2>&1")
    
    # Test help output
    assert_match "Usage:", shell_output("#{bin}/last9-mcp --help 2>&1")
    
    # Test configuration file creation
    system "#{bin}/last9-mcp", "init", "--help"
    
    # Test basic functionality without API key
    output = shell_output("#{bin}/last9-mcp status 2>&1", 1)
    assert_match(/api key|authentication/i, output)
  end
end 