cask "edith" do
  version "1.0.32"
  sha256 "1b019a1813749214e5b93e1f7d49636937ac5f5bb2fd513729cdf604f9c9c015"

  url "https://github.com/pulkitxm/getedith.pro/releases/download/v#{version}/Edith.dmg",
      verified: "github.com/pulkitxm/getedith.pro/"
  name "Edith"
  desc "Menu bar control center for coding agents, clipboard, music, and disk tools"
  homepage "https://getedith.pro/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  app "Edith.app"
  binary "#{appdir}/Edith.app/Contents/MacOS/ed"
  binary "#{appdir}/Edith.app/Contents/MacOS/ed", target: "edith"

  uninstall quit: [
    "com.pulkit.edith",
    "com.pulkit.edith.files",
    "com.pulkit.edith.helper.v2",
    "com.pulkit.edith.helper",
    "com.pulkit.edith.statusbar",
  ]

  zap trash: [
    "~/Library/Application Support/Edith",
    "~/Library/Caches/com.pulkit.edith",
    "~/Library/Caches/Edith",
    "~/Library/HTTPStorages/com.pulkit.edith",
    "~/Library/Preferences/com.pulkit.edith.plist",
    "~/Library/Preferences/com.pulkit.edith.shared.plist",
    "~/Library/Preferences/com.pulkit.edith.helper.v2.plist",
    "~/Library/Preferences/com.pulkit.edith.helper.plist",
    "~/Library/Preferences/com.pulkit.edith.statusbar.plist",
    "~/Library/Saved Application State/com.pulkit.edith.savedState",
  ]
end
