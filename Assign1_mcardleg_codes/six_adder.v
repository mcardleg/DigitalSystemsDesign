`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Gwen McArdle 
// Create Date: 24.10.2020 17:52:00
// Module Name: six_adder
//////////////////////////////////////////////////////////////////////////////////

module six_adder(x, y, sel, c_out, sum, overflow);

//Inputs
//X and y are the six bit inputs to be added. 
//Sel is a single bit input that signals if addition or subtraction should be carried out.
  input wire[5:0] x, y;
  input wire sel;
  
//Outputs
//Sum is the six bit output that contains the result of the operation.
//Overflow is a single bit output signifying whether the result fitted into six bits or overflowed.
//C_out is a single bit output containing the carry of the final full adder.

  output wire overflow, c_out;
  output wire[5:0] sum;
  
//These wires connect the carry from from the previous full adder to the next one.
  wire c0, c1, c2, c3, c4, c5;
  
//For subtraction y must be inverted and 1 added to the lease significant bit.
//This wire is the inverse of y when sel is 1.  
  wire [5:0] comp_y;
  
//These xor gates invert y when sel is 1.
  xor xor0 (comp_y[0], sel, y[0]);
  xor xor1 (comp_y[1], sel, y[1]);
  xor xor2 (comp_y[2], sel, y[2]);
  xor xor3 (comp_y[3], sel, y[3]);
  xor xor4 (comp_y[4], sel, y[4]);
  xor xor5 (comp_y[5], sel, y[5]);
  
//The full adder module is called on for each bit.
//The cin input to the first full adder is sel, so that 1 is added to the least significant bit for subtraction.
  FullAdder full_adder0(.a(x[0]), .b(comp_y[0]), .cin(sel), .s(sum[0]), .cout(c0));
  FullAdder full_adder1(.a(x[1]), .b(comp_y[1]), .cin(c0), .s(sum[1]), .cout(c1));
  FullAdder full_adder2(.a(x[2]), .b(comp_y[2]), .cin(c1), .s(sum[2]), .cout(c2));
  FullAdder full_adder3(.a(x[3]), .b(comp_y[3]), .cin(c2), .s(sum[3]), .cout(c3));
  FullAdder full_adder4(.a(x[4]), .b(comp_y[4]), .cin(c3), .s(sum[4]), .cout(c4));
  FullAdder full_adder5(.a(x[5]), .b(comp_y[5]), .cin(c4), .s(sum[5]), .cout(c5));

//The carry and overflow for addition are as follows.
  assign c_out = c5;
//  assign overflow = c_out;
  
  xor xor6 (overflow, c4, c5);
  
endmodule
