def sv_proto_library(name, srcs):
    """Generate a SystemVerilog file from a .proto file.
    
    Ideally this would be using the proto_gen rule from com_google_protobuf,
    but there seems to be a bug in that rule when using a plugin. Haven't
    actually filed the issue yet.
    """
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
