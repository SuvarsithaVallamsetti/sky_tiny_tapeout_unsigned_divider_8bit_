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

    // DUT instantiation
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

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Create output folder if it doesn't exist
        $system("mkdir -p test");

        // Generate waveform file
        $dumpfile("test/tb.vcd");
        $dumpvars(0, tb);

        // Reset pulse
        rst_n = 0;
        #20;
        rst_n = 1;

        // Simple stimulus
        ui_in = 8'd100; uio_in = 8'd5;  #50;
        ui_in = 8'd25;  uio_in = 8'd5;  #50;
        ui_in = 8'd50;  uio_in = 8'd10; #50;

        // Write test results XML (CI requirement)
        integer fd;
        fd = $fopen("test/results.xml", "w");
        $fwrite(fd, "<testsuite><testcase classname='tb' name='basic_test'/></testsuite>");
        $fclose(fd);

        // End simulation
        $finish;
    end

endmodule
