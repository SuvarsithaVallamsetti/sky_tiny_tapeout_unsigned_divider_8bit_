`timescale 1ns/1ps

module tb;

    reg [7:0] dividend;
    reg [7:0] divisor;
    reg clk;

    wire [3:0] remainder;
    wire [3:0] quotient;

    // Instantiate DUT
    tt_um_unsigned_divider dut (
        .ui_in(dividend),
        .uo_out({quotient, remainder}),
        .uio_inout(divisor),
        .clk(clk)
    );

    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
        $dumpfile("test/tb.vcd");
        $dumpvars(0, tb);

        dividend = 8'd100; divisor = 8'd7;  #100;
        dividend = 8'd200; divisor = 8'd15; #100;
        dividend = 8'd255; divisor = 8'd3;  #100;

        $display("Simulation finished.");
        $finish;
    end

endmodule
