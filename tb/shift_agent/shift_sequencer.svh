class shift_sequencer extends uvm_sequencer #(shift_seq_item);
    `uvm_component_utils(shift_sequencer)

    function new(string name = "shift_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction :new
endclass :shift_sequencer