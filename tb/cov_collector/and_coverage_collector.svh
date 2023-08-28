class and_coverage_collector extends uvm_subscriber #(and_seq_item);
    `uvm_component_utils(and_coverage_collector)

    uvm_analysis_imp  #(and_seq_item  , and_coverage_collector) and_cov_imp;

    and_seq_item  and_item;
    and_seq_item  and_queue[$];

    covergroup cov_and;
        option.per_instance = 1; 
        cp_and_in1 : coverpoint and_item.and_in1 {
            bins in1_all_zeros  = { {AWIDTH{1'b0}} }; 
            bins in1_all_ones   = { {AWIDTH{1'b1}} };
            bins in1_others     = { [1:{AWIDTH{1'b1}}-1]};
        }

        cp_and_in2 : coverpoint and_item.and_in2 {
            bins in2_all_zeros  = { {AWIDTH{1'b0}} }; 
            bins in2_all_ones   = { {AWIDTH{1'b1}} }; 
            bins in2_others     = { [1:{AWIDTH{1'b1}}-1]};   
        }
        
        cp_and_out  : coverpoint and_item.and_out {
            bins out_all_zeros   = { {AWIDTH{1'b0}} }; 
            bins out_all_ones    = { {AWIDTH{1'b1}} }; 
            bins out_others      = { [1:{AWIDTH{1'b1}}-1]};
        }
    endgroup

    function new(string name = "and_coverage_collector", uvm_component parent);
        super.new(name, parent);
        and_cov_imp = new("cov_imp", this);
        cov_and = new();
    endfunction :new

    function void write (and_seq_item t);
        and_queue.push_front(t);
    endfunction :write

	task run_phase (uvm_phase phase);
        super.run_phase(phase);    
        
        forever begin
            and_item = and_seq_item::type_id::create("and_item");
            wait(and_queue.size() !=0);
            and_item  = and_queue.pop_back();
            cov_and.sample();  
        end 
    endtask :run_phase
endclass :and_coverage_collector