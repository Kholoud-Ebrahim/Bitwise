class bitwise_env extends uvm_env;
    `uvm_component_utils(bitwise_env)
    
    and_agent    and_agnt;
    or_agent     or_agnt;
    shift_agent  shift_agnt;
    xor_agent    xor_agnt;

    bitwise_scoreboard          scb;
    and_coverage_collector      and_cov;
    or_coverage_collector       or_cov;
    xor_coverage_collector      xor_cov;
    shift_coverage_collector    shift_cov;

    bitwise_env_config        env_config;

    and_agent_config          and_config;
    or_agent_config           or_config;
    shift_agent_config        shift_config;
    xor_agent_config          xor_config;

    virtual_sequencer           vsqr;

    function new(string name = "bitwise_env", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        and_agnt   = and_agent  ::type_id::create("and_agnt", this);
        or_agnt    = or_agent   ::type_id::create("or_agnt", this);
        shift_agnt = shift_agent::type_id::create("shift_agnt", this);
        xor_agnt   = xor_agent  ::type_id::create("xor_agnt", this);

        scb = bitwise_scoreboard::type_id::create("scb", this);
        and_cov   = and_coverage_collector::type_id::create("and_cov", this);
        or_cov    = or_coverage_collector::type_id::create("or_cov", this);
        xor_cov   = xor_coverage_collector::type_id::create("xor_cov", this);
        shift_cov = shift_coverage_collector::type_id::create("shift_cov", this);

        if(!(uvm_config_db #(bitwise_env_config)::get(this, "", "env_config_name", env_config)))
            `uvm_fatal(get_full_name(),"Cannot get Env Config from configuration database!")

        and_config = and_agent_config::type_id::create("and_config");
        and_config.and_agnt_vif = env_config.and_env_vif;
        and_config.is_active    = env_config.and_env_is_active;
        uvm_config_db #(and_agent_config)::set(this, "*", "and_agnt_config_name", and_config);
        
        or_config  = or_agent_config::type_id::create("or_config");
        or_config.or_agnt_vif = env_config.or_env_vif;
        or_config.is_active   = env_config.or_env_is_active;
        uvm_config_db #(or_agent_config)::set(this, "*", "or_agnt_config_name",or_config);

        shift_config = shift_agent_config::type_id::create("shift_config");
        shift_config.shift_agnt_vif = env_config.shift_env_vif;
        shift_config.is_active      = env_config.shift_env_is_active;
        uvm_config_db #(shift_agent_config)::set(this, "*", "shift_agnt_config_name", shift_config);

        xor_config = xor_agent_config::type_id::create("xor_config");
        xor_config.xor_agnt_vif = env_config.xor_env_vif;
        xor_config.is_active    = env_config.xor_env_is_active;
        uvm_config_db #(xor_agent_config)::set(this, "*", "xor_agnt_config_name", xor_config);

        vsqr = virtual_sequencer::type_id::create("vsqr", this);

    endfunction :build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        and_agnt.and_mon2agnt_port.connect(scb.and_scb_imp);
        or_agnt.or_mon2agnt_port.connect(scb.or_scb_imp);
        shift_agnt.shift_mon2agnt_port.connect(scb.shift_scb_imp);
        xor_agnt.xor_mon2agnt_port.connect(scb.xor_scb_imp);

        and_agnt.and_mon2agnt_port.connect(and_cov.and_cov_imp);
        or_agnt.or_mon2agnt_port.connect(or_cov.or_cov_imp);
        shift_agnt.shift_mon2agnt_port.connect(shift_cov.shift_cov_imp);
        xor_agnt.xor_mon2agnt_port.connect(xor_cov.xor_cov_imp);
        
        vsqr.and_sqr_env_h   = and_agnt.and_sqr;
        vsqr.or_sqr_env_h    = or_agnt.or_sqr;
        vsqr.shift_sqr_env_h = shift_agnt.shift_sqr;
        vsqr.xor_sqr_env_h   = xor_agnt.xor_sqr;

    endfunction :connect_phase
    
endclass :bitwise_env