class or_driver extends uvm_driver #(or_seq_item);
    `uvm_component_utils(or_driver)

    or_agent_config             or_agnt_config;
    virtual or_intf #(OWIDTH)   or_ag_vif;
    or_seq_item                 or_item;

    function new(string name = "or_driver", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db #(or_agent_config)::get(this, "", "or_agnt_config_name", or_agnt_config)))
            `uvm_fatal(get_full_name(),"Cannot get OR Agent Config from configuration database!")

    endfunction :build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        or_ag_vif = or_agnt_config.or_agnt_vif;
    endfunction :connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
            seq_item_port.get_next_item(or_item);
            drive(or_item);
            seq_item_port.item_done();
        end
    endtask :run_phase

    task drive(or_seq_item or_item);
        wait(!(or_ag_vif.rst));

        or_ag_vif.or_in1 <= or_item.or_in1;
        or_ag_vif.or_in2 <= or_item.or_in2;
        @(negedge or_ag_vif.clk);
        
    endtask :drive
    
endclass :or_driver