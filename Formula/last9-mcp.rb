class Last9Mcp < Formula
  desc "Last9 MCP Server CLI tool for monitoring and observability"
  homepage "https://last9.io"
  version "0.10.0"
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
    sha256 "34f7af94b6a6212876b6cf5572abfd17d703da2954158fa401bd5942ef17adc0"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/last9/last9-mcp-server/releases/download/v#{version}/last9-mcp-server_Darwin_x86_64.tar.gz"
    sha256 "7eb6c09afb57e866650d6c9923cb6f47149e28d7e03a654be90392aa0d5c0d4b"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/last9/last9-mcp-server/releases/download/v#{version}/last9-mcp-server_Linux_x86_64.tar.gz"
    sha256 "34f7af94b6a6212876b6cf5572abfd17d703da2954158fa401bd5942ef17adc0"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/last9/last9-mcp-server/releases/download/v#{version}/last9-mcp-server_Linux_arm64.tar.gz"
    sha256 "34f7af94b6a6212876b6cf5572abfd17d703da2954158fa401bd5942ef17adc0"
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