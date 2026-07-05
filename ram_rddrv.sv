class ram_rddrv;

  // Handle for transaction received from the generator
  ram_trans t1;

  // Mailbox used to receive transactions from the generator
  mailbox #(ram_trans) mbx1;

  // Virtual interface for driving read signals
  virtual ram_if.read_drv vif;

  // Constructor
  // Connect mailbox and virtual interface to the driver
  function new(mailbox #(ram_trans) mbx1, virtual ram_if.read_drv vif);
    this.mbx1 = mbx1;
    this.vif = vif;
  endfunction

  // Main driver task
  task run();

    // Keep running and process every transaction
    forever begin

      // Get one transaction from the mailbox
      mbx1.get(t1);

      // Enable read operation
      vif.r_drv_cb.read_en <= 1'b1;

      // Wait for 2 clock cycles before giving the read address
      repeat(2)
        @(vif.r_drv_cb);

      // Drive the read address from the transaction
      vif.r_drv_cb.read_addr <= t1.read_addr;

      // Wait for 2 more clock cycles
      repeat(2)
        @(vif.r_drv_cb);

      // Disable read after the operation is complete
      vif.r_drv_cb.read_en <= 1'b0;

    end

  endtask

endclass
