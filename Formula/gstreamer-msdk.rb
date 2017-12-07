class GstreamerMsdk < Formula
  desc "GStreamer plugins for Intel Media SDK"
  homepage "https://github.com/ishmael1985/gstreamer-media-SDK"
  url "https://github.com/ishmael1985/gstreamer-media-SDK/archive/2.0.0.tar.gz"
  sha256 "defdf8d943c77a2d7dd8a13748a8437c9d8cbc63fe132cd4fe90e01dae50b091"

  head "https://github.com/ishmael1985/gstreamer-media-SDK.git"

  depends_on "meson" => :build
  depends_on "ninja" => :build

  depends_on "half2me/gstreamer/gst-plugins-bad"
  depends_on "half2me/gstreamer/mfx-dispatch"
  depends_on "linuxbrew/xorg/libdrm"
  depends_on "linuxbrew/xorg/libva-intel-driver"
  depends_on "systemd"
  depends_on "libxkbcommon"
  
  depends_on "linuxbrew/xorg/mesa" => :recommended
  depends_on "linuxbrew/xorg/wayland" => :recommended
  depends_on "linuxbrew/xorg/libx11" => :recommended

  def install
    args = %W[
      --prefix=#{prefix}
      --buildtype=release
      --libdir=#{prefix}/lib/gstreamer-1.0
    ]

    # We patch the meson build file to search for "libmfx" instead of "mfx"
    file_name = "meson.build"
    text = File.read(file_name)
    new_contents = text.gsub("dependency('mfx'", "dependency('libmfx'")
    File.open(file_name, "w") {|file| file.puts new_contents }
    
    # Then we patch source files to look for mfx headers like this: "mfx/*.h"
    
    file_names = Dir["gst-libs/mfx/*.h"]
    file_names.each do |file_name|
      text = File.read(file_name)
      new1 = text.gsub("#include <mfxvideo.h>", "#include <mfx/mfxjpeg.h>")
      new_contents = new1.gsub("#include <mfxvideo.h>", "#include <mfx/mfxvideo.h>")
      File.open(file_name, "w") {|file| file.puts new_contents }
    end
    
    system "meson", "build", *args
    system "ninja", "-C", "build", "install"
  end

  test do
    gst = Formula["gstreamer"].opt_bin/"gst-inspect-1.0"
    output = shell_output("#{gst} --plugin msdk")
    assert_match version.to_s, output
  end
end
