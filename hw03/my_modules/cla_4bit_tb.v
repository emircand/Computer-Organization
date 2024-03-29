`timescale 1ns / 1ps

module cla_4bit_tb;

    reg [3:0] a, b;
    reg cin;
    wire [4:0] sum;
    wire cout;

    // Instantiate the 4-bit carry lookahead adder
    adder_4bit_cla uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    // Test stimulus
    initial begin
        // Initialize inputs
        a = 0; b = 0; cin = 0;

        // Apply different sets of inputs with expected results as comments
        #10 a = 4'b0011; b = 4'b0101; cin = 0; // Expected sum: 1000, cout: 0
        #10 a = 4'b1100; b = 4'b1101; cin = 0; // Expected sum: 1001, cout: 1
        #10 a = 4'b1111; b = 4'b0001; cin = 1; // Expected sum: 0001, cout: 1
        #10 a = 4'b1010; b = 4'b0101; cin = 0; // Expected sum: 1111, cout: 0
        #10 a = 4'b0110; b = 4'b1001; cin = 1; // Expected sum: 1111, cout: 1

        #10 $finish; // End the simulation
    end

    // Monitor changes and display results
    initial begin
        $monitor("Time = %t, a = %b, b = %b, cin = %b, sum = %b, cout = %b", $time, a, b, cin, sum, cout);
    end

endmodule
