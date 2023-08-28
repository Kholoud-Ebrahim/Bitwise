class xor_driver extends uvm_driver #(xor_seq_item);
    `uvm_component_utils(xor_driver)

    xor_agent_config            xor_agnt_config;
    virtual xor_intf #(XWIDTH)  xor_ag_vif;
    xor_seq_item                xor_item;
    
    function new(string name ="xor_driver", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db #(xor_agent_config)::get(this, "", "xor_agnt_config_name", xor_agnt_config)))
        `uvm_fatal(get_full_name(),"Cannot get Xor Agent Config from configuration database!")
    endfunction :build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        xor_ag_vif = xor_agnt_config.xor_agnt_vif;
    endfunction :connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            seq_item_port.get_next_item(xor_item);
            drive(xor_item);
            seq_item_port.item_done();
        end
    endtask :run_phase

    task drive(xor_seq_item xor_item);
        wait(!(xor_ag_vif.rst));

        xor_ag_vif.xor_in1 <= xor_item.xor_in1;
        xor_ag_vif.xor_in2 <= xor_item.xor_in2;
        @(negedge xor_ag_vif.clk);     
    endtask :drive
endclass :xor_driver