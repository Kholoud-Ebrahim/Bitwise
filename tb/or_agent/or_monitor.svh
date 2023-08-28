class or_monitor extends uvm_monitor;
    `uvm_component_utils(or_monitor)

    or_agent_config             or_agnt_config;
    virtual or_intf #(OWIDTH)   or_ag_vif;
    or_seq_item                 or_item;

    uvm_analysis_port #(or_seq_item) or_mon_port;

    function new(string name = "or_monitor", uvm_component parent);
        super.new(name, parent);

        or_mon_port = new("or_mon_port", this);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db #(or_agent_config)::get(this, "", "or_agnt_config_name", or_agnt_config)))
            `uvm_fatal(get_full_name(),"Cannot get Or Agent Config from configuration database!")
    endfunction :build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        or_ag_vif = or_agnt_config.or_agnt_vif;
    endfunction :connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        wait(!(or_ag_vif.rst));

        forever begin
            or_item = or_seq_item::type_id::create("or_item");

            @(posedge or_ag_vif.clk);
            #(PERIOD/4.0);
            or_item.or_in1 = or_ag_vif.or_in1;
            or_item.or_in2 = or_ag_vif.or_in2;
            or_item.or_out = or_ag_vif.or_out;
            or_item.print();
            or_mon_port.write(or_item);
        end
    endtask :run_phase
endclass :or_monitor