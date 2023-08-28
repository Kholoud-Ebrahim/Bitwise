class bitwise_env_config extends uvm_object;
    `uvm_object_utils(bitwise_env_config)

    and_agent_config         and_env_config;
    or_agent_config          or_env_config;
    shift_agent_config       shift_env_config;
    xor_agent_config         xor_env_config;

    uvm_active_passive_enum  and_env_is_active;
    uvm_active_passive_enum  or_env_is_active;
    uvm_active_passive_enum  shift_env_is_active;
    uvm_active_passive_enum  xor_env_is_active;

    virtual and_intf   #(AWIDTH) and_env_vif;
    virtual or_intf    #(OWIDTH) or_env_vif;
    virtual xor_intf   #(XWIDTH) xor_env_vif;
    
    virtual shift_intf #(SRWIDTH, SROPWIDTH, SLWIDTH, SLOPWIDTH) shift_env_vif;

    function new(string name = "bitwise_env_config");
        super.new(name);
    endfunction :new
endclass :bitwise_env_config