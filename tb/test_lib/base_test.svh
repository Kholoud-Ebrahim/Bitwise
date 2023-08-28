class base_test extends uvm_test;
    `uvm_component_utils(base_test)

    bitwise_env           env;
    bitwise_env_config    env_config;

    uvm_active_passive_enum   and_is_active; 
    uvm_active_passive_enum   or_is_active; 
    uvm_active_passive_enum   shift_is_active; 
    uvm_active_passive_enum   xor_is_active; 
    
    virtual and_intf   #(AWIDTH) and_h_vif;
    virtual or_intf    #(OWIDTH) or_h_vif;
    virtual xor_intf   #(XWIDTH) xor_h_vif;
    virtual shift_intf #(SRWIDTH, SROPWIDTH, SLWIDTH, SLOPWIDTH) shift_h_vif;


    function new(string name = "base_test", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        env        = bitwise_env::type_id::create("env", this);
        env_config = bitwise_env_config::type_id::create("env_config");

        if(!(uvm_config_db #(virtual and_intf  #(AWIDTH))::get(this, "", "and_vif", and_h_vif)))
            `uvm_fatal(get_full_name(),"Cannot get And VIF from configuration database!")

        if(!(uvm_config_db #(virtual or_intf   #(OWIDTH))::get(this, "", "or_vif", or_h_vif)))
            `uvm_fatal(get_full_name(),"Cannot get Or VIF from configuration database!")

        if(!(uvm_config_db #(virtual xor_intf  #(XWIDTH))::get(this, "", "xor_vif", xor_h_vif)))
            `uvm_fatal(get_full_name(),"Cannot get Xor VIF from configuration database!")

        if(!(uvm_config_db #(virtual shift_intf #(SRWIDTH, SROPWIDTH, SLWIDTH, SLOPWIDTH))::get(this, "", "shift_vif", shift_h_vif)))
            `uvm_fatal(get_full_name(),"Cannot get Shift VIF from configuration database!")

        env_config.and_env_vif   = and_h_vif;
        env_config.or_env_vif    = or_h_vif;
        env_config.xor_env_vif   = xor_h_vif;
        env_config.shift_env_vif = shift_h_vif;

        and_is_active   = UVM_ACTIVE;
        or_is_active    = UVM_ACTIVE;
        xor_is_active   = UVM_ACTIVE;
        shift_is_active = UVM_ACTIVE;

        env_config.and_env_is_active   = and_is_active;
        env_config.or_env_is_active    = or_is_active;
        env_config.xor_env_is_active   = xor_is_active;
        env_config.shift_env_is_active = shift_is_active;

        uvm_config_db #(bitwise_env_config)::set(this, "*", "env_config_name", env_config);

    endfunction :build_phase

    //Printing the heirarchy of the TB components	
    function void end_of_elaboration_phase (uvm_phase phase);
        uvm_top.print_topology();
    endfunction
        
endclass :base_test