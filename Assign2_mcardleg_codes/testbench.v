`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TCD
// Engineer: Gwen McArdle
// Create Date: 13.12.2020 22:21:45
// Module Name: testbench
// Project Name: Assignment 2
//////////////////////////////////////////////////////////////////////////////////

module testbench();

    wire max_tick, stream;
    wire [19:0] count;
    reg clk, reset, sh_en;
    wire [3:0] d0, d1, d2, d3;
        
    lfsr_19bit M0 (.clk(clk), .sh_en(sh_en), .rst_n(reset), .max_tick_reg(max_tick), .Q_out(stream));
    stop_watch_if M1 (.stream(stream), .clk(clk), .go(sh_en), .clr(reset), .d3(d3), .d2(d2), .d1(d1), .d0(d0), .count(count));
        
    initial begin
        clk = 1'b1;
        forever begin
            #0.05 clk = !clk;         //Therefore, clock cycle is 0.00002ns
        end  
    end  
        
    initial begin
        reset = 1'b1;
        sh_en = 1'b0;
        #1                            //10 clock cycles                       
        reset = 1'b0;              
        sh_en = 1'b1;
        #52600                        //(2^19) - 1 = 524287 clock cycles = 52428.7 ns. 52600 gives time for the cycle to start again
        sh_en = 1'b0;        
    end       
    
    
    
endmodule
