module pe_l(
    // Default signals
    input clk,
    input rst,
    
    // Inputs

    // A inputs
    input am_1,  // a(0,m-1)
    input am_2,  // a(0,m-2)
    input aim_2, // a(i,m-2)
    
    // B input
    input bi,    // b(i)
    
    // f input
    input fm_1, // f(m-1)

    // Control Signal
    input Ma,

    // Outputs     
    output aim_1, // a(i,m-1)
    output cmm_1 // c(m.j)
);
    
    wire mux1_out, mux2_out, mux3_out;
    wire latch_Da_in,latch_Dc_in;
    
    reg latch_Da_out, latch_Dc_out;

    // Mux Logic to Initialize
    assign mux1_out = Ma ? am_1 : latch_Da_out;
    assign mux2_out = Ma ? am_2 : aim_2;
    assign mux3_out = Ma ? am_1 : latch_Da_out ; 

    // Latch inputs
    assign  latch_Da_in = (fm_1 & mux1_out) ^ mux2_out ; 
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
    assign aim_1 = latch_Da_out;
    assign cmm_1 = latch_Dc_in;


endmodule
