// Listing 1.4
module two_bit_greater                      //previously known as eq3
   (
    input  wire[1:0] a, b,			// a adn b are the two 2-bit numbers to compare
    output wire agreaterb				// single bit output. Should be high if a adn b the same
   );

   // internal signal declaration, used to wire outpus of the 1 bit comparators
   wire e0, e1, e2;

   one_bit_greater eq_bit0_unit (.i0(a[0]), .i1(b[0]), .greater(e0));  
   one_bit_equal eq_bit1_unit (.i0(a[0]), .i1(b[0]), .eq(e1));
   one_bit_greater eq_bit2_unit (.i0(a[1]), .i1(b[1]), .greater(e2));

   // a is greater than b if the first bit of a is greater than the first bit of b.
   // a is also greater than b if the first bits are equal, and the second bit of a is greater than the second bit of b.
   wire p2;
   assign p2 = e1 & e2;
   
   assign agreaterb = e0 | p2;           

endmodule