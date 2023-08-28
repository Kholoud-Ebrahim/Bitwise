package random_seq_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import param_pkg::*;
    import seq_item_pkg::*;
    
    import base_seq_pkg::*;
    
    `include "and_random_seq.svh"
    `include "or_random_seq.svh"
    `include "shift_random_seq.svh"
    `include "xor_random_seq.svh"
endpackage :random_seq_pkg