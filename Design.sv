module dual_port_ram #(
    parameter ADDR_WIDTH = 8,    // Address size
    parameter DATA_WIDTH = 32    // Data size
)(
    input logic clock,           // Clock signal

    // Write inputs
    input logic                     write_en,      // Enable writing
    input logic [ADDR_WIDTH-1:0]    write_addr,    // Address to write data
    input logic [DATA_WIDTH-1:0]    write_data,    // Data to be stored

    // Read inputs
    input logic                     read_en,       // Enable reading
    input logic [ADDR_WIDTH-1:0]    read_addr,     // Address to read data
    output logic [DATA_WIDTH-1:0]   read_data      // Output data
);

    // Memory array
    // Total locations = 2^ADDR_WIDTH
    logic [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

    // Write operation
    // Data is written only when write_en is HIGH
    // Writing happens on the positive edge of the clock
    always_ff @(posedge clock) begin
        if (write_en) begin
            mem[write_addr] <= write_data;
        end
    end

    // Read operation
    // Data is read only when read_en is HIGH
    // Reading also happens on the positive edge of the clock
    always_ff @(posedge clock) begin
        if (read_en) begin
            read_data <= mem[read_addr];
        end
    end

endmodule
