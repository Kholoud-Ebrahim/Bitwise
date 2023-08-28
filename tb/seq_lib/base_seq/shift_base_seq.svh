class shift_base_seq extends uvm_sequence #(shift_seq_item);
    `uvm_object_utils(shift_base_seq)

    shift_seq_item  shift_item;

    function new(string name = "shift_base_seq");
        super.new(name);
    endfunction

    task body();
        shift_item = shift_seq_item::type_id::create("shift_item");
        start_item(shift_item);
        assert(shift_item.randomize());
        finish_item(shift_item);
    endtask :body
endclass :shift_base_seq