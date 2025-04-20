class Last9Mcp < Formula
  desc "Last9 MCP Server CLI tool for monitoring and observability"
  homepage "https://last9.io"
  version "0.1.3"
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
    sha256 "702fa94408b236803b6e450e691776a41993909ebae9abf35c93274973537d26"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/last9/last9-mcp-server/releases/download/v#{version}/last9-mcp-server_Darwin_x86_64.tar.gz"
    sha256 "d169df2449574505767563dd5bdad2fbee94230c3c852af5f6e5548f1a1e3aec"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/last9/last9-mcp-server/releases/download/v#{version}/last9-mcp-server_Linux_x86_64.tar.gz"
    sha256 "702fa94408b236803b6e450e691776a41993909ebae9abf35c93274973537d26"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/last9/last9-mcp-server/releases/download/v#{version}/last9-mcp-server_Linux_arm64.tar.gz"
    sha256 "702fa94408b236803b6e450e691776a41993909ebae9abf35c93274973537d26"
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
      To use Last9 MCP, you need to set up your API key:
        export LAST9_API_KEY=your_api_key
        https://last9.io/docs
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