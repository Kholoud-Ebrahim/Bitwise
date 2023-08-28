class and_monitor extends uvm_monitor;
    `uvm_component_utils(and_monitor)

    and_agent_config            and_agnt_config;
    virtual and_intf #(AWIDTH)  and_ag_vif;
    and_seq_item                and_item;

    uvm_analysis_port #(and_seq_item) and_mon_port;

    function new(string name ="and_monitor", uvm_component parent);
        super.new(name, parent);

        and_mon_port = new("and_mon_port", this);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db #(and_agent_config)::get(this, "", "and_agnt_config_name",and_agnt_config)))
            `uvm_fatal(get_full_name(),"Cannot get And Agent Config from configuration database!")

    endfunction :build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        and_ag_vif = and_agnt_config.and_agnt_vif;
    endfunction :connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        wait(!(and_ag_vif.rst));

        forever begin
            and_item = and_seq_item::type_id::create("and_item");

            @(posedge and_ag_vif.clk);
            #(PERIOD/4.0);
            and_item.and_in1 = and_ag_vif.and_in1;
            and_item.and_in2 = and_ag_vif.and_in2;
            and_item.and_out = and_ag_vif.and_out;
            and_item.print();
            and_mon_port.write(and_item);
        end
    endtask :run_phase

endclass :and_monitor