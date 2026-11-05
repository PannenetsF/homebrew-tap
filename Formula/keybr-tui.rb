class KeybrTui < Formula
  desc "Terminal UI for the keybr.com touch-typing practice engine"
  homepage "https://github.com/PannenetsF/keybr.com/tree/main/packages/tui"
  url "https://github.com/PannenetsF/keybr.com/releases/download/tui-v0.1.0/keybr-tui-0.1.0.tgz"
  sha256 "c0c4e1e8a8defac4facbc88750b7c56e5c1fc60ec5960ca3194ed56b5bdee189"
  license "AGPL-3.0-only"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match "touch typing practice", shell_output("#{bin}/keybr-tui --help")
    assert_match "en-dvorak", shell_output("#{bin}/keybr-tui --list-layouts")
  end
end
