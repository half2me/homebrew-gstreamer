class GstPluginsBase < Formula
  desc "GStreamer plugins (well-supported, basic set)"
  homepage "https://gstreamer.freedesktop.org/"
  url "https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.12.3.tar.xz"
  sha256 "d3d37b8489d37fa0018973d850bd2067b98af335fef2fa543ee7d40359e3cea5"
  
  bottle do
    sha256 "6e756a508dd4af637d778207b71c090aa1e2be1006352f09682ce5bf81d55ce2" => :x86_64_linux
  end

  head do
    url "https://anongit.freedesktop.org/git/gstreamer/gst-plugins-base.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  
  depends_on "gettext"
  depends_on "half2me/gstreamer/gstreamer"
  depends_on "gobject-introspection"
  
  depends_on "orc" => :recommended
  depends_on "zlib" => :recommended
  depends_on "libx11" => :recommended
  depends_on "alsa-lib" => :recommended
  depends_on "libvorbis" => :recommended
  depends_on "libogg" => :recommended
  depends_on "opus" => :recommended
  depends_on "pango" => :recommended
  depends_on "theora" => :recommended
  
  depends_on "cdparanoia" => :optional
  depends_on "iso-codes" => :optional
  
  depends_on "libxv" if build.with?("libx11")
  depends_on "libxt" if build.with?("libx11")
  depends_on "gtk+" => :optional
  depends_on "qt" => :optional
  
  # Currently the plugins: ivorbisdec, libvisual cannot be built.
  def install
    args = %W[
      --prefix=#{prefix}
      --enable-experimental
      --disable-debug
      --disable-dependency-tracking
      --enable-introspection=yes
      --enable-orc=#{build.with?("orc") ? "yes" : "no"}
      --enable-iso-codes=#{build.with?("iso-codes") ? "yes" : "no"}
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
    assert_match version.to_s, shell_output("#{gst} --plugin volume")
    assert_match version.to_s, shell_output("#{gst} --plugin alsa") if build.with?("alsa-lib")
    assert_match version.to_s, shell_output("#{gst} --plugin ogg") if build.with?("libogg")
    assert_match version.to_s, shell_output("#{gst} --plugin opus") if build.with?("opus")
    assert_match version.to_s, shell_output("#{gst} --plugin pango") if build.with?("pango")
    assert_match version.to_s, shell_output("#{gst} --plugin theora") if build.with?("theora")
    assert_match version.to_s, shell_output("#{gst} --plugin vorbis") if build.with?("libvorbis")
    assert_match version.to_s, shell_output("#{gst} --plugin ximagesink") if build.with?("libx11")
    assert_match version.to_s, shell_output("#{gst} --plugin xvimagesink") if build.with?("libx11")
  end
end
