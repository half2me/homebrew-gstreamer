class GstPluginsBad < Formula
  desc "GStreamer plugins less supported, not fully tested"
  homepage "https://gstreamer.freedesktop.org/"
  url "https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-1.12.3.tar.xz"
  sha256 "36d059761852bed0f1a7fcd3ef64a8aeecab95d2bca53cd6aa0f08054b1cbfec"

  head do
    url "https://anongit.freedesktop.org/git/gstreamer/gst-plugins-bad.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  
  depends_on "gettext"
  depends_on "half2me/gstreamer/gst-plugins-base"
  
  depends_on "openssl"
  depends_on "curl"
  depends_on "libssh2"
  
  depends_on "jpeg" => :recommended
  depends_on "orc" => :recommended
  depends_on "rtmpdump" => :recommended
  depends_on "gnutls" => :recommended
  depends_on "libexif" => :recommended
  depends_on "srtp" => :recommended
  depends_on "dssim" => :recommended
  depends_on "libav" => :recommended
  depends_on "wayland" => :recommended
  depends_on "aalib" => :recommended
  depends_on "libva" => :recommended
  depends_on "libvorbis" => :recommended
  depends_on "webp" => :recommended
  depends_on "opencv" => :recommended
  depends_on "opus" => :recommended
  depends_on "x264" => :recommended
  depends_on "x265" => :recommended
  
  depends_on "qt" => :optional
  depends_on "openexr" => :optional
  depends_on "graphene" => :optional
  depends_on "libbs2b" => :optional
  depends_on "chromaprint" => :optional
  depends_on "libgsm" => :optional
  depends_on "sdl" => :optional
  depends_on "opus" => :optional
  depends_on "libdca" => :optional
  depends_on "musepack" => :optional
  depends_on "libmms" => :optional
  depends_on "libkate" => :optional
  depends_on "dirac" => :optional
  depends_on "faac" => :optional
  depends_on "faad2" => :optional
  depends_on "fdk-aac" => :optional
  depends_on "gtk+3" => :optional
  depends_on "libdvdread" => :optional
  depends_on "schroedinger" => :optional
  depends_on "sound-touch" => :optional
  depends_on "libvo-aacenc" => :optional

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-debug
      --disable-dependency-tracking
      --enable-experimental
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
    output = shell_output("#{gst} --plugin dvbsuboverlay")
    assert_match version.to_s, output
  end
end
