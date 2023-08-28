class shift_driver extends uvm_driver #(shift_seq_item);
    `uvm_component_utils(shift_driver)

    shift_agent_config   shift_agnt_config;
    virtual shift_intf #(SRWIDTH, SROPWIDTH, SLWIDTH, SLOPWIDTH)  shift_ag_vif;
    shift_seq_item       shift_item;

    function new(string name = "shift_driver", uvm_component parent);
        super.new(name, parent);
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

        forever begin
            seq_item_port.get_next_item(shift_item);
            drive(shift_item);
            seq_item_port.item_done();
        end
    endtask :run_phase

    task drive (shift_seq_item shift_item);
        wait(!(shift_ag_vif.rst));

        shift_ag_vif.shift_right_in <= shift_item.shift_right_in;
        shift_ag_vif.shift_left_in  <= shift_item.shift_left_in;
        shift_ag_vif.shift_right_op <= shift_item.shift_right_op;
        shift_ag_vif.shift_left_op  <= shift_item.shift_left_op;
        @(negedge shift_ag_vif.clk);
        
    endtask :drive

endclass :shift_driver