class Libva < Formula
  desc "Libva is an implementation for VA-API (VIdeo Acceleration API)"
  homepage "https://01.org/linuxmedia"
  url "https://github.com/01org/libva/releases/download/1.8.3/libva-1.8.3.tar.bz2"
  sha256 "56ee129deba99b06eb4a8d4f746b117c5d1dc2ec5b7a0bfc06971fca1598ab9b"

  depends_on "pkg-config" => :build
  depends_on "libdrm"

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
