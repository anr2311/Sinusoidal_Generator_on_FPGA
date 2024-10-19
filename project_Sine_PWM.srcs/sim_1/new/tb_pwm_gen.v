`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2024 22:44:22
// Design Name: 
// Module Name: tb_pwm_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_pwm_gen;
 
    // Testbench signals
    reg clk;               // Clock signal
    reg reset;             // Reset signal
    wire pwm_out;          // PWM output
    wire [7:0] sine_output;
 
    // Instantiate the pwm_gen module
    pwm_gen uut (
        .clk(clk),
        .reset(reset),
        .pwm_out(pwm_out),
        .sine_output(sine_output)
    );
 
    // Clock generation: 100 MHz clock
    always begin
        #5 clk = ~clk;
    end
 
    // Testbench procedure
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
 
        // Hold reset for 100 ns, then release it
        #100;
        reset = 0;
 
        // Let the simulation run for some time to observe the PWM output
        #5000000; // Run for 5,000,000 ns (5 ms)
 
        // End the simulation
        $stop;
    end
    
    
    initial begin
        $monitor("time = %t, clk_in = %b, reset = %b, pwm_out = %b, sine_out = %d", $time, clk, reset, pwm_out, sine_output);
    end
endmodule