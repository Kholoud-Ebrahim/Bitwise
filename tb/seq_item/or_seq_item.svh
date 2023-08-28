class or_seq_item extends uvm_sequence_item;
    rand bit [OWIDTH-1:0] or_in1;
    rand bit [OWIDTH-1:0] or_in2;

    bit [OWIDTH-1:0] or_out;

    `uvm_object_utils_begin(or_seq_item)
        `uvm_field_int(or_in1, UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(or_in2, UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(or_out, UVM_DEFAULT | UVM_BIN)
    `uvm_object_utils_end

    function new(string name = "or_seq_item");
        super.new(name);
    endfunction :new
endclass :or_seq_item