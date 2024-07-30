class Pkcs11Provider < Formula
  desc "Openssl 3.x provider to access software or hardware tokens via PKCS#11 interface"
  homepage "https://github.com/latchset/pkcs11-provider"
  version "0.5"
  url "https://github.com/latchset/pkcs11-provider/releases/download/v#{version}/pkcs11-provider-#{version}.tar.xz"
  sha256 "6815de8c6d15bed8f72f65bf8d73efd7d013f17460a77c457a3ed7c679809cfc"
  license "Apache-2.0"
  head "https://github.com/latchset/pkcs11-provider.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "openssl@3"

  def install
    inreplace "src/meson.build", "install_dir: provider_path,", "install_dir: '#{lib}'"

    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  def caveats
    <<~EOS
      Please keep in mind, you will need to adjust the default openssl.cnf file, usually at:
        #{Formula["openssl@3"].pkgetc}/openssl.cnf
      Alternatively, you may set the provider via the environment variable as follows:
        export PKCS11_PROVIDER_MODULE="#{lib}/pkcs11.dylib"
      Check official guide for more details:
        https://github.com/latchset/pkcs11-provider/blob/main/HOWTO.md
    EOS
  end

  test do
    ENV["PKCS11_PROVIDER_MODULE"] = "#{lib}/pkcs11.dylib"
    ENV["OPENSSL_MODULES"] = "#{lib}"
    system "openssl", "list", "-provider", "pkcs11"
    system "echo", "#{lib}"
  end
end
