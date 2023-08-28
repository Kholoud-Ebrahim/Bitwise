class xor_all_zero_seq extends xor_base_seq;
    `uvm_object_utils(xor_all_zero_seq)

    xor_seq_item  xor_item;

    function new(string name = "xor_all_zero_seq");
        super.new(name);
    endfunction

    task body();
        xor_item = xor_seq_item::type_id::create("xor_item");
        start_item(xor_item);
        assert(xor_item.randomize() with {xor_in1 == {XWIDTH{1'b0}}; xor_in2 == {XWIDTH{1'b0}}; });
        finish_item(xor_item);
    endtask :body
endclass :xor_all_zero_seq