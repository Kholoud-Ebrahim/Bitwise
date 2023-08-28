class and_agent_config extends uvm_object;
    `uvm_object_utils(and_agent_config)

    virtual and_intf #(AWIDTH) and_agnt_vif;
    uvm_active_passive_enum    is_active;

    function new(string name = "and_agent_config");
        super.new(name);
    endfunction :new
endclass :and_agent_config