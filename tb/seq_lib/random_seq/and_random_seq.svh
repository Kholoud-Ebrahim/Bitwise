class and_random_seq extends and_base_seq;
    `uvm_object_utils(and_random_seq)

    and_seq_item  and_item;

    function new(string name = "and_random_seq");
        super.new(name);
    endfunction

    task body();
        and_item = and_seq_item::type_id::create("and_item");
        start_item(and_item);
        assert(and_item.randomize() with {and_in1 != {AWIDTH{1'b0}}; and_in1 != {AWIDTH{1'b1}};
                                          and_in2 != {AWIDTH{1'b0}}; and_in2 != {AWIDTH{1'b1}};
                                         });
        finish_item(and_item);
    endtask :body
endclass :and_random_seq