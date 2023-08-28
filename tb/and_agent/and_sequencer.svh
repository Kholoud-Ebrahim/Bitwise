class and_sequencer extends uvm_sequencer #(and_seq_item);
    `uvm_component_utils(and_sequencer)

    function new(string name = "and_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction :new
endclass :and_sequencer