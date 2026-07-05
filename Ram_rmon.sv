class ram_rmon;

  // Transaction handles
  ram_trans t1, t2, t3;

  // Mailboxes used to send monitored data
  mailbox #(ram_trans) mbx1, mbx2;

  // Virtual interface for monitoring read signals
  virtual ram_if.read_mon vif;

  // Constructor
  // Connect mailboxes and virtual interface to the monitor
  function new(mailbox #(ram_trans) mbx1, mbx2,
               virtual ram_if.read_mon vif);
    this.mbx1 = mbx1;
    this.mbx2 = mbx2;
    this.vif = vif;
  endfunction

  // Monitor task
  task run();

    // Keep monitoring the read interface
    forever begin

      // Create a new transaction
      t1 = new();

      // Wait for 2 clock cycles
      repeat(2)
        @(vif.r_mon_cb);

      // Wait until read enable becomes HIGH
      wait(vif.r_mon_cb.read_en);

      // Capture the read address and read data
      t1.read_addr = vif.r_mon_cb.read_addr;
      t1.read_data = vif.r_mon_cb.read_data;

      // Wait for 2 more clock cycles
      repeat(2)
        @(vif.r_mon_cb);

      // Create copies of the transaction
      t2 = new(t1);
      t3 = new(t1);

      // Send one copy to the scoreboard
      mbx1.put(t2);

      // Send another copy to the reference model
      mbx2.put(t3);

    end

  endtask

endclass
