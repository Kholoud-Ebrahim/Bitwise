class xor_sequencer extends uvm_sequencer #(xor_seq_item);
    `uvm_component_utils(xor_sequencer)

    function new(string name = "xor_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction :new
endclass :xor_sequencer