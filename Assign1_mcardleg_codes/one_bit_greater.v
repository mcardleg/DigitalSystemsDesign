module one_bit_greater
   // I/O ports
   (
    input wire i0, i1,
    output wire greater
   );

   assign greater = i0 & ~i1;


endmodule