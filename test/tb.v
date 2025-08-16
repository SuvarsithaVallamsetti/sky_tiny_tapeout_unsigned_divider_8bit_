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

    // Task to apply one test and check result
    task run_test(input [7:0] dividend, input [7:0] divisor);
        reg [3:0] exp_q;
        reg [3:0] exp_r;
    begin
        ui_in  = dividend;
        uio_in = divisor;

        // wait a few cycles for DUT to process
        repeat (5) @(posedge clk);

        exp_q = dividend / divisor;
        exp_r = dividend % divisor;

        if (quotient !== exp_q || remainder !== exp_r) begin
            $display("❌ FAIL: %0d / %0d → got Q=%0d R=%0d, expected Q=%0d R=%0d",
                     dividend, divisor, quotient, remainder, exp_q, exp_r);
        end else begin
            $display("✅ PASS: %0d / %0d = Q=%0d R=%0d",
                     dividend, divisor, quotient, remainder);
        end
    end
    endtask

    initial begin
        // Output dump
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);

        // Reset
        rst_n = 0;
        ena   = 1;
        ui_in = 0;
        uio_in = 1;
        repeat (2) @(posedge clk);
        rst_n = 1;

        // Run tests
        run_test(100, 7);
        run_test(200, 15);
        run_test(255, 3);
        run_test(123, 5);

        $display("Simulation finished.");
        $finish;
    end

endmodule
