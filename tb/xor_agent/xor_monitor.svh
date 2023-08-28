class xor_monitor extends uvm_monitor;
    `uvm_component_utils(xor_monitor)

    xor_agent_config              xor_agnt_config;
    virtual xor_intf #(XWIDTH)    xor_ag_vif;
    xor_seq_item                  xor_item;

    uvm_analysis_port #(xor_seq_item) xor_mon_port;

    function new(string name = "xor_monitor", uvm_component parent);
        super.new(name, parent);

        xor_mon_port = new("xor_mon_port", this);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db #(xor_agent_config)::get(this, "", "xor_agnt_config_name", xor_agnt_config)))
            `uvm_fatal(get_full_name(),"Cannot get xor Agent Config from configuration database!")
    endfunction :build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        xor_ag_vif = xor_agnt_config.xor_agnt_vif;
    endfunction :connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        wait(!(xor_ag_vif.rst));

        forever begin
            xor_item = xor_seq_item::type_id::create("xor_item");

            @(posedge xor_ag_vif.clk);
            #(PERIOD/4.0);
            xor_item.xor_in1 = xor_ag_vif.xor_in1;
            xor_item.xor_in2 = xor_ag_vif.xor_in2;
            xor_item.xor_out = xor_ag_vif.xor_out;
            xor_item.print();
            xor_mon_port.write(xor_item);
        end
    endtask :run_phase
endclass :xor_monitor