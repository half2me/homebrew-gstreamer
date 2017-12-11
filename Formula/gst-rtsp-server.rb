class GstRtspServer < Formula
  desc "RTSP server library based on GStreamer"
  homepage "https://gstreamer.freedesktop.org/modules/gst-rtsp-server.html"
  url "https://gstreamer.freedesktop.org/src/gst-rtsp-server/gst-rtsp-server-1.12.4.tar.xz"
  sha256 "7660112ebd59838f1054796b38109dcbe32f0a040e3a252a68a81055aeaa56a9"
  
  bottle do
    root_url "https://lfto.me/static/bottle"
    sha256 "866520d92e62af8afe6d525a5112d71a2fc47c5c75203aac20cbad4ac123b214" => :x86_64_linux
  end
  
  depends_on "half2me/gstreamer/gst-plugins-base"

  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "gobject-introspection"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-introspection=yes"

    system "make", "install"
  end

  test do
    gst = Formula["gstreamer"].opt_bin/"gst-inspect-1.0"
    assert_match version.to_s, shell_output("#{gst} --plugin rtsp")
  end
end
