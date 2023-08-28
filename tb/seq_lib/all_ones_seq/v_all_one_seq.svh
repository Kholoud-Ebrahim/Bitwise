class v_all_one_seq extends virtual_sequence;
    `uvm_object_utils(v_all_one_seq)

    and_all_one_seq     a_seq;
    or_all_one_seq      o_seq;
    shift_all_one_seq   s_seq;
    xor_all_one_seq     x_seq;

    function new(string name = "v_all_one_seq");
        super.new(name);
    endfunction :new

    task body();
        super.body();
        a_seq = and_all_one_seq  ::type_id::create("a_seq");
        o_seq = or_all_one_seq   ::type_id::create("o_seq");
        s_seq = shift_all_one_seq::type_id::create("s_seq");
        x_seq = xor_all_one_seq  ::type_id::create("x_seq");

        fork
            a_seq.start(and_seq_sqr);
            o_seq.start(or_seq_sqr);
            s_seq.start(shift_seq_sqr);
            x_seq.start(xor_seq_sqr);
        join
    endtask :body
endclass :v_all_one_seq