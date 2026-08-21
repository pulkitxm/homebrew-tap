class Quinjet < Formula
  desc "Fast, live, keyboard-first Git source-control interface for the terminal"
  homepage "https://quinjet.pulkit.page/"
  version "0.0.43"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-macos-aarch64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "5b690ba5bb5645e68a92669acfa70f96fba6dcad6124c45ed4a671764ad090d3"
    end
    on_intel do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-macos-x86_64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "d0e4551b88b7e5d0d7bcadb9c9b012e28cdc6a4db1740f161a781df22c2962e4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-linux-aarch64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "36512006bdd339965d0edae64ee3db5c4fc6edf18719cee7462ffc5959becd1e"
    end
    on_intel do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-linux-x86_64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "4febd02d4e27b1d1011c40f36147e80a6e2afe0e549ea59d7dea45c6e165247e"
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
