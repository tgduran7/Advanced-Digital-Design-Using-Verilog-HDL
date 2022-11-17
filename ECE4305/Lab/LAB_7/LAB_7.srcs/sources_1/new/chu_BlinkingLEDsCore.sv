`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2022 06:19:57 PM
// Design Name: 
// Module Name: chu_BlinkingLEDsCore
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


module chu_BlinkingLEDsCore#(parameter max_count = 99999)  
   (
    input  logic clk,
    input  logic reset,
    // slot interface
    input  logic cs,
    input  logic read,
    input  logic write,
    input  logic [4:0] addr, 
    input  logic [31:0] wr_data,
    output logic [31:0] rd_data,
    // external port    
    output logic [3:0] dout
   );
   
   localparam counter_width = 16;
   localparam num_leds = 4;
   localparam numBitsBufAddr = $clog2(num_leds); // log2(4) = 2
    
   // declaration
   logic [counter_width - 1:0] bufCountVal [0 : num_leds - 1]; 
   logic [numBitsBufAddr - 1: 0] bufAddr; 
   logic wr_en;
   
   assign bufAddr = addr[numBitsBufAddr - 1: 0]; // [1:0] for only 4 registers

   // body
   // output buffer register
   always_ff @(posedge clk, posedge reset)
      if (reset)
         for(integer i = 0; i < num_leds; i = i + 1) 
            bufCountVal[i] <= 'b0;
      else   
         if (wr_en)
            bufCountVal[bufAddr] <= wr_data[counter_width-1:0];
            
   // decoding logic 
   assign wr_en = cs && write;
   // slot read interface
   assign rd_data =  0;
   
   logic clk_en;
   clock_enable #(.max_count(99999)) clock_enable_inst
    (
        .clk(clk),
        .reset(reset),
        .clk_en(clk_en)
    );
    
    genvar led_count;
    generate 
        for(led_count = 0; led_count < num_leds; led_count = led_count + 1) begin
            BlinkingLEDsCore inst
            (
            .clk(clk),
            .reset(reset),
            .clk_en(clk_en),
            .count_val(bufCountVal[led_count]),
            .led_out(dout[led_count])
            );
        end
    endgenerate
       
endmodule
