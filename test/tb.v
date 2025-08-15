`timescale 1ns/1ps

module tb;

    reg clk;
    reg rst_n;
    reg ena;

    reg  [7:0] ui_in;    // Dividend
    wire [7:0] uo_out;   // {quotient[3:0], remainder[3:0]}

    reg  [7:0] uio_in;   // Divisor
    wire [7:0] uio_out;  // Not used
    wire [7:0] uio_oe;   // Not used

    wire [3:0] quotient  = uo_out[7:4];
    wire [3:0] remainder = uo_out[3:0];

    // DUT
    tt_um_unsigned_divider dut (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .clk(clk),
        .rst_n(rst_n),
        .ena(ena)
    );

    // Clock
    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
        // Output dump
       $dumpfile("tb.vcd");
        $dumpvars(0, tb);

        rst_n = 1;
        ena   = 1;

        // Test cases
        ui_in  = 8'd100; uio_in = 8'd7;   #100;
        ui_in  = 8'd200; uio_in = 8'd15;  #100;
        ui_in  = 8'd255; uio_in = 8'd3;   #100;

        $display("Simulation finished.");
        $finish;
    end

endmodule
