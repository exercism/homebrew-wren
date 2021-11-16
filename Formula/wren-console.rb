class WrenConsole < Formula
  desc "Improved REPL and CLI tool for running Wren scripts"
  homepage "https://github.com/joshgoebel/wren-console"
  url "https://github.com/joshgoebel/wren-console/archive/v0.3.0.tar.gz"
  sha256 "38f4a776135f3092107b7984297335a4c764f591bec906fcf14eec8eacf9c424"
  license "MIT"

  bottle do
    root_url "https://github.com/exercism/homebrew-wren/releases/download/wren-console-0.3.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:     "1a7da001094e6ba2fb9ddc087664c08ca1fb80a51b4b1cab1bd97ca717e631cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8dbbb2708af9b704b3fba4fca306554863bdc6eab940e84d4daa1be2e9131eee"
  end

  resource "wren-essentials" do
    url "https://github.com/joshgoebel/wren-essentials/archive/v0.2.0.tar.gz"
    sha256 "a1125c54e9a04186cb22cb9d53a1c479779670e024d78305578dc638b828efe7"
  end

  # TODO: remove this comment
  # need a change to build bottles

  def install
    project_dir = "projects/make.mac"
    project_dir = "projects/make" if OS.linux?

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
