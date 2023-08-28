class xor_seq_item extends uvm_sequence_item;
    rand bit [XWIDTH-1:0] xor_in1;
    rand bit [XWIDTH-1:0] xor_in2;
   
    bit [XWIDTH-1:0] xor_out;

    `uvm_object_utils_begin(xor_seq_item)
        `uvm_field_int(xor_in1, UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(xor_in2, UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(xor_out, UVM_DEFAULT | UVM_BIN)
    `uvm_object_utils_end

    function new(string name = "xor_seq_item");
        super.new(name);
    endfunction :new
endclass :xor_seq_item