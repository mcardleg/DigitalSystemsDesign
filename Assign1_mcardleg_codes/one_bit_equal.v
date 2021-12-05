// Listing 1.1
module one_bit_equal
   // I/O ports
   (
    input wire i0, i1,
    output wire eq
   );

   // signal declaration
   wire p0, p1;

   // body
   // sum of two product terms
      assign eq = p0 | p1;
   
  assign p0 = ~i0 & ~i1;
  assign  p1 = i0 & i1;

endmodule