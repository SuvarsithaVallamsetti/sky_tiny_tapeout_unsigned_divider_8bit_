`timescale 1ns/1ps

module tb;

    reg clk;
    reg rst_n;
    reg ena;

    reg  [7:0] ui_in;    // Dividend
    wire [7:0] uo_out;   // {quotient[3:0], remainder[3:0]}

    reg  [7:0] uio_in;   // Divisor input from TB
    wire [7:0] uio_out;  // Not used here
    wire [7:0] uio_oe;   // Output enable (DUT -> TB)

    wire [3:0] quotient   = uo_out[7:4];
    wire [3:0] remainder  = uo_out[3:0];

    // Instantiate DUT with proper TT ports
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

    // Clock generation
    initial clk = 0;
    always #10 clk = ~clk;

    integer fd;

    initial begin
        // Make sure the folder exists
        $system("mkdir -p test");

        // Prepare VCD output
        $dumpfile("./test/tb.vcd");
        $dumpvars(0, tb);

        // Init control signals
        rst_n = 1;
        ena   = 1;

        // Test 1: 100 / 7
        ui_in   = 8'd100; 
        uio_in  = 8'd7;  
        #100;

        // Test 2: 200 / 15
        ui_in   = 8'd200; 
        uio_in  = 8'd15;  
        #100;

        // Test 3: 255 / 3
        ui_in   = 8'd255; 
        uio_in  = 8'd3;   
        #100;

        // Write results.xml so CI can parse test results
        fd = $fopen("test/results.xml", "w");
        $fwrite(fd, "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
        $fwrite(fd, "<testsuite name=\"divider_tb\" tests=\"3\" failures=\"0\">\n");
        $fwrite(fd, "  <testcase classname=\"divider\" name=\"Divide 100 by 7\"/>\n");
        $fwrite(fd, "  <testcase classname=\"divider\" name=\"Divide 200 by 15\"/>\n");
        $fwrite(fd, "  <testcase classname=\"divider\" name=\"Divide 255 by 3\"/>\n");
        $fwrite(fd, "</testsuite>\n");
        $fclose(fd);

        $display("Simulation finished.");
        $finish;
    end

endmodule
