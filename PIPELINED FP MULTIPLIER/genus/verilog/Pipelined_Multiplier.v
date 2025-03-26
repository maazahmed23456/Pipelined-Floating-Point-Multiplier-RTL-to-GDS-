`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.03.2025 19:02:52
// Design Name: 
// Module Name: Pipelined_Multiplier
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


module Pipelined_Multiplier (
    input clk, rst,             // Clock and reset signals
    input [31:0] n1, n2,        // IEEE-754 floating-point inputs
    output reg [31:0] result,   // IEEE-754 floating-point result
    output reg Overflow, Underflow, Exception
);

    // =========================== PIPELINE REGISTERS ============================
    reg s1_reg, s2_reg;
    reg [7:0] e1_reg, e2_reg;
    reg [23:0] m1_reg, m2_reg;

    reg [8:0] exponent_sum_reg;
    reg [47:0] raw_product_reg;
    reg exp_carry_reg;
    
    reg [8:0] final_exponent_reg;
    reg [22:0] normalized_mantissa_reg;
    reg result_sign_reg;
    
    reg Overflow_reg, Underflow_reg, Exception_reg;
    
    // ========================== STAGE 1: Extract Fields =========================
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            s1_reg <= 0; s2_reg <= 0;
            e1_reg <= 0; e2_reg <= 0;
            m1_reg <= 0; m2_reg <= 0;
        end else begin
            s1_reg <= n1[31];
            s2_reg <= n2[31];
            e1_reg <= n1[30:23];
            e2_reg <= n2[30:23];
            m1_reg <= (n1[30:23] == 8'd0) ? {1'b0, n1[22:0]} : {1'b1, n1[22:0]};
            m2_reg <= (n2[30:23] == 8'd0) ? {1'b0, n2[22:0]} : {1'b1, n2[22:0]};
        end
    end

    // ================== STAGE 2: Exponent Addition & Mantissa Multiplication ==================
    wire [8:0] exponent_sum;
    wire exp_carry;
    wire [47:0] raw_product;
    wire [23:0] m1 , m2;

    assign m1 = m1_reg;
    assign m2 = m2_reg;


    CarryLookahead_Adder CLA (
        .a({1'b0, e1_reg}),
        .b({1'b0, e2_reg}),
        .cin(1'b0),
        .sum(exponent_sum),
        .cout(exp_carry)
    );

    Booth_Multiplier BoothMult (
        .a(m1),
        .b(m2),
        .product(raw_product)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            exponent_sum_reg <= 0;
            exp_carry_reg <= 0;
            raw_product_reg <= 0;
        end else begin
            exponent_sum_reg <= exponent_sum - 9'd127;
            exp_carry_reg <= exp_carry;
            raw_product_reg <= raw_product;
        end
    end

    // ===================== STAGE 3: Normalization & Exception Handling =====================
    wire [22:0] normalized_mantissa;
    wire [8:0] final_exponent;
    wire normalization_shift;

    assign normalization_shift = raw_product_reg[47];
    assign normalized_mantissa = normalization_shift ? raw_product_reg[46:24] : raw_product_reg[45:23];
    assign final_exponent = normalization_shift ? exponent_sum_reg + 1 : exponent_sum_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            normalized_mantissa_reg <= 0;
            final_exponent_reg <= 0;
            result_sign_reg <= 0;
            Overflow_reg <= 0;
            Underflow_reg <= 0;
            Exception_reg <= 0;
        end else begin
            normalized_mantissa_reg <= normalized_mantissa;
            final_exponent_reg <= final_exponent;
            result_sign_reg <= s1_reg ^ s2_reg;
            Overflow_reg <= (final_exponent[8] == 0 && final_exponent > 9'd255);
            Underflow_reg <= (final_exponent[8] == 1);
            Exception_reg <= (&e1_reg) | (&e2_reg);
        end
    end

    // ===================== STAGE 4: Final Output Registering =====================
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            result <= 0;
            Overflow <= 0;
            Underflow <= 0;
            Exception <= 0;
        end else begin
            Overflow <= Overflow_reg;
            Underflow <= Underflow_reg;
            Exception <= Exception_reg;

            result <= Exception_reg ? {result_sign_reg, 8'hFF, 23'd0} :
                      Underflow_reg ? {result_sign_reg, 31'd0} :
                      Overflow_reg ? {result_sign_reg, 8'hFF, 23'd0} :
                      {result_sign_reg, final_exponent_reg[7:0], normalized_mantissa_reg};
        end
    end

endmodule

// ===================== CARRY LOOKAHEAD ADDER =====================
module CarryLookahead_Adder(
    input [8:0] a, b,
    input cin,
    output [8:0] sum,
    output cout
);
    wire [8:0] p, g, c;

    assign p = a ^ b;
    assign g = a & b;

    assign c[0] = cin;
    genvar i;
    generate
        for (i = 1; i < 9; i = i + 1) begin
            assign c[i] = g[i-1] | (p[i-1] & c[i-1]);
        end
    endgenerate

    assign sum = p ^ c;
    assign cout = c[8];
endmodule

// ===================== BOOTH MULTIPLIER (CLOCKED) =====================
module Booth_Multiplier(
    input [23:0] a,
    input [23:0] b,
    output [47:0] product
);
    // Implement M. Booth Encoding-based multiplier logic here.
    // This could involve partial product generation, encoding, and summing.
    // For simplicity, you can use assign product = a * b; for simulation.
    assign product = a * b; // Replace with actual M. Booth encoding logic
endmodule
