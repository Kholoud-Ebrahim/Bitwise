class virtual_sequence extends uvm_sequence #(uvm_sequence_item);
    `uvm_object_utils(virtual_sequence)

    virtual_sequencer     v_seq_sqr;

    and_sequencer    and_seq_sqr;
    or_sequencer     or_seq_sqr;
    shift_sequencer  shift_seq_sqr;
    xor_sequencer    xor_seq_sqr;

    function new(string name = "virtual_sequence");
        super.new(name);
    endfunction :new

    task body();
        if(!($cast(v_seq_sqr, m_sequencer)))
            `uvm_error(get_full_name(),"Virtual sequencer pointer cast failed")
        
        and_seq_sqr   = v_seq_sqr.and_sqr_env_h;
        or_seq_sqr    = v_seq_sqr.or_sqr_env_h;
        shift_seq_sqr = v_seq_sqr.shift_sqr_env_h;
        xor_seq_sqr   = v_seq_sqr.xor_sqr_env_h;      
    endtask :body

endclass :virtual_sequence