package example;

  `include "uvm_macros.svh"
  import uvm_pkg::*;

  class Hello extends uvm_object;

    string name;

    `uvm_object_utils_begin(Hello)
      `uvm_field_string(name, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name="Hello");
       super.new(.name(name));
    endfunction : new

  endclass : Hello


endpackage : example
