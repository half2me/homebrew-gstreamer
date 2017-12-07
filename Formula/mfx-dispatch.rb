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
    sha256 "c78743fbfe8a8b0a3c39e9469bbc4f8dffe728bb6e8067b7b6fdc32c8c117774" => :x86_64_linux
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "autoreconf", "-i"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
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
