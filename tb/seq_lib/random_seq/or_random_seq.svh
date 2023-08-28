class or_random_seq extends or_base_seq;
    `uvm_object_utils(or_random_seq)

    or_seq_item  or_item;

    function new(string name = "or_random_seq");
        super.new(name);
    endfunction

    task body();
        or_item = or_seq_item::type_id::create("or_item");
        start_item(or_item);
        assert(or_item.randomize() with {or_in1 != {OWIDTH{1'b0}}; or_in1 != {OWIDTH{1'b1}};
                                        or_in2 != {OWIDTH{1'b0}}; or_in2 != {OWIDTH{1'b1}};
                                        });
        finish_item(or_item);
    endtask :body
endclass :or_random_seq