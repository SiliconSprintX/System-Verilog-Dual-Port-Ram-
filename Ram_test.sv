class ram_test;

  // Virtual interfaces used to connect the test with the environment
  virtual ram_if.write_drv vif1;
  virtual ram_if.read_drv  vif2;
  virtual ram_if.write_mon vif3;
  virtual ram_if.read_mon  vif4;

  // Handle for the environment
  ram_env env;

  // Constructor
  // Connect the virtual interfaces and create the environment
  function new(virtual ram_if.write_drv vif1,
               virtual ram_if.read_drv  vif2,
               virtual ram_if.write_mon vif3,
               virtual ram_if.read_mon  vif4);

    this.vif1 = vif1;
    this.vif2 = vif2;
    this.vif3 = vif3;
    this.vif4 = vif4;

    // Create the environment
    env = new(vif1, vif2, vif3, vif4);

  endfunction

  // Test task
  // Build the environment and start the simulation
  task run();

    // Create and connect all verification components
    env.build();

    // Run all components
    env.run();

  endtask

endclass
