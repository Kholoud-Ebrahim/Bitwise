package xor_agent_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import param_pkg::*;

    import seq_item_pkg::*;
    `include "xor_agent_config.svh"
    `include "xor_sequencer.svh"
    `include "xor_driver.svh"
    `include "xor_monitor.svh"
    `include "xor_agent.svh"
        
endpackage :xor_agent_pkg