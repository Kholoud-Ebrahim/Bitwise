package shift_agent_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import param_pkg::*;

    import seq_item_pkg::*;
    `include "shift_agent_config.svh"
    `include "shift_sequencer.svh"
    `include "shift_driver.svh"
    `include "shift_monitor.svh"
    `include "shift_agent.svh"
        
endpackage :shift_agent_pkg