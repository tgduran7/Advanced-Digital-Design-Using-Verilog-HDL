`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 01:37:17 PM
// Design Name: 
// Module Name: param_inverter
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


module param_inverter #(parameter N = 3)
    (
    input logic [2**N-1:0] data,
    output logic [2**N-1:0] out
    );
    
    // reverse a vector using right-to-left streaming with the default block size of 1 bit 
    assign out = {<<{data}};  
    
endmodule
