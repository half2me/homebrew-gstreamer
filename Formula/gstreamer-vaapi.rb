class GstreamerVaapi < Formula
  desc "Hardware-accelerated video decoding, encoding and processing on Intel graphics through VA-API"
  homepage "https://github.com/GStreamer/gstreamer-vaapi/"
  url "https://gstreamer.freedesktop.org/src/gstreamer-vaapi/gstreamer-vaapi-1.12.3.tar.xz"
  sha256 "f4cdafd8fd9606a490917c8b67336e835df1219580d55421c70480fd0913744d"
  
  head "https://github.com/GStreamer/gstreamer-vaapi.git"

  depends_on "pkg-config" => :build
  depends_on "gstreamer"
  depends_on "gst-plugins-bad"
  depends_on "linuxbrew/xorg/libva" => ["with-eglx"]
  depends_on "linuxbrew/xorg/wayland" => :recommended
  depends_on "linuxbrew/xorg/libdrm"
  depends_on "systemd" => :build
  depends_on "linuxbrew/xorg/libx11" => :recommended
  
  def caveats
  "You must install a libva driver for this package to work. (e.g.: brew install libva-intel-driver)\n".undent
  end
  
  option "with-static", "Build static libraries (not recommended)"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-debug
      --disable-silent-rules
      --disable-examples
      --enable-static=#{build.with?("static") ? "yes" : "no"}
    ]
    
    if build.head?
      # autogen is invoked in "stable" build because we patch configure.ac
      ENV["NOCONFIGURE"] = "yes"
      system "./autogen.sh"
    end
    
    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    gst = Formula["gstreamer"].opt_bin/"gst-inspect-1.0"
    output = shell_output("#{gst} --plugin vaapi")
    assert_match version.to_s, output
  end
end
