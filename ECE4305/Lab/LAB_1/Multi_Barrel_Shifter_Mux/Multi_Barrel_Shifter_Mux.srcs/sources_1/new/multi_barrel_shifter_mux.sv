`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 01:29:59 PM
// Design Name: 
// Module Name: multi_barrel_shifter_mux
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


const logic LEFT = 1'b1;
const logic RIGHT = 1'b0;

module multi_barrel_shifter_mux #(parameter N = 3)
    (
    input logic [2**N-1:0] a,
    input logic [N-1:0] amt,
    input logic lr,
    output logic [2**N-1:0] y
    );
    
    logic [2**N-1:0] outl;
    logic [2**N-1:0] outr;
    
    param_right_shifter #(.N(N)) bsr
    (
    .a(a),
    .amt(amt),
    .y(outr)
    );
    
    param_left_shifter #(.N(N))
    (
    .a,
    .amt,
    .y(outl)
    );
    
    assign y = lr == LEFT ? outl:outr;
    
endmodule
