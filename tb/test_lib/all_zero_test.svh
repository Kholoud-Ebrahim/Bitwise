class all_zero_test extends base_test;
    `uvm_component_utils(all_zero_test)

    static int i=0;
    v_all_zero_seq    v_all_z_seq;

    function new(string name = "all_zero_test", uvm_component parent);
        super.new(name, parent);
        i++;
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        v_all_z_seq = v_all_zero_seq::type_id::create("v_all_z_seq");
    endfunction :build_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        $display("all_zero_test_counter = %0d", i);

        $display("start raise_objection");
        phase.raise_objection(this);
        $display("stop raise_objection");
        
        repeat(20) begin
            v_all_z_seq.start(env.vsqr);	
        end
        #(PERIOD);

        $display("start drop_objection");
        phase.drop_objection(this);
        $display("stop drop_objection");
        
    endtask :run_phase
endclass :all_zero_test