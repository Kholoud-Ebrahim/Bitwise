class or_agent extends uvm_agent;
    `uvm_component_utils(or_agent)

    or_sequencer    or_sqr;
    or_driver       or_drv;
    or_monitor      or_mon;

    or_agent_config             or_agnt_config;
    uvm_active_passive_enum     is_active;

    uvm_analysis_port #(or_seq_item) or_mon2agnt_port;

    function new(string name = "or_agent", uvm_component parent);
        super.new(name, parent);

        or_mon2agnt_port = new("or_mon2agnt_port", this);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db #(or_agent_config)::get(this, "", "or_agnt_config_name", or_agnt_config)))
            `uvm_fatal(get_full_name(),"Cannot get Or Agent Config from configuration database!")

        is_active = or_agnt_config.is_active;

        if(is_active == UVM_ACTIVE) begin
            or_sqr = or_sequencer::type_id::create("or_sqr", this);
            or_drv = or_driver::type_id::create("or_drv", this);
        end
        or_mon = or_monitor::type_id::create("or_mon", this);
    endfunction :build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        if(is_active == UVM_ACTIVE) begin
            or_drv.seq_item_port.connect(or_sqr.seq_item_export);
        end

        or_mon.or_mon_port.connect(or_mon2agnt_port);
    endfunction :connect_phase
endclass :or_agent