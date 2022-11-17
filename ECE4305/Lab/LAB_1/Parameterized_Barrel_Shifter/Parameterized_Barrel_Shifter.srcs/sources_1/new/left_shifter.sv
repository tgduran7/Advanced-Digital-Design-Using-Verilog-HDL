`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 01:41:14 PM
// Design Name: 
// Module Name: left_shifter
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


module left_shifter(
    input logic [7:0] data,
    input logic [2:0] amt,
    output logic [7:0] out
);

    logic [7:0] s0;
    logic [7:0] s1;
    //stage 0, shift 0 or 1 bit
    assign s0 = amt[0]? { data[6:0], data[7]} :data ;
    //stage 1, shift 0 or 2 bits
    assign s1 = amt[1]? { s0[5:0], s0[7:6]} :s0 ;
    //stage 1, shift 0 or 4 bits
    assign out = amt[2]?{s1[3:0], s1[7:4]} :s1;
endmodule
