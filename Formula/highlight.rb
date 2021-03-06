class Highlight < Formula
  desc "Convert source code to formatted text with syntax highlighting"
  homepage "http://www.andre-simon.de/doku/highlight/en/highlight.html"
  url "http://www.andre-simon.de/zip/highlight-3.41.tar.bz2"
  sha256 "3909986041d40b1d0d3e00cb3b6043b0fbff6fd6a452696fb4eec495b6536722"
  revision 1
  head "https://github.com/andre-simon/highlight.git"

  bottle do
    sha256 "728512b1c96963324e3c3a60c9715f5a9de837af518b0413788d6f55419a7d63" => :high_sierra
    sha256 "882957703a9de931919b6911a2699ce25b92626794b4e13c2254a78484663750" => :sierra
    sha256 "0b8c101d8f592b2dd8797003d32b4bb186a0a450a5e109c7b20c1ff63537c745" => :el_capitan
    sha256 "5fc0877fb31d440da3acadb1d94d6fac8125803b0c53868082a6e1dd155fbc5c" => :x86_64_linux
  end

  depends_on "boost" => :build
  depends_on "pkg-config" => :build
  depends_on "lua"

  def install
    # Reduce memory usage below 4 GB for Circle CI.
    ENV["MAKEFLAGS"] = "-j8" if ENV["CIRCLECI"]

    conf_dir = etc/"highlight/" # highlight needs a final / for conf_dir
    system "make", "PREFIX=#{prefix}", "conf_dir=#{conf_dir}"
    system "make", "PREFIX=#{prefix}", "conf_dir=#{conf_dir}", "install"
  end

  test do
    system bin/"highlight", doc/"extras/highlight_pipe.php"
  end
end
