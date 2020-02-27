from test.proto.native_pb2 import Hello

def hex_string_to_sv_byte_array_initializer(string):
    assert (len(string) % 2) == 0

    out_bytes = []
    for i in range(0, len(string), 2):
        byte = string[i:i+2]
        out_bytes.append(byte)

    return "'{%s};" % ", ".join(["8'h{}".format(byte) for byte in out_bytes])
    

class UnitTest():
    def __init__(self, test_name, values):
        self.test_name = test_name
        self.values = values


    def create_test(self):
        h = Hello()
        for key, value in self.values.items():
            setattr(h, key, value)

        content = (f"  function automatic void {self.test_name}();\n"
                    '    Hello h = Hello::type_id::create("Hello");\n'
                   f'    bytestream_t stream = {hex_string_to_sv_byte_array_initializer(h.SerializeToString().hex())}\n'
                    '    h.deserialize(stream);\n'
                    '    h.print();\n')

        for key, value in self.values.items():
            if type(value) == int:
                content += f"    assert (h.{key} == {value});\n"
            elif type(value) == str:
                content += f"    assert (h.{key} == \"{value}\");\n"
            elif type(value) == float:
                # Floats don't compare well in sv
                pass

        content += "  endfunction"
        return content


if __name__ == '__main__':

    tests = []
    tests.append(UnitTest("test1",
                          values = {
                              'name' : "wil",
                              'dinosaur_age' : 24000000,
                              'maybe_negative' : -7,
                              'mean' : 0.51,
                          }))

    tests.append(UnitTest("test2",
                          values = {
                              'name' : "dan",
                              'dinosaur_age' : 42000000,
                              'maybe_negative' : 9,
                              'mean' : 200.12,
                          }))

    tests.append(UnitTest("test3",
                          values = {
                              'name' : "guoqi",
                              'dinosaur_age' : 111111111,
                              'maybe_negative' : -1,
                              'mean' : 100.2,
                          }))

    print("import pb_pkg::*;")
    
    for ut in tests:
        print(ut.create_test())

    print("")
    print("module tb_top;")
    print("  initial begin")
    for ut in tests:
        print(f"    {ut.test_name}();")
    print("  end")
    print("endmodule : tb_top;")
