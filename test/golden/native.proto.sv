  `include "uvm_macros.svh"
  import uvm_pkg::*;

  class Hello extends uvm_object;

    string name;
    int age;
    int unsigned old_age;
    longint unsigned dinosaur_age;
    longint maybe_negative;
    real mean;
    real avg;

    `uvm_object_utils_begin(Hello)
      `uvm_field_string(name, UVM_ALL_ON)
      `uvm_field_int(age, UVM_ALL_ON)
      `uvm_field_int(old_age, UVM_ALL_ON)
      `uvm_field_int(dinosaur_age, UVM_ALL_ON)
      `uvm_field_int(maybe_negative, UVM_ALL_ON)
      `uvm_field_real(mean, UVM_ALL_ON)
      `uvm_field_real(avg, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name="Hello");
       super.new(.name(name));
    endfunction : new

  endclass : Hello


