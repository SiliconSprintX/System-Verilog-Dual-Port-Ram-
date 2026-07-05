class ram_wrdrv;

  // Handle for transaction received from the generator
  ram_trans t1;

  // Mailbox used to receive transactions from the generator
  mailbox #(ram_trans) mbx1;

  // Virtual interface for driving write signals
  virtual ram_if.write_drv vif;

  // Constructor
  // Connect mailbox and virtual interface to the driver
  function new(mailbox #(ram_trans) mbx1, virtual ram_if.write_drv vif);
    this.mbx1 = mbx1;
    this.vif = vif;
  endfunction

  // Main driver task
  task run();

    // Keep running to drive all transactions coming from the generator
    forever begin

      // Get one transaction from the mailbox
      mbx1.get(t1);

      // Enable write operation
      vif.w_drv_cb.write_en <= 1'b1;

      // Wait for 2 clock cycles before driving address and data
      repeat(2)
        @(vif.w_drv_cb);

      // Drive write address from the transaction
      vif.w_drv_cb.write_addr <= t1.write_addr;

      // Drive write data from the transaction
      vif.w_drv_cb.write_data <= t1.write_data;

      // Wait for 2 more clock cycles
      repeat(2)
        @(vif.w_drv_cb);

      // Disable write after the operation is complete
      vif.w_drv_cb.write_en <= 1'b0;

    end

  endtask

endclass
