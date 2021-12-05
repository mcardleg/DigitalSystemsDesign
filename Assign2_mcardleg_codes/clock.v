`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TCD
// Engineer: Gwen McArdle
// Create Date: 30.11.2020 23:38:54
// Module Name: clock
// Project Name: Lab F
//////////////////////////////////////////////////////////////////////////////////

module clock(input CCLK, input [31:0] clkscale, output reg clk);

reg [31:0] clkq = 0;

always @ (posedge CCLK) begin
    clkq = clkq + 1;
    if (clkq >= clkscale) begin
        clk = ~clk;
        clkq = 0;
    end
end

endmodule
