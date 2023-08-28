class shift_all_zero_seq extends shift_base_seq;
    `uvm_object_utils(shift_all_zero_seq)

    shift_seq_item  shift_item;

    function new(string name = "shift_all_zero_seq");
        super.new(name);
    endfunction

    task body();
        shift_item = shift_seq_item::type_id::create("shift_item");
        start_item(shift_item);
        assert(shift_item.randomize() with {shift_right_in == {SRWIDTH{1'b0}};
                                            shift_left_in  == {SLWIDTH{1'b0}};
                                            shift_right_op > 0; shift_right_op < SROPWIDTH+1;
                                            shift_left_op  > 0; shift_left_op  < SLOPWIDTH+1;
                                           });
        finish_item(shift_item);
    endtask :body
endclass :shift_all_zero_seq