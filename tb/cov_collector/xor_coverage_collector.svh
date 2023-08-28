class xor_coverage_collector extends uvm_subscriber #(xor_seq_item);
    `uvm_component_utils(xor_coverage_collector)

    uvm_analysis_imp  #(xor_seq_item  , xor_coverage_collector) xor_cov_imp;

    xor_seq_item  xor_item;
    xor_seq_item  xor_queue[$];

    covergroup cov_xor;
        option.per_instance = 1; 
        cp_xor_in1 : coverpoint xor_item.xor_in1 {
            bins in1_all_zeros  = { {OWIDTH{1'b0}} }; 
            bins in1_all_ones   = { {OWIDTH{1'b1}} };
            bins in1_others     = { [1:{OWIDTH{1'b1}}-1]};
        }

        cp_xor_in2 : coverpoint xor_item.xor_in2 {
            bins in2_all_zeros  = { {OWIDTH{1'b0}} }; 
            bins in2_all_ones   = { {OWIDTH{1'b1}} }; 
            bins in2_others     = { [1:{OWIDTH{1'b1}}-1]};   
        }
        
        cp_xor_out  : coverpoint xor_item.xor_out {
            bins out_all_zeros   = { {OWIDTH{1'b0}} }; 
            bins out_all_ones    = { {OWIDTH{1'b1}} }; 
            bins out_others      = { [1:{OWIDTH{1'b1}}-1]};
        }
    endgroup
    
    function new(string name = "xor_coverage_collector", uvm_component parent);
        super.new(name, parent);
        xor_cov_imp = new("cov_imp", this);
        cov_xor = new();
    endfunction :new

    function void write (xor_seq_item t);
        xor_queue.push_front(t);
    endfunction :write

	task run_phase (uvm_phase phase);
        super.run_phase(phase);    
        
        forever begin
            xor_item = xor_seq_item::type_id::create("xor_item");
            wait(xor_queue.size() !=0);
            xor_item  = xor_queue.pop_back();
            cov_xor.sample();  
        end 
    endtask :run_phase
endclass :xor_coverage_collector