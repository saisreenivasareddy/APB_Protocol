`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.07.2023 15:10:00
// Design Name: 
// Module Name: tb
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


module tb();

    reg clk;
    reg reset;
    reg transfer;
    reg wr_rd;
    reg [8:0]wr_addr;
    reg [8:0]rd_addr;
    reg [7:0]wr_data;
    wire pslverr;
    wire [7:0]read_data;
    reg [3:0]count;
    wire [3:0]N;
    assign N=6;
     
    //integer i,j,a,b;
    
    initial begin
        clk=0;
        reset=0;
        transfer=0;
        wr_rd=0;
        wr_addr=0;
        rd_addr=0;
        wr_data=0;
        count=0;
    end
    
    always #5 clk=~clk;
    
    initial begin
        #10 reset=1;
        //@(posedge clk)
        write(2,23);
        write(1,20);
        write(0,13);
        write(5,03);
        write(4,22);
        write(6,63);
        
       
        read(2);
        read(1);
        //read(3);
        read(4);
        read(5);
        read(6);
        read(0);
        //#3000 $finish();
    end
    task write(input integer n,input integer data);begin
        count=count+1;
        repeat(2)@(negedge clk)begin
        wr_rd=1;
        transfer=1;
        wr_addr=n;
        wr_data=data;
        //#5 transfer=0;
        end
        end
    endtask
    
    task read(input integer n);
    begin
        count=count+1;
        repeat(2)@(negedge clk)begin
        wr_rd=0;
        transfer=1;
        rd_addr=n;
        wr_data=0;
        wr_addr=0;
        
        //#5 transfer=0;
        end
    end
    endtask
    initial begin
        $monitor("clk=%d state=%d penable=%d pready1=%0d pready2=%0d pready=%0d pwrite1=%d pwrite2=%d  pwrite=%0d paddr=%0d",clk,m1.m2.state,m1.m2.PENABLE,m1.m3.PREADY1,m1.m4.PREADY2,m1.PREADY,m1.m3.PWRITE,m1.m4.PWRITE,m1.m2.PWRITE,m1.m2.PADDR);
        wait(count==N*2)
        #20; 
        $stop();
    end
    
    top m1(clk,reset,transfer,wr_rd,wr_addr,rd_addr,wr_data,pslverr,read_data);
endmodule
