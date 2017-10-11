class GstPluginsGood < Formula
  desc "GStreamer plugins (well-supported, under the LGPL)"
  homepage "https://gstreamer.freedesktop.org/"
  url "https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-1.12.3.tar.xz"
  sha256 "13e7f479296891fef5a686438f20ba7d534680becf2269ecc5ee24aa83b45f03"
  
  head do
    url "https://anongit.freedesktop.org/git/gstreamer/gst-plugins-good.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end
  
  depends_on "pkg-config" => :build
  
  depends_on "half2me/gstreamer/gst-plugins-base"
  depends_on "gettext"
  
  depends_on "orc" => :recommended
  depends_on "libx11" => :recommended
  depends_on "aalib" => :recommended
  depends_on "cairo" => :recommended
  depends_on "flac" => [:recommended, "with-libogg"]
  depends_on "gdk-pixbuf" => :recommended
  depends_on "jpeg" => :recommended
  depends_on "libcaca" => :recommended
  depends_on "libdv" => :recommended
  depends_on "libpng" => :recommended
  depends_on "libsoup" => :recommended
  depends_on "taglib" => :recommended
  depends_on "libvpx" => :recommended
  depends_on "wavpack" => :recommended
  depends_on "zlib" => :recommended
  depends_on "bzip2" => :recommended
  
  depends_on "jack" => :optional
  depends_on "pulseaudio" => :optional
  depends_on "libshout" => :optional
  depends_on "speex" => :optional

  depends_on "libogg" if build.with? "flac"

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-experimental
      --disable-debug
      --disable-dependency-tracking
      --enable-v4l2-probe=yes
      --enable-orc=#{build.with?("orc") ? "yes" : "no"}
    ]

    if build.head?
      ENV["NOCONFIGURE"] = "yes"
      system "./autogen.sh"
    end

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    gst = Formula["gstreamer"].opt_bin/"gst-inspect-1.0"
    output = shell_output("#{gst} --plugin cairo")
    assert_match version.to_s, output
  end
end
