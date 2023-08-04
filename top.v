`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.07.2023 21:42:43
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


module top(
    input clk,
    input reset,
    input transfer,
    input wr_rd,
    input [8:0]wr_addr,
    input [8:0]rd_addr,
    input [7:0]wr_data,
    output wire pslverr,
    output wire [7:0]read_data
    );
    
    wire PREADY;
    wire [7:0]PRD_DATA;
    
    wire PENABLE,PWRITE;
    wire [7:0]PWDATA;
    wire [8:0]PADDR;
    wire PSEL1,PSEL2;
    wire [7:0]RD_DATA;
    
    wire [7:0]PRDATA1;
    wire [7:0]PRDATA2;
    wire PREADY1,PREADY2;
    wire SLVERR;
    APB m2(clk,reset,transfer,wr_rd,wr_addr,wr_data,rd_addr,PREADY,PRD_DATA,PENABLE,PWRITE,PWDATA,PADDR,PSEL1,PSEL2,RD_DATA,SLVERR);
    
    assign read_data=RD_DATA;
    assign PREADY = (wr_rd) ? (wr_addr[8] ? PREADY2 : PREADY1) : (rd_addr[8] ? PREADY2 :PREADY1);
    assign PRD_DATA = (wr_rd) ? 'bx : (rd_addr[8] ? PRDATA2 :PRDATA1);
    assign pslverr=SLVERR;
    
    slave1 m3(clk,reset,PSEL1,PENABLE,PWRITE,PADDR,PWDATA,PRDATA1,PREADY1);
    slave2 m4(clk,reset,PSEL2,PENABLE,PWRITE,PADDR,PWDATA,PRDATA2,PREADY2);
    
endmodule