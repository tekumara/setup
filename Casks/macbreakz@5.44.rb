cask "macbreakz@5.44" do
  version "5.44"
  sha256 "6e22b2105adac3f9b935d6066212f140cd2874f0e473ea2ce0b9078b889d13ae"

  url "https://www.publicspace.net/download/MacBreakZ544.dmg"
  name "MacBreakZ"
  desc "Ergonomic Assistant to prevent health problems"
  homepage "https://www.publicspace.net/MacBreakZ/"

  app "MacBreakZ #{version.major}.app"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/net.publicspace.mb#{version.major}.sfl*",
    "~/Library/Caches/com.apple.helpd/Generated/MacBreakZ Help*#{version}",
    "~/Library/Preferences/net.publicspace.mb#{version.major}.plist",
  ]
end
