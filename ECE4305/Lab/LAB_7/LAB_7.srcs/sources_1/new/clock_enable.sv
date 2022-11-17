`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2022 06:19:57 PM
// Design Name: 
// Module Name: clock_enable
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


module clock_enable #(parameter max_count = 99999)
    (
        input logic clk,
        input logic reset,
        output logic clk_en
    );
        
    logic [$clog2(max_count) - 1 : 0] clk_counter;
    
    always_ff @(posedge clk)
    begin
        if(reset)
            clk_counter <= 0;
        else begin
            if(clk_counter < max_count)
                clk_counter <= clk_counter + 1;
            else
                clk_counter <= 0;
        end
    end
    
    always_ff @(posedge clk)
    begin
        if(reset)
            clk_en <= 0;
        else if(clk_counter == max_count)
            clk_en <= 1;
        else
            clk_en <= 0;
    end
endmodule

