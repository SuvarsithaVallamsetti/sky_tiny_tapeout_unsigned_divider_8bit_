`default_nettype none
`timescale 1ns / 1ps

// Tiny Tapeout top module
module tt_um_unsigned_divider (
    input  wire [7:0] ui_in,   // Dividend on ui_in[7:0]
    output wire [7:0] uo_out,  // {Quotient[3:0], Remainder[3:0]}
    input  wire [7:0] uio_in,  // Divisor on uio_in[3:0], rest unused
    output wire [7:0] uio_out, // Unused outputs
    output wire [7:0] uio_oe,  // Output enables
    input  wire       clk,
    input  wire       rst_n,
    input  wire       ena
);

    // Internal registers
    reg [3:0] dividend;
    reg [3:0] divisor;
    reg [3:0] quotient;
    reg [3:0] remainder;

    reg [7:0] uo_out_reg;

    // Fixed outputs for unused IO
    assign uio_out = 8'd0;
    assign uio_oe  = 8'd0;

    // Connect registered output to output port
    assign uo_out = uo_out_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            dividend   <= 4'd0;
            divisor    <= 4'd0;
            quotient   <= 4'd0;
            remainder  <= 4'd0;
            uo_out_reg <= 8'd0;
        end 
        else if (ena) begin
            dividend <= ui_in[7:4];  // Upper nibble = dividend
            divisor  <= uio_in[3:0]; // Lower nibble of uio_in = divisor

            if (uio_in[3:0] == 4'd0) begin
                // Divide by zero → all ones
                quotient   <= 4'hF;
                remainder  <= 4'hF;
                uo_out_reg <= 8'hFF;
            end 
            else begin
                quotient   <= ui_in[7:4] / uio_in[3:0];
                remainder  <= ui_in[7:4] % uio_in[3:0];
                uo_out_reg <= {quotient, remainder};
            end
        end
    end

endmodule
`default_nettype wire
