class or_sequencer extends uvm_sequencer #(or_seq_item);
    `uvm_component_utils(or_sequencer)

    function new(string name = "or_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction :new
endclass :or_sequencer