module rom (
    input logic clk,
    input logic [3:0] addr,
    output logic [7:0] data

);

// 16-entry, 8-bit-wide memory
    logic [7:0] memory [0:15];

    // Load the contents from a hex file at simulation start
    initial begin
        $readmemh("firmware.hex", memory);
    end

    // Synchronous read: on each rising clock edge, output the data
    // at the requested address
    always_ff @(posedge clk) begin
        data <= memory[addr];
    end

endmodule
