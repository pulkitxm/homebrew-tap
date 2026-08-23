class Quinjet < Formula
  desc "Fast, live, keyboard-first Git source-control interface for the terminal"
  homepage "https://quinjet.pulkit.page/"
  version "0.0.46"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-macos-aarch64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "b36e00020f4e0234f8f3e31e734c4aa3e70dbe5d48986e36e388a994a77a7c3a"
    end
    on_intel do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-macos-x86_64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "8381095235b9bf020828b705002f4a3842e63639a61973d7b144153b3b80028b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-linux-aarch64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "f1fd05081af11471b1ea32205c4d023471b290c8fb178cac2379d68bbaba442f"
    end
    on_intel do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-linux-x86_64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "605753d1b6a6d3ac02a1e40cda70d40bed0d11be3bacfd5fdb569df1b0f1f551"
    end
  end

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on "git"

  def install
    bin.install Dir["quinjet-*"].fetch(0) => "quinjet"
    chmod 0555, bin/"quinjet"
    bin.install_symlink bin/"quinjet" => "q"
    generate_completions_from_executable(bin/"quinjet", "completions", shells: [:bash, :zsh, :fish])
    (man1/"quinjet.1").write Utils.safe_popen_read(bin/"quinjet", "man")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/quinjet --version")
    assert_match version.to_s, shell_output("#{bin}/q --version")
    system "git", "init", testpath/"repository"
    assert_match "branch", shell_output("#{bin}/quinjet -C #{testpath}/repository status --json")
  end
end
