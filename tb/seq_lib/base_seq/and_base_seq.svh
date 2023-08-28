class and_base_seq extends uvm_sequence #(and_seq_item);
    `uvm_object_utils(and_base_seq)

    and_seq_item  and_item;

    function new(string name = "and_base_seq");
        super.new(name);
    endfunction

    task body();
        and_item = and_seq_item::type_id::create("and_item");
        start_item(and_item);
        assert(and_item.randomize());
        finish_item(and_item);
    endtask :body
endclass :and_base_seq