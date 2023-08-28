class xor_agent extends uvm_agent;
    `uvm_component_utils(xor_agent)

    xor_sequencer    xor_sqr;
    xor_driver       xor_drv;
    xor_monitor      xor_mon;

    xor_agent_config            xor_agnt_config;
    uvm_active_passive_enum     is_active;

    uvm_analysis_port #(xor_seq_item) xor_mon2agnt_port;

    function new(string name = "xor_agent", uvm_component parent);
        super.new(name, parent);

        xor_mon2agnt_port = new("xor_mon2agnt_port", this);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db #(xor_agent_config)::get(this, "", "xor_agnt_config_name", xor_agnt_config)))
            `uvm_fatal(get_full_name(),"Cannot get Xor Agent Config from configuration database!")

        is_active = xor_agnt_config.is_active;

        if(is_active == UVM_ACTIVE) begin
            xor_sqr = xor_sequencer::type_id::create("xor_sqr", this);
            xor_drv = xor_driver::type_id::create("xor_drv", this);
        end
        xor_mon = xor_monitor::type_id::create("xor_mon", this);
    endfunction :build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        if(is_active == UVM_ACTIVE) begin
            xor_drv.seq_item_port.connect(xor_sqr.seq_item_export);
        end

        xor_mon.xor_mon_port.connect(xor_mon2agnt_port);
    endfunction :connect_phase
endclass :xor_agent