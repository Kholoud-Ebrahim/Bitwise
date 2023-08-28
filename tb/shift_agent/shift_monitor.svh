class shift_monitor extends uvm_monitor;
    `uvm_component_utils(shift_monitor)

    shift_agent_config              shift_agnt_config;
    virtual shift_intf #(SRWIDTH, SROPWIDTH, SLWIDTH, SLOPWIDTH)    shift_ag_vif;
    shift_seq_item                  shift_item;

    uvm_analysis_port #(shift_seq_item) shift_mon_port;

    function new(string name = "shift_monitor", uvm_component parent);
        super.new(name, parent);

        shift_mon_port = new("shift_mon_port", this);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db #(shift_agent_config)::get(this, "", "shift_agnt_config_name", shift_agnt_config)))
            `uvm_fatal(get_full_name(),"Cannot get Shift Agent Config from configuration database!")
    endfunction :build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        shift_ag_vif = shift_agnt_config.shift_agnt_vif;
    endfunction :connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        wait(!(shift_ag_vif.rst));

        forever begin
            shift_item = shift_seq_item::type_id::create("shift_item");

            @(posedge shift_ag_vif.clk);
            #(PERIOD/4.0);
            shift_item.shift_right_in  = shift_ag_vif.shift_right_in;
            shift_item.shift_left_in   = shift_ag_vif.shift_left_in;
            shift_item.shift_right_op  = shift_ag_vif.shift_right_op;
            shift_item.shift_left_op   = shift_ag_vif.shift_left_op;

            shift_item.shift_right_out = shift_ag_vif.shift_right_out;
            shift_item.shift_left_out  = shift_ag_vif.shift_left_out;

            shift_item.print();
            shift_mon_port.write(shift_item);
        end
    endtask :run_phase
endclass :shift_monitor