class random_test extends base_test;
    `uvm_component_utils(random_test)

    static int i=0;
    v_random_seq    v_rand_seq;

    function new(string name = "random_test", uvm_component parent);
        super.new(name, parent);
        i++;
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        v_rand_seq = v_random_seq::type_id::create("v_rand_seq");
    endfunction :build_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        $display("random_test_counter = %0d", i);

        $display("start raise_objection");
        phase.raise_objection(this);
        $display("stop raise_objection");
        
        repeat(100) begin
            v_rand_seq.start(env.vsqr);	
        end
        #(PERIOD);

        $display("start drop_objection");
        phase.drop_objection(this);
        $display("stop drop_objection");
        
    endtask :run_phase
endclass :random_test