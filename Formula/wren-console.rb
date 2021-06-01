class WrenConsole < Formula
  desc "Improved REPL and CLI tool for running Wren scripts"
  homepage "https://github.com/joshgoebel/wren-console"
  url "https://github.com/joshgoebel/wren-console/archive/v0.2.90.tar.gz"
  sha256 "5af9e6383606fec4429dcce88c6643025a2363c0324906a1661d7f6848e204b8"
  license "MIT"

  resource "wren-essentials" do
    url "https://github.com/joshgoebel/wren-essentials/archive/v0.1.0.tar.gz"
    sha256 "2192f3c4b8c039895582d87577a473a4eb5f84db827d914d611bb69ec334068a"
  end

  def install
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
