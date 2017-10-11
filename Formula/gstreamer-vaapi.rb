class GstreamerVaapi < Formula
  desc "Hardware-accelerated video decoding, encoding and processing on Intel graphics through VA-API"
  homepage "https://github.com/GStreamer/gstreamer-vaapi/"
  url "https://gstreamer.freedesktop.org/src/gstreamer-vaapi/gstreamer-vaapi-1.12.3.tar.xz"
  sha256 "f4cdafd8fd9606a490917c8b67336e835df1219580d55421c70480fd0913744d"
  
  bottle do
    root_url "https://lfto.me/static/bottle"
    sha256 "4bfa50c447d99f6dfe9ed100d3bc59b0a7c88e4032ed40cb208d1d62a67d7840" => :x86_64_linux
  end

  head "https://github.com/GStreamer/gstreamer-vaapi.git"

  depends_on "pkg-config" => :build

  depends_on "gstreamer"
  depends_on "gst-plugins-bad"
  depends_on "wayland" => :recommended
  depends_on "libdrm" => :recommended
  depends_on "libx11" => :recommended

  def caveats
  "You must install a libva driver for this package to work. (e.g.: brew install libva-intel-driver)\n".undent
  end

  option "with-static", "Build static libraries (not recommended)"
  option "without-encoders", "Do not build encoders"
  option "with-eglx", "Add support for EGL and GLX"

  depends_on "systemd" if build.with?("libdrm")

  libva_opts = []
  libva_opts << "with-eglx" if build.with?("eglx")
  depends_on "libva" => libva_opts
  depends_on "mesa" if build.with?("eglx")

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
      --enable-encoders=#{build.with?("encoders") ? "yes" : "no"}
      --enable-drm=#{build.with?("libdrm") ? "yes" : "no"}
      --enable-x11=#{build.with?("libx11") ? "yes" : "no"}
      --enable-glx=#{build.with?("eglx") ? "yes" : "no"}
      --enable-egl=#{build.with?("eglx") ? "yes" : "no"}
      --enable-wayland=#{build.with?("wayland") ? "yes" : "no"}
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
