`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 01:41:14 PM
// Design Name: 
// Module Name: right_shifter
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


module right_shifter
    (
    input logic [7:0] a,
    input logic [2:0] amt,
    output logic [7:0] y
    );
    
    logic [7:0] s0, s1;
    
    //stage 0, shift 0 or 1 bit
    assign s0 = amt[0] ? {a[0], a[7:1]} : a;
    
    //stage 1, shift 0 or 2 bits
    assign s1 = amt[1] ? {s0[1:0], s0[7:2]} : s0;
    
    //stage 2, shift 0 or 4 bits
    assign y = amt[2] ? {s1[3:0], s1[7:4]} : s1;
    
endmodule
