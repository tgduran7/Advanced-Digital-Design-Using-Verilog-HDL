`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 01:29:59 PM
// Design Name: 
// Module Name: param_left_shifter
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


module param_left_shifter #(parameter N = 3)
    (
    input logic [2**N-1:0] a,
    input logic [N-1:0] amt,
    output logic [2**N-1:0] y
    );
    
    localparam WIDTH = 2**N;
    logic [N-1:0][WIDTH-1:0] stage_out;
    
    generate
        genvar stage ;
        assign stage_out[0] = amt[0] ? { a[WIDTH-2:0], a[WIDTH-1]} : a;
        for (stage = 1; stage < N ; ++stage)
            begin
                assign stage_out[stage] = amt[stage] ? {stage_out[stage-1][((2**N-1)-(2**stage)):0], stage_out[stage-1][2**N-1:(2**N-1)-(2**stage-1)]} : stage_out[stage-1];
            end
        assign y = stage_out[N-1];
    endgenerate
    
endmodule
