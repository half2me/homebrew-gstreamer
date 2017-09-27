class Libdrm < Formula
  desc "Direct Rendering Manager headers and kernel modules"
  homepage "https://dri.freedesktop.org/wiki/DRM/"
  url "https://dri.freedesktop.org/libdrm/libdrm-2.4.83.tar.gz"
  sha256 "2ff5f626a14ec5bd680f7769cac9a8eb1e40c36cf5ca554d2c4e5d91bab3d81d"

  depends_on "pkg-config" => :build

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "false"
  end
end
