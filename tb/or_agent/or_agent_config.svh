class or_agent_config extends uvm_object;
    `uvm_object_utils(or_agent_config)

    virtual or_intf #(OWIDTH) or_agnt_vif;
    uvm_active_passive_enum   is_active;

    function new(string name = "or_agent_config");
        super.new(name);
    endfunction :new
endclass :or_agent_config