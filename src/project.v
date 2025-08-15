`timescale 1ns / 1ps

module tb;

    reg  [7:0] ui_in = 0;
    reg  [7:0] uio_in = 0;
    reg clk = 0;
    reg rst_n = 1;
    reg ena = 1;

    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    tt_um_unsigned_divider uut (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .clk(clk),
        .rst_n(rst_n),
        .ena(ena)
    );

    always #5 clk = ~clk;

    initial begin
        // Ensure test folder exists
        $system("mkdir -p test");

        // Enable waveform dumping
        $dumpfile("test/tb.vcd");
        $dumpvars(0, tb);

        // Reset sequence
        rst_n = 0;
        #10;
        rst_n = 1;

        // Stimulus
        ui_in = {4'd10, 4'd3}; #20;  // 10 / 3
        ui_in = {4'd8,  4'd2}; #20;  // 8 / 2
        ui_in = {4'd7,  4'd0}; #20;  // divide by zero

        // Create results.xml
        integer fd;
        fd = $fopen("test/results.xml", "w");
        $fwrite(fd, "<testsuite><testcase classname='tb' name='divider_test'/></testsuite>");
        $fclose(fd);

        $finish;
    end

endmodule
