cask "camera" do
  version "1.1"
  sha256 "a16a62bc6744d07ec5c04b92aeb522fd15c5ba3ba6d8d26add145375479755e6"

  url "https://github.com/yusufdiallo1/camera-releases/releases/download/v#{version}/Camera-#{version}.dmg"
  name "Camera"
  desc "Camera for the Mac, wearing the iPhone's interface"
  homepage "https://github.com/yusufdiallo1/camera-releases"

  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  app "Camera.app"

  # The app is not notarized, so macOS would otherwise refuse to open it.
  # Homebrew removes the quarantine flag itself on install, which is why
  # 'brew install' sidesteps the right-click dance entirely.
  zap trash: [
    "~/Library/Containers/com.yusufdiallo.camera",
    "~/Library/Application Support/Camera",
  ]

  caveats <<~EOS
    Camera needs a few permissions, each asked for when it is first used:

      Camera and Microphone  capture
      Photos                 saving, add-only — it never reads your library
      Screen Recording       only for the Screen tab

    Screen Recording is read once at launch, so quit and reopen the app after
    granting it.
  EOS
end
