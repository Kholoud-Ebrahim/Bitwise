class shift_seq_item extends uvm_sequence_item;
    rand bit [SRWIDTH-1:0] shift_right_in;
    rand bit [SLWIDTH-1:0] shift_left_in;

    rand bit [SROPWIDTH-1:0] shift_right_op;
    rand bit [SLOPWIDTH-1:0] shift_left_op;

    bit [SRWIDTH-1:0] shift_right_out;
    bit [SLWIDTH-1:0] shift_left_out;

    `uvm_object_utils_begin(shift_seq_item)
        `uvm_field_int(shift_right_in , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(shift_left_in  , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(shift_right_op , UVM_DEFAULT | UVM_DEC)
        `uvm_field_int(shift_left_op  , UVM_DEFAULT | UVM_DEC)
        `uvm_field_int(shift_right_out, UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(shift_left_out , UVM_DEFAULT | UVM_BIN)
    `uvm_object_utils_end

    function new(string name = "shift_seq_item");
        super.new(name);
    endfunction :new
endclass :shift_seq_item