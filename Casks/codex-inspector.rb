cask "codex-inspector" do
  arch arm: "arm64", intel: "x86_64"

  version "0.4.0"
  sha256 arm:   "3f3c18bb37cdb28253776ff025497358def19b78f7b01cbb7414d614220a5549",
         intel: "7b19726b309aea5f00b2538de7efb9f3c7e6d4230d02c091213207b76f4ac383"

  url "https://github.com/Jaschenn/codex-inspector/releases/download/v#{version}/CodexInspector-macos-#{arch}.zip"
  name "Codex Inspector"
  desc "Inspect Codex configuration, sessions and token usage"
  homepage "https://github.com/Jaschenn/codex-inspector"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "CodexInspector.app"
  # Expose the bundled Rust engine so `codex-inspector-core` works without a
  # separate formula or a source build.
  binary "#{appdir}/CodexInspector.app/Contents/MacOS/codex-inspector-core"

  uninstall quit: "local.codex-inspector.menubar"

  zap trash: [
    "~/Library/Caches/CodexInspector",
    "~/Library/Logs/CodexInspectorDebug.log",
    "~/Library/Preferences/local.codex-inspector.menubar.plist",
  ]

  caveats <<~EOS
    Codex Inspector is ad-hoc signed and not notarized by Apple. If macOS blocks
    the first launch, allow it under System Settings -> Privacy & Security, or run:
      xattr -dr com.apple.quarantine "#{appdir}/CodexInspector.app"
  EOS
end
