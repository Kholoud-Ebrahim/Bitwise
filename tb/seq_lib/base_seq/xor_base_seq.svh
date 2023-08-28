class xor_base_seq extends uvm_sequence #(xor_seq_item);
    `uvm_object_utils(xor_base_seq)

    xor_seq_item  xor_item;

    function new(string name = "xor_base_seq");
        super.new(name);
    endfunction

    task body();
        xor_item = xor_seq_item::type_id::create("xor_item");
        start_item(xor_item);
        assert(xor_item.randomize());
        finish_item(xor_item);
    endtask :body
endclass :xor_base_seq