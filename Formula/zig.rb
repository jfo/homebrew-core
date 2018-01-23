class Zig < Formula
  desc "Programming language designed for robustness, optimality, and clarity"
  homepage "http://ziglang.org/"
  url "https://s3.amazonaws.com/ziglang.org/download/0.1.1/zig-0.1.1.tar.xz"
  sha256 "a160d14aecebead2f8c574b0dd687cdfecc53d149d521a17b89b629d8b558c94"

  depends_on "cmake" => :build
  depends_on "llvm"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"hello.zig").write <<~EOS
      const io = @import("std").io;
      pub fn main() -> %void {
          %%io.stdout.printf("Hello, world!");
      }
    EOS
    system "#{bin}/zig", "build-exe", "hello.zig"
    assert_equal "Hello, world!", shell_output("./hello")
  end
end
