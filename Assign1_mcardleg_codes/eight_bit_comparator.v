`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TCD
// Engineer: Gwen McArdle
// Create Date: 27.10.2020 13:07:23
//Module Name: eight_bit_comparator
//////////////////////////////////////////////////////////////////////////////////
module eight_bit_comparator(m, n, gr, eq);             //When submitted in the previous lab, 
                                                       //there was only one output, gr_or_eq.
                                                       //They had to be seperated in order to 
                                                       //deal with negative numbers.

//NOTE: 'two_bit_equal' was previously known as eq2. I renamed it for clarity.
//NOTE: 'two_bit_greater' was previously known as eq3. I renamed it for clarity.

input [7:0] m, n;
output gr, eq;                   

//Check if bit 7 and 6 are greater. - case 0
wire r0, s0;
two_bit_greater bit76_gr_check (.a(m[7:6]), .b(n[7:6]), .agreaterb(r0));       //case0     These bits have been set to 
two_bit_equal bit76_eq_check (.a(m[7:6]), .b(n[7:6]), .aeqb(s0));                           //zero in "twos_compliment_less
                                                                                            //Therefore they will be equal
wire r1, s1;
two_bit_greater bit54_gr_check (.a(m[5:4]), .b(n[5:4]), .agreaterb(r1));       
two_bit_equal bit54_eq_check (.a(m[5:4]), .b(n[5:4]), .aeqb(s1));

wire r2, s2;
two_bit_greater bit32_gr_check (.a(m[3:2]), .b(n[3:2]), .agreaterb(r2));       
two_bit_equal bit32_eq_check (.a(m[3:2]), .b(n[3:2]), .aeqb(s2));

wire r3, s3;
two_bit_greater bit10_gr_check (.a(m[1:0]), .b(n[1:0]), .agreaterb(r3));       
two_bit_equal bit10_eq_check (.a(m[1:0]), .b(n[1:0]), .aeqb(s3));   

wire t0, t1, t2, t3;
//The m is greater than n if any of these cases are true.
assign t0 = s0 & r1;                    //case 1
assign t1 = s0 & s1 & r2;               //case 2
assign t2 = s0 & s1 & s2 & r3;          //case 3

//M is equal to n if the following case is true.
assign eq = s0 & s1 & s2 & s3;          //case 4                  

//The m is greater than n if case 0, 1, 2, 3 or 4 is true.
assign gr = r0 | t0 | t1 | t2;                 

endmodule
