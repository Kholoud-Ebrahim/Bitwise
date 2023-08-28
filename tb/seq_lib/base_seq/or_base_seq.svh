class or_base_seq extends uvm_sequence #(or_seq_item);
    `uvm_object_utils(or_base_seq)

    or_seq_item  or_item;

    function new(string name = "or_base_seq");
        super.new(name);
    endfunction

    task body();
        or_item = or_seq_item::type_id::create("or_item");
        start_item(or_item);
        assert(or_item.randomize());
        finish_item(or_item);
    endtask :body
endclass :or_base_seq