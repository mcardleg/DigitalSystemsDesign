`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TCD
// Engineer: Gwen McArdle
// Create Date: 15.11.2020 17:25:23
// Module Name: bitwise_xnor
//////////////////////////////////////////////////////////////////////////////////

module bitwise_xnor(
    input wire [7:0] A, B,
    output wire [5:0] nxor_check );
        
    one_bit_equal M5 (.i0(A[0]), .i1(B[0]), .eq(nxor_check[0]));
    one_bit_equal M6 (.i0(A[1]), .i1(B[1]), .eq(nxor_check[1]));
    one_bit_equal M7 (.i0(A[2]), .i1(B[2]), .eq(nxor_check[2]));
    one_bit_equal M8 (.i0(A[3]), .i1(B[3]), .eq(nxor_check[3]));
    one_bit_equal M9 (.i0(A[4]), .i1(B[4]), .eq(nxor_check[4]));
    one_bit_equal M10 (.i0(A[5]), .i1(B[5]), .eq(nxor_check[5]));
        
endmodule

