class ram_sb;

  // Transaction handles
  ram_trans t1, t2;

  // Mailboxes used to receive data
  mailbox #(ram_trans) mbx1, mbx2;

  // Constructor
  // Connect the mailboxes to the scoreboard
  function new(mailbox #(ram_trans) mbx1, mbx2);
    this.mbx1 = mbx1;
    this.mbx2 = mbx2;
  endfunction

  // Scoreboard task
  task run();

    // Keep checking all transactions
    forever begin

      // Get data from the read monitor and reference model together
      fork
        mbx1.get(t1);   // Actual data from the DUT
        mbx2.get(t2);   // Expected data from the reference model
      join

      // Compare the read addresses
      if (t1.read_addr !== t2.read_addr)
        $display("Address mismatch error");

      // Compare the read data
      else if (t1.read_data !== t2.read_data)
        $display("Data mismatch");

      // If both match, the test passes
      else
        $display("Data matched successfully");

    end

  endtask

endclass
