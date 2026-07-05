class ram_env;

  // Create handles for all verification components
  ram_gen   gen;
  ram_wrdrv wdrv;
  ram_rrdrv rdrv;
  ram_wrmon wmon;
  ram_rmon  rmon;
  ref_model rm;
  ram_sb    sb;

  // Mailboxes used for communication between components
  mailbox #(ram_trans) mbx1;
  mailbox #(ram_trans) mbx2;
  mailbox #(ram_trans) mbx3;
  mailbox #(ram_trans) mbx4;
  mailbox #(ram_trans) mbx5;
  mailbox #(ram_trans) mbx6;

  // Virtual interfaces used to connect drivers and monitors
  virtual ram_if.write_drv vif1;
  virtual ram_if.read_drv  vif2;
  virtual ram_if.write_mon vif3;
  virtual ram_if.read_mon  vif4;

  // Constructor
  // Connect the virtual interfaces and create the mailboxes
  function new(virtual ram_if.write_drv vif1,
               virtual ram_if.read_drv  vif2,
               virtual ram_if.write_mon vif3,
               virtual ram_if.read_mon  vif4);

    this.vif1 = vif1;
    this.vif2 = vif2;
    this.vif3 = vif3;
    this.vif4 = vif4;

    // Create all the mailboxes
    mbx1 = new();
    mbx2 = new();
    mbx3 = new();
    mbx4 = new();
    mbx5 = new();
    mbx6 = new();

  endfunction

  // Build task
  // Create all verification components and connect them
  task build();

    gen  = new(mbx1, mbx2);
    wdrv = new(mbx1, vif1);
    rdrv = new(mbx2, vif2);
    wmon = new(mbx3, vif3);
    rmon = new(mbx4, mbx5, vif4);
    rm   = new(mbx3, mbx4, mbx6);
    sb   = new(mbx5, mbx6);

  endtask

  // Run task
  // Start all verification components together
  task run();

    fork
      gen.run();
      wdrv.run();
      rdrv.run();
      wmon.run();
      rmon.run();
      rm.run();
      sb.run();
    join_none

  endtask

endclass
