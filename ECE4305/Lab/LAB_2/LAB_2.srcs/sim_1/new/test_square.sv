`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 01:52:29 PM
// Design Name: 
// Module Name: test_square
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


module test_square();

localparam T = 20;
logic [3:0]m;
logic [3:0]n;
logic reset;
logic clk;
logic wave;
square_wave_gen uut(.m(m),.n(n),.reset(reset),.clk(clk),.wave(wave),);

always
begin
    clk = 1'b0;
    #(T/2);
    clk = 1'b1;
    #(T/2);
end

initial
begin
    m = 4'b0100;
    n = 4'b0011;
    reset = 1;
    #30
    reset = 0;
    
end

endmodule
