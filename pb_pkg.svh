/* Base functionality for protobuffer based SystemVerilog classes

Encoding documentation:
  https://developers.google.com/protocol-buffers/docs/encoding#simple
*/

`ifndef __PB_PKG_SVH__
 `define __PB_PKG_SVH__

// Use +define+pb_real_rand=rand for simulators that support real number
// randomization
 `ifndef pb_real_rand
  `define pb_real_rand
 `endif

`include "uvm_macros.svh"

package pb_pkg;

   import uvm_pkg::*;

   typedef byte             bytestream_t[];
   // Using a queue to build up the bytestream for encoding,
   // otherwise it would be necessary to check and frequently resize the array.
   // Another option, assuming that sizing down a dynamic array is cheap,
   // would be to attempt to calculate the size before encoding,
   // oversize the creation, then resize down at the end.
   // However, calculation would have to be recursive because repeated embedded
   // messages may have heterogeneous sizes.
   typedef byte             enc_bytestream_t[$];
   typedef int unsigned     cursor_t;
   typedef longint unsigned varint_t;
   typedef int unsigned     field_number_t;
   typedef enum int unsigned {
                 WIRE_TYPE_VARINT = 0,
                 WIRE_TYPE_64BIT = 1,
                 WIRE_TYPE_DELIMITED = 2,
                 //WIRE_TYPE_START_GROUP = 3,
                 //WIRE_TYPE_END_GROUP = 4,
                 WIRE_TYPE_32BIT = 5
                 } wire_type_e;


   typedef enum {
                 LABEL_OPTIONAL = 1,
                 LABEL_REQUIRED = 2,
                 LABEL_REPEATED = 3
   } label_e;

   localparam MAX_VARINT_BYTES = (64 / 7) + 1; // Sanity check for maximum bytes for a varint

`include "pb_decode.svh"
`include "pb_encode.svh"
`include "pb_socket.svh"   

endpackage : pb_pkg

`endif // guard
