`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 12:12:59 PM
// Design Name: 
// Module Name: systolic_top
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


module systolic_top #(
parameter M = 2 // Degree of Galois Feild
)(
    input clk,
    input rst,
    input start,
    input [M-1:0]a,
    input [M-1:0]b,
    input [M:0]f,
    output [M-1:0]c,
    output over
);

    localparam INITIALIZE = 'b0,
               TRANSMIT =  'b1;
               
    
    reg Ma;
    reg [1:0] state;
    reg [M-1:0] b_reg;
    reg over_reg;
    

    always @(posedge clk) begin
        if(rst) begin
            Ma <= 'd0;
            state <= INITIALIZE;
            b_reg <= 'd0;
            over_reg <= 'd0;
        end
        else begin
            case(state)
                INITIALIZE : begin
                                over_reg = 'd0;
                                if(start) begin
                                    Ma = 'd1;
                                    b_reg = b;
                                    state = TRANSMIT;
                                end
                                else begin
                                    Ma = 'd0;
                                    state = INITIALIZE;
                                end
                             end
                 
                TRANSMIT : begin
                              Ma = 'd0;
                              if(|b_reg) begin
                                   b_reg = b_reg>>1;
                                   state = TRANSMIT;
                              end
                              else begin
                                   over_reg = 'd1;
                                   state = INITIALIZE;
                              end
                           end             
            endcase            
        end
    end
    
    assign over = over_reg;
    
    wire aim_1_wire;
    wire [M-2:0]aij_reg;
    
    genvar i;
    generate for(i=0; i<M; i=i+1) begin
        if(i== (M-1)) begin
            pe_l last(.clk(clk), .rst(rst), .am_1(a[i]), .am_2(a[i-1]), .aim_2(aij_reg[i-1]), .bi(b_reg[0]), .fm_1(f[M-1]), .Ma(Ma), .aim_1(aim_1_wire), .cmm_1(c[i]));
        end
        else if(i==0) begin
            pe PE(.clk(clk), .rst(rst), .am_1(a[M-1]), .aim_1(aim_1_wire), .aj(a[i]), .aj_1(1'b0), .aij_1(1'b0), .bi(b_reg[0]), .fj(f[i]), .Ma(Ma), .aij(aij_reg[i]), .cmj(c[i]));
        end
        else begin
            pe PE(.clk(clk), .rst(rst), .am_1(a[M-1]), .aim_1(aim_1_wire), .aj(a[i]), .aj_1(a[i-1]), .aij_1(aij_reg[i-1]), .bi(b_reg[0]), .fj(f[i]), .Ma(Ma), .aij(aij_reg[i]), .cmj(c[i]));
        end
    end
    endgenerate

endmodule
