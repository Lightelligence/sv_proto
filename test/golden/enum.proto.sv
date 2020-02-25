package example;

  `include "uvm_macros.svh"
  import uvm_pkg::*;

  typedef enum {
    NONE = 0,
    MR = 1,
    MRS = 2,
    MISS = 3
  } Greeting;


  class Hello extends uvm_object;

    Greeting greeting;
    string name;

    `uvm_object_utils_begin(Hello)
      `uvm_field_enum(Greeting, greeting, UVM_ALL_ON)
      `uvm_field_string(name, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name="Hello");
       super.new(.name(name));
    endfunction : new

  endclass : Hello


endpackage : example
