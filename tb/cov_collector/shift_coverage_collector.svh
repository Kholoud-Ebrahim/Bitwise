class shift_coverage_collector extends uvm_subscriber #(shift_seq_item);
    `uvm_component_utils(shift_coverage_collector)

    uvm_analysis_imp  #(shift_seq_item  , shift_coverage_collector) shift_cov_imp;

    shift_seq_item  shift_item;
    shift_seq_item  shift_queue[$];

    covergroup cov_shift;
        option.per_instance = 1; 
        cp_sr_in   : coverpoint shift_item.shift_right_in {
            option.auto_bin_max = 4;
        }
        cp_sr_op   : coverpoint shift_item.shift_right_op {
            bins cp_sl_op = {[0:SROPWIDTH+1]};
        }
        cp_sr_out  : coverpoint shift_item.shift_right_out {
            option.auto_bin_max = 4;
        }
        cp_sl_in   : coverpoint shift_item.shift_left_in {
            option.auto_bin_max = 4;
        }
        cp_sl_op   : coverpoint shift_item.shift_left_op {
            option.auto_bin_max = 3;
            bins cp_sl_op = {[0:SLOPWIDTH+1]};
        }
        cp_sl_out  : coverpoint shift_item.shift_left_out {
            option.auto_bin_max = 4;
        }
    endgroup

    function new(string name = "shift_coverage_collector", uvm_component parent);
        super.new(name, parent);
        shift_cov_imp = new("cov_imp", this);
        cov_shift = new();
    endfunction :new

    function void write (shift_seq_item t);
        shift_queue.push_front(t);
    endfunction :write

	task run_phase (uvm_phase phase);
        super.run_phase(phase);    
        
        forever begin
            shift_item = shift_seq_item::type_id::create("shift_item");
            wait(shift_queue.size() !=0);
            shift_item  = shift_queue.pop_back();
            cov_shift.sample();  
        end 
    endtask :run_phase
endclass :shift_coverage_collector