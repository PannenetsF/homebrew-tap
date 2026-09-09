class AerospaceHud < Formula
  desc "Per-monitor workspace HUD for the AeroSpace window manager"
  homepage "https://github.com/PannenetsF/aerospace-hud"
  url "https://github.com/PannenetsF/aerospace-hud/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "56a03476c86794b482695c8a9d60c485ed3cf48ed413f83f06f83b1c64feefdb"
  license "MIT"
  head "https://github.com/PannenetsF/aerospace-hud.git", branch: "main"

  depends_on :macos
  depends_on xcode: :build

  def install
    system "swiftc", "-O", "workspace_indicator.swift", "-o", "aerospace-hud"
    bin.install "aerospace-hud"
  end

  def caveats
    <<~EOS
      Tell AeroSpace to touch the dirty file on every workspace change. In
      ~/.config/aerospace/aerospace.toml:

        exec-on-workspace-change = ['/bin/sh', '-c', 'printf . > /tmp/aerospace-workspace-indicator-dirty']

      Then start the HUD as a background service:

        brew services start aerospace-hud
    EOS
  end

  service do
    run [opt_bin/"aerospace-hud"]
    keep_alive true
    process_type :interactive
    log_path "#{var}/log/aerospace-hud/aerospace-hud.log"
    error_log_path "#{var}/log/aerospace-hud/aerospace-hud.log"
  end

  test do
    # The binary needs a GUI session to run; just assert it was installed and
    # is executable.
    assert_predicate bin/"aerospace-hud", :executable?
  end
end
