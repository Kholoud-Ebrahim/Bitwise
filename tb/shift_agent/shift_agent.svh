class shift_agent extends uvm_agent;
    `uvm_component_utils(shift_agent)

    shift_sequencer    shift_sqr;
    shift_driver       shift_drv;
    shift_monitor      shift_mon;

    shift_agent_config          shift_agnt_config;
    uvm_active_passive_enum     is_active;

    uvm_analysis_port #(shift_seq_item) shift_mon2agnt_port;

    function new(string name = "shift_agent", uvm_component parent);
        super.new(name, parent);

        shift_mon2agnt_port = new("shift_mon2agnt_port", this);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db #(shift_agent_config)::get(this, "", "shift_agnt_config_name", shift_agnt_config)))
            `uvm_fatal(get_full_name(),"Cannot get Shift Agent Config from configuration database!")

        is_active = shift_agnt_config.is_active;

        if(is_active == UVM_ACTIVE) begin
            shift_sqr = shift_sequencer::type_id::create("shift_sqr", this);
            shift_drv = shift_driver::type_id::create("shift_drv", this);
        end
        shift_mon = shift_monitor::type_id::create("shift_mon", this);
    endfunction :build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        if(is_active == UVM_ACTIVE) begin
            shift_drv.seq_item_port.connect(shift_sqr.seq_item_export);
        end

        shift_mon.shift_mon_port.connect(shift_mon2agnt_port);
    endfunction :connect_phase
endclass :shift_agent