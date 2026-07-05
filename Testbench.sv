// Include all verification files
`include "ram_if.sv"
`include "ram_trans.sv"
`include "ram_gen.sv"
`include "ram_wrdrv.sv"
`include "ram_rddrv.sv"
`include "ram_wrmon.sv"
`include "ram_rmon.sv"
`include "ram_ref_model.sv"
`include "ram_sb.sv"
`include "ram_env.sv"
`include "ram_test.sv"

module top;

  // Clock signal
  bit clock = 0;

  // Create interface and connect it to the clock
  ram_if intf(clock);

  // Instantiate the Design Under Test (DUT)
  dual_port_ram DUT(
      .clock(intf.clock),

      // Write port connections
      .write_en(intf.write_en),
      .write_addr(intf.write_addr),
      .write_data(intf.write_data),

      // Read port connections
      .read_en(intf.read_en),
      .read_addr(intf.read_addr),
      .read_data(intf.read_data)
  );

  // Declare test object
  ram_test test;

  initial begin
    // Create the test object
    test = new(intf, intf, intf, intf);

    // Start the test
    test.run();
  end

  // Generate a clock with 10 time units period
  always
    #5 clock = ~clock;

endmodule
