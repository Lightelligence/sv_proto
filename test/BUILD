load(":test.bzl", "golden_test_glob")

golden_test_glob(glob(["proto/*.proto"]))


sh_test(
    name = "pb_pkg_test",
    size = "small",
    srcs = ["passthrough.sh"],
    data = [
        "//:pb_pkg.svh",
        "pb_pkg_test.sv",
    ],
    args = ["xrun -licqueue -uvm $(location //:pb_pkg.svh) $(location pb_pkg_test.sv)"],
    tags = ["xrun"],
)
