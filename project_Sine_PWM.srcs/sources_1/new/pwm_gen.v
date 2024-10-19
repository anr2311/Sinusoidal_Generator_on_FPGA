`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2024 22:34:51
// Design Name: 
// Module Name: pwm_gen
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


module pwm_gen(
    input wire clk,         // 100 MHz clock
    input wire reset,       // Reset input
    output reg pwm_out,    // PWM output
    output reg [7:0] sine_output // 8-bit sine wave output
    );
    
    wire [7:0] sine_wave;   // 8-bit sine wave value
 
    // Instantiate the sine wave generator
    sine_gen sine_wave_gen (
        .clk(clk),
        .reset(reset),
        .sine_out(sine_wave)
    );
    
    always @(*) begin
        sine_output <= sine_wave;
    end
    
    reg [7:0] counter = 0;  // 8-bit counter for PWM generation
    
    always @(posedge clk) begin
        counter <= counter + 1;
        if (counter < sine_wave)
            pwm_out <= 1;
        else
            pwm_out <= 0;
    end
    
    ila_0 i1 (
        .clk(clk), // input wire clk    
        .probe0(reset), // input wire [0:0]  probe0  
        .probe1(pwm_out), // input wire [0:0]  probe1 
        .probe2(sine_output) // input wire [7:0]  probe2
    );
    
endmodule
