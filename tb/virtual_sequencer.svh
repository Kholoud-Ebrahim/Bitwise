class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);
    `uvm_component_utils(virtual_sequencer)

    and_sequencer    and_sqr_env_h;
    or_sequencer     or_sqr_env_h;
    shift_sequencer  shift_sqr_env_h;
    xor_sequencer    xor_sqr_env_h;

    function new(string name = "virtual_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction :new
endclass :virtual_sequencer