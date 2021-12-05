`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TCD
// Engineer: Gwen McArdle
// Create Date: 25.11.2020 15:12:16
// Module Name: shiftreg
// Project Name: LFSR
//////////////////////////////////////////////////////////////////////////////////

module lfsr_19bit
#(parameter N = 19'h13)             //my tap length is 19
(input clk, sh_en, rst_n,
output reg max_tick_reg,
output Q_out);

localparam seed = 19'h6;            //my seed is the bitwise-xnor of 73 and 48                    

reg [N-1 : 0] Q_state;
wire [N-1 : 0] Q_ns;
wire Q_fb, x1, x2;
reg [N-1 : 0] counter, c_next;

always @ (posedge clk) begin
    if (rst_n)
        Q_state <= seed;
    else if (sh_en)
        Q_state <= Q_ns;
end

always @ (posedge clk) begin
    max_tick_reg = 1'b0;
                
    if (counter == 19'h7FFF) begin             //(2^19) - 1 = 524287 = 7FFFF 
        max_tick_reg = 1'b1;
        c_next = 19'h0;
    end
    else if  (!sh_en) begin
        counter = 1'b0; 
        c_next = counter;                       //When sh_en goes to high, the counter should start at zero.
    end
    else if (sh_en) begin    
        counter = c_next; 
        c_next = counter + 1;    
    end
end

assign x1 = Q_state[18] ^ Q_state[5];          //the taps for a tap length of 19 are 19, 6, 2, 1
assign x2 = x1 ^ Q_state[1];
assign Q_fb = x2 ^ Q_state[0];                 //my feedback logic is XOR

assign Q_ns = {Q_state[N-2 : 0], Q_fb};

assign Q_out = Q_state;

endmodule





