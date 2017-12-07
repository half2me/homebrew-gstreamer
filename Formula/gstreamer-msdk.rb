class GstreamerMsdk < Formula
  desc "GStreamer plugins for Intel Media SDK"
  homepage "https://github.com/ishmael1985/gstreamer-media-SDK"
  url "https://github.com/ishmael1985/gstreamer-media-SDK/archive/2.0.0.tar.gz"
  sha256 "defdf8d943c77a2d7dd8a13748a8437c9d8cbc63fe132cd4fe90e01dae50b091"

  head "https://github.com/ishmael1985/gstreamer-media-SDK.git"

  depends_on "meson" => :build

  depends_on "half2me/gstreamer/gst-plugins-bad"
  depends_on "libdrm"
  depends_on "libva-intel-driver"
  depends_on "systemd"
  
  depends_on "libva" => :recommended
  depends_on "mesa" => :recommended
  depends_on "wayland" => :recommended
  depends_on "libx11" => :recommended

  def install
    args = %W[
      --prefix=#{prefix}
      --buildtype=release
      --libdir=#{prefix}/lib/gstreamer-1.0
    ]

    system "meson", "build", *args
    system "ninja"
    system "ninja", "install"
  end

  test do
    gst = Formula["gstreamer"].opt_bin/"gst-inspect-1.0"
    output = shell_output("#{gst} --plugin msdk")
    assert_match version.to_s, output
  end
end
