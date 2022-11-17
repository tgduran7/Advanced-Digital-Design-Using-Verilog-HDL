`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2022 04:43:54 PM
// Design Name: 
// Module Name: synch_rom
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


module synch_rom #(File = "truth_table.mem")
    (
    input logic clk,
    input logic [7:0] data,
    output logic [7:0] conv_data
    );
    
    (*rom_style = "block" *)logic [7:0] rom [0:256]; 
    
    initial
        $readmemh(File, rom);
    
    
    always_ff @ (posedge clk)
        conv_data <= rom[data];
endmodule
