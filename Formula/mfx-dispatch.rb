class MfxDispatch < Formula
  desc "Intel media sdk dispatcher"
  homepage "https://github.com/lu-zero/mfx_dispatch"
  url "https://github.com/lu-zero/mfx_dispatch/archive/1.23.tar.gz"
  sha256 "d84db51a9d3ec6b5282fc681fba6b2c721814a6154cfc35feb422903a8d4384b"
  
  head do
    url "https://github.com/lu-zero/mfx_dispatch.git"
  end
  
  bottle do
    root_url "https://lfto.me/static/bottle"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  
  depends_on "linuxbrew/xorg/libva"
  
  depends_on "linuxbrew/xorg/libdrm" => :recomended
  depends_on "linuxbrew/xorg/libx11" => :optional

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-debug
      --disable-silent-rules
      --disable-examples
      --with-libva_drm=#{build.with?("libdrm") ? "yes" : "no"}
      --with-libva_x11=#{build.with?("libx11") ? "yes" : "no"}
    ]
    
    # patch /include folder to not use "mfx" subfolder
    file_name = "libmfx.pc.in"
    text = File.read(file_name)
    new_contents = text.gsub("includedir=@includedir@", "includedir=@includedir@/mfx")
    File.open(file_name, "w") {|file| file.puts new_contents }
    
    system "autoreconf", "-i"
    system "./configure", *args
    system "make", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test mfx_dispatch`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
