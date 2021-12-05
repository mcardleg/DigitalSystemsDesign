`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TCD
// Engineer: Gwen McArdle
// Module Name: two_bit_equal
//////////////////////////////////////////////////////////////////////////////////

module two_bit_equal(                   //previously known as eq2
    input wire [1:0] a, b,
    output wire aeqb );
    
    wire e0, e1;
    
    one_bit_equal eq_bit0_unit (.i0(a[0]), .i1(b[0]), .eq(e0));         //
    one_bit_equal eq_bit1_unit (.i0(a[1]), .i1(b[1]), .eq(e1));
    
    assign aeqb = e0 & e1;
    
endmodule
