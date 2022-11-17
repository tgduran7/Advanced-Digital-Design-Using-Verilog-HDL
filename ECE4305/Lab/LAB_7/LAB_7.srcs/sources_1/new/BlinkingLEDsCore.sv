`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2022 06:19:57 PM
// Design Name: 
// Module Name: BlinkingLEDsCore
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


module BlinkingLEDsCore
    (
    input clk,
    input reset,
    input clk_en,
    input [15:0] count_val,
    output led_out
    );
    
    logic [15:0] counter_reg;
    always_ff @(posedge clk, posedge reset) begin
        if (reset)
            counter_reg <= 0;
        else if(clk_en) begin
            if(counter_reg == count_val - 1)
                counter_reg <= 0;          
            else
                counter_reg <= counter_reg + 1;
        end
    end
    
    logic led_val;
    always_ff @(posedge clk, posedge reset) begin
        led_val <= led_val;
        if (reset)
            led_val <= 0;
        else if(clk_en) begin
            if(counter_reg == count_val - 1) begin
                if(led_val == 1'b1)
                    led_val <= 0;
                else
                    led_val <= 1;
            end
        end
    end
    assign led_out = led_val;
endmodule
