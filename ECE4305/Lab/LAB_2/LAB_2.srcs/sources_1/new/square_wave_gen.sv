`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 01:51:34 PM
// Design Name: 
// Module Name: square_wave_gen
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


module square_wave_gen
    (
    input logic [3:0] m,                        // 4 bits to control the ON portion of the square wave
    input logic [3:0] n,                        // 4 bits to control the OFF portion of the square wave
    input logic reset,                          // Reset button to clear the current wave
    input logic clk,                            // Synchronous clock running at 10 nS
    output logic wave                           // Output square_wave
    );
    
    logic [8:0] total_time;                     // Variable for the total length of m and n
    logic [8:0] count;                          // Variable for counter
    logic [8:0] m_max;                          // Variable for m's total length
    
                                                // Calculate square wave values
    always@(posedge clk)                        // Wait for rising edge of clock
        begin
            total_time <= (m+n) * 10;           // Find total length for m and n
            m_max <= m * 10;                    // Find length for only m
        end
    
                                                // Counter segment
    always@(posedge clk)                        // Wait for rising edge of clock
        begin
            if(reset || count == total_time)    // Check for reset OR total_time fulfilled
                count <= 0;                     // If true, then restart counter
            else                                // If false,
                count <= count + 1;             // Increase counter by 1
        end
    
                                                // Output comparator segment
    always@(posedge clk)                        // Wait for rising edge of clock
        begin
            if(count <= m_max)                  // If count is less than or equal to m_max,
                wave <= 1;                      // Output a 1 to the wave
            else                                // If count is greater than m_max, 
                wave <= 0;                      // Output a 0 to the wave
        end 
    
endmodule

