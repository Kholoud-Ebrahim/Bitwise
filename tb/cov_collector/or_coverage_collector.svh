class or_coverage_collector extends uvm_subscriber #(or_seq_item);
    `uvm_component_utils(or_coverage_collector)

    uvm_analysis_imp  #(or_seq_item  , or_coverage_collector) or_cov_imp;

    or_seq_item  or_item;
    or_seq_item  or_queue[$];

    covergroup cov_or;
        option.per_instance = 1; 
        cp_or_in1 : coverpoint or_item.or_in1 {
            bins in1_all_zeros  = { {OWIDTH{1'b0}} }; 
            bins in1_all_ones   = { {OWIDTH{1'b1}} };
            bins in1_others     = { [1:{OWIDTH{1'b1}}-1]};
        }

        cp_or_in2 : coverpoint or_item.or_in2 {
            bins in2_all_zeros  = { {OWIDTH{1'b0}} }; 
            bins in2_all_ones   = { {OWIDTH{1'b1}} }; 
            bins in2_others     = { [1:{OWIDTH{1'b1}}-1]};   
        }
        
        cp_or_out  : coverpoint or_item.or_out {
            bins out_all_zeros   = { {OWIDTH{1'b0}} }; 
            bins out_all_ones    = { {OWIDTH{1'b1}} }; 
            bins out_others      = { [1:{OWIDTH{1'b1}}-1]};
        }
    endgroup

    function new(string name = "or_coverage_collector", uvm_component parent);
        super.new(name, parent);
        or_cov_imp = new("cov_imp", this);
        cov_or = new();
    endfunction :new

    function void write (or_seq_item t);
        or_queue.push_front(t);
    endfunction :write

	task run_phase (uvm_phase phase);
        super.run_phase(phase);    
        
        forever begin
            or_item = or_seq_item::type_id::create("or_item");
            wait(or_queue.size() !=0);
            or_item  = or_queue.pop_back();
            cov_or.sample();  
        end 
    endtask :run_phase
endclass :or_coverage_collector