`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 01:46:46 PM
// Design Name: 
// Module Name: param_barrel_shifter_tb
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


module param_barrel_shifter_tb
    (

    );
    
    localparam N = 3;
    localparam WIDTH = 2**N;
    
    logic [WIDTH-1:0] a;
    logic [N-1:0] amt;
    logic [WIDTH-1:0] y;
    
/*    param_right_shifter #(.N(N)) uut (.*);
    initial begin
        for (int i=0; i<WIDTH; ++i)
            begin
                a = 5; amt = i; #10;
            end
        $stop;
    end;*/
    
    param_left_shifter #(.N(N)) uut1 (.*);
    initial begin
        for (int i=0; i<WIDTH; ++i)
            begin
                a = 1; amt = i; #10;
            end
        $stop;
    end
    
endmodule
