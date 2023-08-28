class and_driver extends uvm_driver #(and_seq_item);
    `uvm_component_utils(and_driver)

    and_agent_config   and_agnt_config;
    virtual and_intf #(AWIDTH) and_ag_vif;
    and_seq_item       and_item;

    function new(string name = "and_driver", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db #(and_agent_config)::get(this, "", "and_agnt_config_name", and_agnt_config)))
            `uvm_fatal(get_full_name(),"Cannot get And Agent Config from configuration database!")
    endfunction :build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        and_ag_vif = and_agnt_config.and_agnt_vif;
    endfunction :connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
            seq_item_port.get_next_item(and_item);
            drive(and_item);
            seq_item_port.item_done();
        end
    endtask :run_phase

    task drive (and_seq_item and_item);
        wait(!(and_ag_vif.rst));

        and_ag_vif.and_in1 <= and_item.and_in1;
        and_ag_vif.and_in2 <= and_item.and_in2;
        @(negedge and_ag_vif.clk);
        
    endtask :drive
endclass :and_driver