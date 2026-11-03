class Quinjet < Formula
  desc "Fast, live, keyboard-first Git source-control interface for the terminal"
  homepage "https://quinjet.pulkit.page/"
  version "0.0.86"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-macos-aarch64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "022157ac037867a4f6685733840ebe026ab8a78086c15a44b84d58e75511d49c"
    end
    on_intel do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-macos-x86_64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "cd9304cc1cd2c9418b7de61c80823c952174b0198369ba35abec4d7b855412c7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-linux-aarch64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "b13d85d411884a0a3e56f031b42e3f604c96942ed96d3c11bf5bd0adaf41c1a3"
    end
    on_intel do
      url "https://github.com/pulkitxm/quinjet/releases/download/v#{version}/quinjet-linux-x86_64",
          verified: "github.com/pulkitxm/quinjet/"
      sha256 "1d6fa1962bed9c74c89373f12983a01f9fe2fe0a6786ef3ec91004e00e3bcb72"
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
