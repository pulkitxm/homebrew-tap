class Quinjet < Formula
  desc "Fast, live, keyboard-first Git source-control interface for the terminal"
  homepage "https://quinjet.pulkit.page/"
  version "0.0.53"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-macos-aarch64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "fea4bea3f1d63ac20e78b69c7295b20bcea6e619cb293f1a75e8102e508b2fc0"
    end
    on_intel do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-macos-x86_64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "8dc7b5ee5de417d9d7c2d704c6adb7a44689315794e2d41e5208de5615a7f63c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-linux-aarch64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "a0500ba9920c2d71c8f9af7a62ece4e42d69fb6d45097115656f5ebcdfe8927b"
    end
    on_intel do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-linux-x86_64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "5f5ba047f33a133241ba993653a56c1520e468b6fe5010fa6273d3e6deffe1ee"
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
