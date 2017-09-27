class GstreamerVaapi < Formula
  desc "Hardware-accelerated video decoding, encoding and processing on Intel graphics through VA-API"
  homepage "https://github.com/GStreamer/gstreamer-vaapi/"
  url "https://gstreamer.freedesktop.org/src/gstreamer-vaapi/gstreamer-vaapi-1.12.3.tar.xz"
  sha256 "f4cdafd8fd9606a490917c8b67336e835df1219580d55421c70480fd0913744d"

  depends_on "pkg-config" => :build
  depends_on "gstreamer"
  depends_on "gst-plugins-base"
  depends_on "gst-plugins-bad"
  depends_on "libva"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    gst = Formula["gstreamer"].opt_bin/"gst-inspect-1.0"
    output = shell_output("#{gst} --plugin vaapi")
    assert_match version.to_s, output
  end
end
