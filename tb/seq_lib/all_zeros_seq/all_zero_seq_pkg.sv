package all_zero_seq_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import param_pkg::*;

    import seq_item_pkg::*;
    import base_seq_pkg::*;
    
    `include "and_all_zero_seq.svh"
    `include "or_all_zero_seq.svh"
    `include "shift_all_zero_seq.svh"
    `include "xor_all_zero_seq.svh"
endpackage :all_zero_seq_pkg