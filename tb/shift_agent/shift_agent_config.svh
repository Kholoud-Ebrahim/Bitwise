class shift_agent_config extends uvm_object;
    `uvm_object_utils(shift_agent_config)

    virtual shift_intf #(SRWIDTH, SROPWIDTH, SLWIDTH, SLOPWIDTH) shift_agnt_vif;
    uvm_active_passive_enum   is_active;

    function new(string name = "shift_agent_config");
        super.new(name);
    endfunction :new
endclass :shift_agent_config