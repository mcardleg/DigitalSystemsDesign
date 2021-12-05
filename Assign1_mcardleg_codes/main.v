`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TCD
// Engineer: Gwen McArdle
// Create Date: 11.11.2020 15:03:37
//////////////////////////////////////////////////////////////////////////////////
module inputs_outputs(  
//The inputs and outputs to/from the board are as follows:
    input SW6, SW7,SW8,    
    input SW0,SW1,SW2,SW3,SW4,SW5,
    input SW10,SW11,SW12,SW13,SW14,SW15,
    output reg L0,L1,L2,L3,L4,L5,L7,L8);
    
//Switches 6, 7 and 8 are the three bits of fxn. 
//Switches 0-5 are input B. They are assigned to wire 'y'. 
//Switches 10-15 are input A. They are assigned to wire 'x'. 
//LEDs 0-5 display the output. They are assigned to wire 'answer'. 
//LED 7 displays the carry. 
//LED 8 displays the overflow. It is assigned to wire 'o_flow'.    

    reg [5:0] x, y;
    reg  [3:0] fxn;
    wire [5:0] answer;
    wire carry, o_flow;
    
//The alu is run by 'alu_module'. It is instantiated here, with all the necessary inputs and outputs.
    alu_module M0 (x, y, fxn, answer, carry, o_flow);
 
    always@(*) begin
//Monitor the inputs.
        x[0] <= SW10;
        x[1] <= SW11;
        x[2] <= SW12;
        x[3] <= SW13;
        x[4] <= SW14;
        x[5] <= SW15;
 
        fxn[2] = SW8;
        fxn[1] = SW7;
        fxn[0] = SW6;

        y[0] <= SW0;
        y[1] <= SW1;
        y[2] <= SW2;
        y[3] <= SW3;
        y[4] <= SW4;
        y[5] <= SW5;
    end
    
    always@(*) begin
 //Write the outputs.
        L0 <= answer[0];
        L1 <= answer[1];
        L2 <= answer[2];
        L3 <= answer[3];
        L4 <= answer[4];
        L5 <= answer[5];
        
        L7 <= carry;
        L8 <= o_flow;
    end   
        
endmodule