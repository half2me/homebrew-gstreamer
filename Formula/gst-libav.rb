class GstLibav < Formula
  desc "GStreamer plugins for Libav (a fork of FFmpeg)"
  homepage "https://gstreamer.freedesktop.org/"
  url "https://gstreamer.freedesktop.org/src/gst-libav/gst-libav-1.12.3.tar.xz"
  sha256 "015ef8cab6f7fb87c8fb42642486423eff3b6e6a6bccdcd6a189f436a3619650"
  
  bottle do
    root_url "https://lfto.me/static/bottle"
    sha256 "4282619953db601de1a4c6e598cdbd924b47db939dc3981972f4cd4d65414ca8" => :x86_64_linux
  end

  head do
    url "https://anongit.freedesktop.org/git/gstreamer/gst-libav.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "yasm" => :build
  
  depends_on "half2me/gstreamer/gst-plugins-base"
  depends_on "gettext"
  depends_on "xz" # For LZMA
  
  depends_on "orc" => :recommended

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-debug
      --disable-dependency-tracking
      --enable-orc=#{build.with?("orc") ? "yes" : "no"}
      --enable-gpl=yes
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
    system "#{Formula["gstreamer"].opt_bin}/gst-inspect-1.0", "libav"
  end
end
