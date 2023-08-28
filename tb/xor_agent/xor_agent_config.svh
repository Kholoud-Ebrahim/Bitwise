class xor_agent_config extends uvm_object;
    `uvm_object_utils(xor_agent_config)

    virtual xor_intf #(XWIDTH) xor_agnt_vif;
    uvm_active_passive_enum    is_active;

    function new(string name = "xor_agent_config");
        super.new(name);
    endfunction :new
endclass :xor_agent_config