`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TCD
// Engineer: Gwen McArdle
// Create Date: 13.12.2020 22:21:45
// Module Name: top_module
// Project Name: Assignment 2
//////////////////////////////////////////////////////////////////////////////////

module top_module(CCLK, reset, go, max_tick, sseg, an);

    input wire CCLK, reset, go;
    output wire max_tick;
    output wire [7:0] sseg;
    output wire [3:0] an;
    
    wire clk;
    wire [3:0] d0, d1, d2, d3;
    
    clock M0 (CCLK, 100000, clk);
    lfsr_19bit M1 (.clk(clk), .sh_en(go), .rst_n(reset), .max_tick_reg(max_tick), .Q_out(stream));
    stop_watch_if M2 (.stream(stream), .clk(clk), .go(go), .clr(reset), .d3(d3), .d2(d2), .d1(d1), .d0(d0));
    disp_hex_mux M3 (.clk(CCLK), .reset(1'b0), .hex3(d3), .hex2(d2), .hex1(d1), .hex0(d0), .dp_in(4'b1111), .an(an), .sseg(sseg));  
    
    
endmodule
