`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.07.2023 15:00:30
// Design Name: 
// Module Name: slave1
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


module slave1(
         input clk,reset,
         input PSEL,PENABLE,PWRITE,
         input [7:0]PADDR,PWDATA,
        output reg [7:0]PRDATA1,
        output reg PREADY1 );
    
     reg [7:0] mem [7:0];
     always@(*)
     begin
        if(~reset)
        begin
            PRDATA1=0;
            PREADY1=0;
        end
        else if (PSEL && PENABLE && PWRITE)
        begin
            PREADY1=1;
            mem[PADDR]=PWDATA;
        end
        else if(PSEL && PENABLE && ~PWRITE)
        begin
            PREADY1=1;
            PRDATA1=mem[PADDR];
        end
        
        else PREADY1=0;
     end
    endmodule
