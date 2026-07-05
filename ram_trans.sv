class ram_trans;

  // Randomized write signals
  rand bit        write_en;
  rand bit [31:0] write_addr;
  rand bit [31:0] write_data;

  // Randomized read signals
  rand bit        read_en;
  rand bit [31:0] read_addr;

  // Read data captured after the read operation
  bit [31:0] read_data;

  // Write and read address should not be the same
  constraint valid_addr {
    write_addr != read_addr;
  }

  // Generate write data between 1 and 409
  constraint valid_data {
    write_data inside {[1:409]};
  }

  // At least one of the enable signals should be HIGH
  constraint valid_en {
    {write_en, read_en} != 2'b00;
  }

  // Constructor
  // If another transaction is passed, copy all its values
  function new(ram_trans rhs = null);

    if (rhs != null) begin
      write_en   = rhs.write_en;
      write_addr = rhs.write_addr;
      write_data = rhs.write_data;
      read_en    = rhs.read_en;
      read_addr  = rhs.read_addr;
      read_data  = rhs.read_data;
    end

  endfunction

endclass
