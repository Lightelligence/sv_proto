def sv_proto_library(name, srcs):
    plugin = "//:sv_plugin.py"
    native.genrule(
        name = name,
        srcs = srcs,
        outs = [f + ".sv" for f in srcs],
        cmd = "$(location @com_google_protobuf//:protoc) --plugin=protoc-gen-sv=$(location {plugin}) --sv_out=$(@D) $(SRCS)".format(plugin=plugin),
        output_to_bindir = True,
        tools = [
            plugin,
            "@com_google_protobuf//:protoc",
        ],
    )
