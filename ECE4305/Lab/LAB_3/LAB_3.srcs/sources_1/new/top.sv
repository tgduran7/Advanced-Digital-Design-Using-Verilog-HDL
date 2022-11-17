`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 03:59:49 PM
// Design Name: 
// Module Name: top
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


module top(
        input logic sw,
        input logic reset,
        input logic clk, // genrally the 100MHz
        output logic db,
        output logic [2:1] JA
    );
    
    early_debouncer deb(.*);
    
    assign JA[1] = sw;
    assign JA[2] = db;
endmodule
