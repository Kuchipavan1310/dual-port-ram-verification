class ram_test;

  ram_env env;

  virtual ram_if.write_drv vif1;
  virtual ram_if.read_drv vif2;
  virtual ram_if.write_mon vif3;
  virtual ram_if.read_mon vif4;

  function new(
    virtual ram_if.write_drv vif1,
    virtual ram_if.read_drv vif2,
    virtual ram_if.write_mon vif3,
    virtual ram_if.read_mon vif4
  );

    this.vif1 = vif1;
    this.vif2 = vif2;
    this.vif3 = vif3;
    this.vif4 = vif4;

    env = new(vif1, vif2, vif3, vif4);

  endfunction

  task run();

    env.build();

    env.run();

  endtask

endclass
