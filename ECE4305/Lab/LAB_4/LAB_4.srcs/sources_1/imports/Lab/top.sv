`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2022 04:42:42 PM
// Design Name: 
// Module Name: top
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


module top
    (
    input logic [7:0] SW,
    input logic clk,
    input logic signal,
    output logic [6:0] sseg,
    output logic [7:0] an
    );
    
    logic [7:0] celsius_out, fahrenheit_out;
    logic [11:0] in_temp, out_temp;
    logic [7:0] tempConversion;
    logic [3:0] in_label, out_label;
    
    synch_rom #(.File("celsius_to_fahrenheit.mem")) celsius_rom
    (
    .clk(clk),
    .data(SW),
    .conv_data(fahrenheit_out)
    );

    synch_rom #(.File("fahrenheit_to_celsius.mem")) fahrenheit_rom
    (
    .clk(clk),
    .data(SW),
    .conv_data(celsius_out)
    );
    
    always_comb
    begin
        if(~signal)
        begin
            in_label = 'hC;
            tempConversion = fahrenheit_out;
            out_label = 'hF;
        end
        else
        begin
            in_label = 'hF;
            tempConversion = celsius_out;
            out_label = 'hC;
        end
    end
    
    bin2bcd inBCD
    (
    .binary(SW),
    .ones(in_temp[3:0]),
    .tens(in_temp[7:4]),
    .hundreds(in_temp[11:8])
    );
    
    bin2bcd outBCD
    (
    .binary(tempConversion),
    .ones(out_temp[3:0]),
    .tens(out_temp[7:4]),
    .hundreds(out_temp[11:8])
    );
    
    time_mux_disp seven_seg (
        .in0({1'b1 ,in_label, 1'b1}),
        .in1({1'b1 ,in_temp[3:0], 1'b1}),
        .in2({1'b1 ,in_temp[7:4], 1'b1}),
        .in3({1'b1 ,in_temp[11:8], 1'b1}),
        .in4({1'b1 ,out_label, 1'b1}),
        .in5({1'b1 ,out_temp[3:0], 1'b1}),
        .in6({1'b1 ,out_temp[7:4], 1'b1}),
        .in7({1'b1 ,out_temp[11:8], 1'b1}),
        .dp(),
        .*
    );
    
endmodule
