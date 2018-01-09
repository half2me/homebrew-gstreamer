class IntelVaapiDriver < Formula
  desc "VA-API user mode driver for Intel GEN Graphics family"
  homepage "https://01.org/linuxmedia"
  url "https://github.com/01org/intel-vaapi-driver/releases/download/2.0.0/intel-vaapi-driver-2.0.0.tar.bz2"
  sha256 "10f6b0a91f34715d8d4d9a9e0fb3cc0afe5fcf85355db1272bd5fff31522f469"
  
  head do
    url "https://github.com/01org/intel-vaapi-driver.git"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "false"
  end
end
