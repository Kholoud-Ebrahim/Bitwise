package all_one_seq_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import param_pkg::*;

    import seq_item_pkg::*;
    import base_seq_pkg::*;

    `include "and_all_one_seq.svh"
    `include "or_all_one_seq.svh"
    `include "shift_all_one_seq.svh"
    `include "xor_all_one_seq.svh"
endpackage :all_one_seq_pkg