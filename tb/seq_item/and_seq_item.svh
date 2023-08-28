class and_seq_item extends uvm_sequence_item;
    rand bit [AWIDTH-1:0] and_in1;
    rand bit [AWIDTH-1:0] and_in2;
    
    bit [AWIDTH-1:0] and_out;

    `uvm_object_utils_begin(and_seq_item)
        `uvm_field_int(and_in1, UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(and_in2, UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(and_out, UVM_DEFAULT | UVM_BIN)
    `uvm_object_utils_end

    function new(string name = "and_seq_item");
        super.new(name);
    endfunction :new
endclass :and_seq_item