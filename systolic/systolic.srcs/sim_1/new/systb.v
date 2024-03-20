`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 04:06:56 PM
// Design Name: 
// Module Name: systb
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

module systolic_tb();
parameter M=7;
reg clk;
reg rst;
reg start;
reg [M-1:0]a;
reg [M-1:0]b;
reg [M:0]f;
wire [M-1:0]c;
wire over;



//clock generations
initial begin
    clk=1;
    start<=1'b0;
end

always #5 clk=~clk;
systolic_top  #(.M(7)) systb(clk, rst,start,a,b,f,c,over);

initial begin
    $monitor($time,"a=%b b=%b f=%f start=%b f=%b\n",a,b,f,start,f);
    rst<=1'b1;
    #10 rst<=1'b0;
    a<='b1010101;
    b<='b1101010;
    f<='b11001101;
    start<=1'b1;
    #100
    $finish;

end

endmodule