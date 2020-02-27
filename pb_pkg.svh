/* Base functionality for protobuffer based SystemVerilog classes

Encoding documentation:
  https://developers.google.com/protocol-buffers/docs/encoding#simple
*/

`ifndef __PB_PKG_SVH__
 `define __PB_PKG_SVH__

package pb_pkg;

   typedef byte             bytestream_t[];
   typedef int unsigned     cursor_t;
   typedef longint unsigned varint_t;
   typedef int unsigned     field_number_t;
   typedef int unsigned     wire_type_t;

   typedef enum {
                 LABEL_OPTIONAL = 1,
                 LABEL_REQUIRED = 2,
                 LABEL_REPEATED = 3
   } label_e;

   localparam MAX_VARINT_BYTES = (64 / 7) + 1; // Sanity check for maximum bytes for a varint

`include "pb_decode.svh"
`include "pb_encode.svh"

endpackage : pb_pkg

`endif // guard
