class ref_model;

  // Transaction handles
  ram_trans t1, t2, t3;

  // Mailboxes used for communication
  mailbox #(ram_trans) mbx1, mbx2, mbx3;

  // Associative array used as reference memory
  int mem[int];

  // Constructor
  // Connect the mailboxes to the reference model
  function new(mailbox #(ram_trans) mbx1, mbx2, mbx3);
    this.mbx1 = mbx1;
    this.mbx2 = mbx2;
    this.mbx3 = mbx3;
  endfunction

  // Reference model task
  task run();

    // Keep checking write and read transactions
    forever begin

      // Perform write and read operations at the same time
      fork

        // Write operation
        begin
          // Get transaction from the write monitor
          mbx1.get(t1);

          // Store the data in the reference memory
          mem[t1.write_addr] = t1.write_data;
        end

        // Read operation
        begin
          // Get transaction from the read monitor
          mbx2.get(t2);

          // Check if the address is present in memory
          if (mem.exists(t2.read_addr))

            // Read data from the reference memory
            t2.read_data = mem[t2.read_addr];
          else
            $display("Reference Model: Data does not exist at the read address");

          // Create a copy of the transaction
          t3 = new(t2);

          // Send the expected data to the scoreboard
          mbx3.put(t3);
        end

      join

    end

  endtask

endclass
