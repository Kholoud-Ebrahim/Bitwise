package bitwise_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // 1.param pkgs 
    import param_pkg::*;

    // 2.items pkg
    import seq_item_pkg::*;

    // 3.agent pkgs 
    import and_agent_pkg::*;
    import or_agent_pkg::*;
    import shift_agent_pkg::*;
    import xor_agent_pkg::*;

    // 4.sequence pkgs
    import random_seq_pkg::*;
    import all_zero_seq_pkg::*;
    import all_one_seq_pkg::*;
    
    // 5.subscribers
    `include "bitwise_scoreboard.svh"
    import cov_collect_pkg::*;

    // 6.virtual sequencer
    `include "virtual_sequencer.svh"

    // 7.environment
    `include "bitwise_env_config.svh"
    `include "bitwise_env.svh"

    // 8.virtual sequences
    `include "virtual_sequence.svh"
    `include "v_random_seq.svh"
    `include "v_all_zero_seq.svh"
    `include "v_all_one_seq.svh"

    // 9.tests
    `include "base_test.svh"
    `include "random_test.svh"
    `include "all_zero_test.svh"
    `include "all_one_test.svh"
endpackage :bitwise_pkg