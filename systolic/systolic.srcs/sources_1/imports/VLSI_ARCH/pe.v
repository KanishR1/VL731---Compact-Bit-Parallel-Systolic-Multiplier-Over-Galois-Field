module pe(
    // Default signals
    input clk,
    input rst,
    
    // Inputs

    // A inputs
    input am_1,  // a(0,m-1)
    input aim_1, // a(i,m-1)
    input aj,    // a(0,j)
    input aj_1,  // a(0,j-1)
    input aij_1, // a(i,j-1)
    
    // B input
    input bi,    // b(i)
    
    // f input
    input fj,

    // Control Signal
    input Ma,

    // Outputs     
    output aij, // a(i,j)
    output cmj // c(m.j)
);
    
    wire mux1_out, mux2_out, mux3_out;
    wire latch_Da_in,latch_Dc_in;
    
    reg latch_Da_out, latch_Dc_out;

    // Mux Logic to Initialize
    assign mux1_out = Ma ? am_1 : aim_1;
    assign mux2_out = Ma ? aj_1 : aij_1;
    assign mux3_out = Ma ? aj : aij ; 

    // Latch inputs
    assign  latch_Da_in = (fj & mux1_out) ^ mux2_out ; 
    assign  latch_Dc_in = (bi & mux3_out) ^ latch_Dc_out;

    // Logic for Da and Dc latches 
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            latch_Da_out <= 'd0;
            latch_Dc_out <= 'd0;
        end 
        else begin
            latch_Da_out <= latch_Da_in;
            latch_Dc_out <= latch_Dc_in;
        end
    end

    // Output assignment
    assign aij = latch_Da_out;
    assign cmj = latch_Dc_in;


endmodule
