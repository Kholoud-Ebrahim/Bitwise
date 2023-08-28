package base_seq_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import param_pkg::*;
    import seq_item_pkg::*;

    `include "and_base_seq.svh"
    `include "or_base_seq.svh"
    `include "shift_base_seq.svh"
    `include "xor_base_seq.svh"
endpackage :base_seq_pkg