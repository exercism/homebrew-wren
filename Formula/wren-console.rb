class WrenConsole < Formula
  desc "Improved REPL and CLI tool for running Wren scripts"
  homepage "https://github.com/joshgoebel/wren-console"
  url "https://github.com/joshgoebel/wren-console/archive/v0.2.90.tar.gz"
  sha256 "5af9e6383606fec4429dcce88c6643025a2363c0324906a1661d7f6848e204b8"
  license "MIT"

  bottle do
    root_url "https://github.com/exercism/homebrew-wren/releases/download/wren-console-0.2.90"
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:     "e3c2367ad628788fdea73265ed82ca618051301a9385aa4c3cea4a42a4b6a1c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "07bb9b746b03c1339ccf5b5715162a9d03429ca7ec3731c318d22b403b6c7e49"
  end

  resource "wren-essentials" do
    url "https://github.com/joshgoebel/wren-essentials/archive/v0.1.0.tar.gz"
    sha256 "2192f3c4b8c039895582d87577a473a4eb5f84db827d914d611bb69ec334068a"
  end

  def install
    # trivial change #2
    project_dir = "projects/make.mac"
    on_linux { project_dir = "projects/make" }
    resource("wren-essentials").stage buildpath/"deps/wren-essentials"
    system "make", "-C", project_dir
    bin.install "bin/wrenc"
    pkgshare.install "example"
  end

  test do
    cp pkgshare/"example/hello.wren", testpath
    assert_equal "Hello, world!\n", shell_output("#{bin}/wrenc hello.wren")
  end
end
