`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.07.2023 15:56:11
// Design Name: 
// Module Name: APB
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


module APB(
    input clk,
    input rst,
    input transfer,
    input wr_rd,
    input [8:0]wr_addr,
    input [7:0]wr_data,
    input [8:0]rd_addr,
    input PREADY,
    input [7:0]PRD_DATA,
    
    output reg PENABLE,
    output reg PWRITE,
    output reg [7:0]PWDATA,
    output reg [8:0]PADDR,
    output PSEL1,
    output PSEL2,
    output reg [7:0] RD_DATA,
    output reg SLVERR);
    
    parameter IDLE=2'b00;
    parameter SETUP=2'b01;
    parameter ENABLE=2'b10;
    
    reg [1:0]state;
    reg [1:0] nxt_state;
    //reg slverr;
    
    always@(posedge clk or negedge rst)
    begin
        if(~rst)
        begin
            state<=0;
            SLVERR<=0;
        end
        else
        begin
            state<=nxt_state;
        end
    end
    
    
    always@(*)
    begin
        case(state)
        
            IDLE:
                begin
                    PENABLE=0;
                    if(transfer)nxt_state=SETUP;
                    else nxt_state=IDLE;
                end
                
            SETUP:
                begin
                    PENABLE=0;
                    PWRITE=wr_rd;
                    if(wr_rd)
                    begin
                        PADDR=wr_addr;
                        PWDATA=wr_data;
                    end
                    else PADDR=rd_addr;
                    
                    if(transfer || ~SLVERR)nxt_state=ENABLE;
                    else nxt_state=IDLE;
                end
                
             ENABLE:
                  begin
                    PENABLE=1;
                    if(PREADY && ~SLVERR)
                    begin
                        RD_DATA=PRD_DATA;
                        if(transfer)nxt_state=SETUP;
                        else nxt_state=IDLE;
                    end
                    else
                    begin
                        if(~PREADY)nxt_state=ENABLE;
                        else nxt_state=SETUP;
                    end
                  end
              default:nxt_state=IDLE;
        endcase 
    end
    
    
    
    
    
    
    
    assign PSEL1=PADDR[8] ? 1'b0 :1'b1;
    assign PSEL2=PADDR[8] ? 1'b1 :1'b0;
endmodule