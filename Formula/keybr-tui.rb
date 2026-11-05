class KeybrTui < Formula
  desc "Terminal UI for the keybr.com touch-typing practice engine"
  homepage "https://github.com/PannenetsF/keybr.com/tree/main/packages/tui"
  url "https://github.com/PannenetsF/keybr.com/releases/download/tui-v0.1.1/keybr-tui-0.1.1.tgz"
  sha256 "7c066183895bfcce0b2374c2ab1b67bec6414af8903352c48d8bbde894c27e47"
  license "AGPL-3.0-only"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/keybr-tui --version")
    assert_match "touch typing practice", shell_output("#{bin}/keybr-tui --help")
    assert_match "en-dvorak", shell_output("#{bin}/keybr-tui --list-layouts")
  end
end
