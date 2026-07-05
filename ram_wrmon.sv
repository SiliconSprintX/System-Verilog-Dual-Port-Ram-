class ram_wrmon;

  // Transaction handles
  ram_trans t1, t2;

  // Mailbox used to send monitored data to the reference model
  mailbox #(ram_trans) mbx1;

  // Virtual interface for monitoring write signals
  virtual ram_if.write_mon vif;

  // Constructor
  // Connect mailbox and virtual interface to the monitor
  function new(mailbox #(ram_trans) mbx1, virtual ram_if.write_mon vif);
    this.mbx1 = mbx1;
    this.vif = vif;
  endfunction

  // Monitor task
  task run();

    // Keep monitoring the write interface
    forever begin

      // Create a new transaction
      t1 = new();

      // Wait for 2 clock cycles
      repeat(2)
        @(vif.w_mon_cb);

      // Wait until write enable becomes HIGH
      wait(vif.w_mon_cb.write_en);

      // Capture write address and write data from the interface
      t1.write_addr = vif.w_mon_cb.write_addr;
      t1.write_data = vif.w_mon_cb.write_data;

      // Wait for 2 more clock cycles
      repeat(2)
        @(vif.w_mon_cb);

      // Create a copy of the transaction
      t2 = new(t1);

      // Send the transaction to the mailbox
      mbx1.put(t2);

    end

  endtask

endclass
