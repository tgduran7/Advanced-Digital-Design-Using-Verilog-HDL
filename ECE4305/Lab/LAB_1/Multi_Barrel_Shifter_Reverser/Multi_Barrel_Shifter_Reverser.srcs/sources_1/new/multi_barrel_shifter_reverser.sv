`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 01:37:17 PM
// Design Name: 
// Module Name: multi_barrel_shifter_reverser
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


const logic RIGHT = 1'b1;
const logic LEFT = 1'b0;

module multi_barrel_shifter_reverser #(parameter N = 3)
    (
    input logic [2**N-1:0] a,
    input logic [N-1:0] amt,
    input logic lr,
    output logic [2**N-1:0] y
    );
    
    localparam WIDTH = 2**N;
    
    logic [2**N-1:0] out_right; // output result
    logic [2**N-1:0] reversed_outr; // reversed output rotation for right rotation
    logic [2**N-1:0] reversed_data; // reversed input data for left rotation
    
    // if rotate left use rotated input data
    param_right_shifter #(.N(N)) bsr1
    (.a((lr == LEFT) ? reversed_data:a), .amt(amt) , .y(out_right));
    
    // reverse input circuit
    param_inverter #(.N(N)) input_inverter
    (
    .data(a),
    .out(reversed_data)
    );
    
    //  reverse output circuit
    param_inverter #(.N(N)) output_inverter
    (
    .data(out_right),
    .out(reversed_outr)
    );
    
    // if rotate right use rotated output  
    assign  y = (lr == RIGHT) ? reversed_outr:out_right;
endmodule
