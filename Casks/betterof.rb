cask "betterof" do
  version "0.16.0"
  sha256 "d3aa38cc01490eb92f20ed7a0affda78969a7347925b84aae8bd3d0a3afebf5b"

  # The source repository is private, so release builds are mirrored to this tap's releases.
  url "https://github.com/Jaschenn/homebrew-tap/releases/download/betterof-v#{version}/betterOF-#{version}-macOS.zip"
  name "betterOF"
  desc "Personal task manager combining OKRs and GTD, with a CLI and MCP server"
  homepage "https://github.com/Jaschenn/homebrew-tap"

  livecheck do
    url "https://github.com/Jaschenn/homebrew-tap"
    regex(/^betterof-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "BetterOF.app"
  # Bundled command-line tool and MCP server.
  binary "#{appdir}/BetterOF.app/Contents/Helpers/betterof"

  uninstall quit: "com.betterof.app"

  # Removes all betterOF data, including the task database and its backups.
  zap trash: [
    "~/Library/Application Support/betterOF",
    "~/Library/Containers/com.betterof.app.widget",
    "~/Library/Preferences/com.betterof.app.plist",
  ]

  caveats <<~EOS
    betterOF is not notarized by Apple. If macOS blocks the first launch, allow it under
    System Settings -> Privacy & Security, or run:
      xattr -dr com.apple.quarantine "#{appdir}/BetterOF.app"
  EOS
end
