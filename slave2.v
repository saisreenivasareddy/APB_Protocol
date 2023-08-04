`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.07.2023 15:01:13
// Design Name: 
// Module Name: slave2
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


module slave2(
         input clk,reset,
         input PSEL,PENABLE,PWRITE,
         input [7:0]PADDR,PWDATA,
        output reg [7:0]PRDATA2,
        output reg PREADY2 );
    
     reg [7:0] mem [7:0];
     always@(*)
     begin
        if(~reset)
        begin
            PRDATA2=0;
            PREADY2=0;
        end
        else if (PSEL && PENABLE && PWRITE)
        begin
            PREADY2=1;
            mem[PADDR]=PWDATA;
        end
        else if(PSEL && PENABLE && ~PWRITE)
        begin
            PREADY2=1;
            PRDATA2=mem[PADDR];
        end
        
        else PREADY2=0;
     end
    endmodule
