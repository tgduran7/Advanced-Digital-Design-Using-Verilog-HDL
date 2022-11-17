`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2020 10:45:01 PM
// Design Name: 
// Module Name: fifo_ctrl
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


module fifo_ctrl
    #(parameter ADDR_WIDTH = 3)
    (
        input logic clk, reset,
        input logic wr, rd,
        output logic full, empty,
        output logic [ADDR_WIDTH : 0] w_addr,
        output logic [ADDR_WIDTH - 1 : 0] r_addr
    );
    
    logic [ADDR_WIDTH - 1 : 0] wr_ptr, wr_ptr_next;
    logic [ADDR_WIDTH - 1 : 0] rd_ptr, rd_ptr_next;
    
    logic full_next;
    logic empty_next;
    
    // registers for status and read/write pointers
    always_ff @(posedge clk, posedge reset)
    begin
        if(reset)
        begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            full <= 1'b0;
            empty <= 1'b1;
        end
        else
        begin
            wr_ptr <= wr_ptr_next;
            rd_ptr <= rd_ptr_next;
            full <= full_next;
            empty <= empty_next;
        end
    end
    
    always_comb
    begin
        // default is to keep old (current) values
        wr_ptr_next = wr_ptr;
        rd_ptr_next = rd_ptr;
        full_next = full;
        empty_next = empty;
        unique case({wr, rd})
            2'b01: // read (read is unchanged since we didn't change the size of read port)
            
            begin
                if (~empty)
                begin
                    rd_ptr_next = rd_ptr + 1;                // writing 16 bit reading 8 bit
                    full_next = 1'b0;
                    if (rd_ptr_next == wr_ptr )               // when reading the last stored value
                        empty_next = 1'b1;
                    if (wr_ptr_next == rd_ptr)    
                        full_next = 1'b1;
                end                
            end
            2'b10: // write 
            begin
                if (~full)
                begin
                    wr_ptr_next = wr_ptr + 2;                                // writing 16 bit 
                    empty_next = 1'b0;
                    if (wr_ptr_next == rd_ptr || wr_ptr_next == rd_ptr -1 )  // need to check 2 places 
                        full_next = 1'b1;
                end
            end
            2'b11: // read and write simultaneously 
            begin
            empty_next = 1'b0;                 // we need to set this to zero cause it's not gonna set to empty write twice, reads once
                if(~full)                      // only write if it's not full
                begin
                    wr_ptr_next = wr_ptr + 2;  
                    if (~empty)                     // only read if it's not empty
                        rd_ptr_next = rd_ptr + 1;
                    else
                        rd_ptr_next = rd_ptr;
                    
                    if (wr_ptr_next == rd_ptr)    
                        full_next = 1'b1;
                end
            end
            default: ; // case 2'b00; null statements; no op
        endcase       
    end
    
    // outputs
    assign w_addr = wr_ptr;
    assign r_addr = rd_ptr;
endmodule
