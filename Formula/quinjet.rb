class Quinjet < Formula
  desc "Fast, live, keyboard-first Git source-control interface for the terminal"
  homepage "https://quinjet.pulkit.page/"
  version "0.0.71"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-macos-aarch64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "f3fe731c07c33da89fcb5fe71b59c7151688c18f234e087abbf0715b26503497"
    end
    on_intel do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-macos-x86_64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "25256d12d6ca705c0882d93d4bca5c631aafcc7d2c90952f67fd86361c83c5f2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-linux-aarch64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "18a8afd2ea516e8fed474719f86776f5c18095d4d80e135dcf082ea3484634c1"
    end
    on_intel do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-linux-x86_64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "1c915dfb871cb90e19641acda1d753dcbe3e55032c68fbd76471b3ced0bb34a2"
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
