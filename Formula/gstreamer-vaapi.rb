class GstreamerVaapi < Formula
  desc "Hardware-accelerated video decoding, encoding and processing on Intel graphics through VA-API"
  homepage "https://github.com/GStreamer/gstreamer-vaapi/"
  url "https://github.com/GStreamer/gstreamer-vaapi/archive/1.12.3.tar.gz"
  sha256 "2d898482a6ed652f3dab16c456dd4df4e3b057d67b13e48d9a423ab13f4b0e46"
  
  head "https://github.com/GStreamer/gstreamer-vaapi.git"

  depends_on "pkg-config" => :build
  depends_on "gstreamer"
  depends_on "gst-plugins-bad"
  depends_on "linuxbrew/xorg/libva"
  depends_on "linuxbrew/xorg/wayland" => :recommended

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-debug
      --disable-silent-rules
      --disable-examples
      --enable-encoders
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
