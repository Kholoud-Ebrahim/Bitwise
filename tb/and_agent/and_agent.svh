class and_agent extends uvm_agent;
    `uvm_component_utils(and_agent)

    and_sequencer    and_sqr;
    and_driver       and_drv;
    and_monitor      and_mon;

    and_agent_config            and_agnt_config;
    uvm_active_passive_enum     is_active;

    uvm_analysis_port #(and_seq_item) and_mon2agnt_port;

    function new(string name = "and_agent", uvm_component parent);
        super.new(name, parent);

        and_mon2agnt_port = new("and_mon2agnt_port", this);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db #(and_agent_config)::get(this, "", "and_agnt_config_name", and_agnt_config)))
            `uvm_fatal(get_full_name(),"Cannot get And Agent Config from configuration database!")

        is_active = and_agnt_config.is_active;

        if(is_active == UVM_ACTIVE) begin
            and_sqr = and_sequencer::type_id::create("and_sqr", this);
            and_drv = and_driver::type_id::create("and_drv", this);
        end
        and_mon = and_monitor::type_id::create("and_mon", this);
    endfunction :build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        if(is_active == UVM_ACTIVE) begin
            and_drv.seq_item_port.connect(and_sqr.seq_item_export);
        end

        and_mon.and_mon_port.connect(and_mon2agnt_port);
    endfunction :connect_phase
endclass :and_agent