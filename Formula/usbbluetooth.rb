class Usbbluetooth < Formula
  desc "USB Bluetooth userspace library based on libusb"
  homepage "https://github.com/usbbluetooth/usbbluetooth/releases/tag/v0.0.10"
  url "https://github.com/usbbluetooth/usbbluetooth/archive/refs/tags/v0.0.10.tar.gz"
  sha256 "0914c32b46cf24a991c455c15f6530146acbf5e84e7dab8a3332411628422917"
  license "MIT"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "libusb"

  def install
    system "meson", "setup", "build",
           "--prefix=#{prefix}",
           "--buildtype=release"

    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <usbbluetooth.h>

      int main(void) {
          return 0;
      }
    EOS

    system ENV.cc, "test.c",
           "-I#{include}",
           "-L#{lib}",
           "-I/opt/homebrew/include/usbbluetooth",
           "-lusbbluetooth",
           "-o", "test"
  end
end
