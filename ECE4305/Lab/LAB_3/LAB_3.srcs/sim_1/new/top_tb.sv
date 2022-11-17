`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 04:05:45 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb();

localparam T = 10;
logic sw;
logic clk;
logic reset;
logic db;
logic [2:1] JA;

top uut1(
        .sw(sw),
        .reset(reset),
        .clk(clk), // genrally the 100MHz
        .db(db),
        .JA(JA)
    );
    
    // test vector
    //10 ns clock running forever
    always
    begin
        clk = 1'b1;
        #(T / 2);
        clk = 1'b0;
        #(T / 2);
    end
    
    // reset for the first half cycle
    initial
    begin
        reset = 1'b1;
        #(T / 2);
        reset = 1'b0;
    end

// stimuli (just the tick
    initial
    begin 
        
        #15       
        sw = 1;
        #10;
        
        sw = 0;
        #10;
        
        
        /*sw = 1;
        #20
        
        sw = 0;
        #20;
        
        sw = 1;*/
        
        #50
        
        sw = 1;
        #20;
        
        sw = 0;
        
        #1000;
        $finish;
    end
    
endmodule
