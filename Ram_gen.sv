class ram_gen;

  // Transaction handles
  ram_trans txn, t1, t2;

  // Mailboxes used to send transactions
  mailbox #(ram_trans) mbx1, mbx2;

  // Constructor
  // Connect the mailboxes to the generator
  function new(mailbox #(ram_trans) mbx1, mbx2);
    this.mbx1 = mbx1;
    this.mbx2 = mbx2;
  endfunction

  // Generator task
  task run();

    // Create a transaction object
    txn = new();

    // Generate 5 random transactions
    repeat(5) begin

      // Randomize the transaction values
      txn.randomize();

      // Create separate copies for write and read drivers
      t1 = new(txn);
      t2 = new(txn);

      // Send transaction to the write driver
      mbx1.put(t1);

      // Send transaction to the read driver
      mbx2.put(t2);

    end

  endtask

endclass
