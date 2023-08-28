package cov_collect_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import param_pkg::*;
    import seq_item_pkg::*;
    
    `include "and_coverage_collector.svh"
    `include "or_coverage_collector.svh"
    `include "shift_coverage_collector.svh"
    `include "xor_coverage_collector.svh"
endpackage :cov_collect_pkg