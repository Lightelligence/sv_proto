# -*- mode: python -*-
workspace(name = "sv_proto")

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "com_google_protobuf",
    commit = "fe1790ca0df67173702f70d5646b82f48f412b99",
    remote = "https://github.com/protocolbuffers/protobuf",
    # shallow_since = "1558721209 -0700",
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

git_repository(
    name = "verilog_tools",
    # path = "../verilog_tools",
    tag = "v0.0.5",
    remote = "git@ssh.dev.azure.com:v3/LightelligencePlatform/verilog_tools/verilog_tools",
)

load("@verilog_tools//:simulator.bzl", "xcelium_setup")
xcelium_setup(name="xcelium")
