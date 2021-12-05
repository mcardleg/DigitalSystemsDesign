`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TCD
// Engineer: Gwen McArdle
// Create Date: 15.11.2020 15:56:30
// Module Name: alu
//////////////////////////////////////////////////////////////////////////////////

module alu_module(
    input [5:0] x, y,
    input [3:0] fxn,
    output reg [5:0] answer, 
    output reg carry, o_flow);

//Wires are declared for signals that will not be written to in this module.
//Regs are declared for signals that will be written to on this module.    
    wire [5:0] sum, nxor_check;
    reg [5:0] A, B;
    wire less, c_out, overflow;
    reg sel;
   
//'six_adder' is instantiated so that it can provide the answer if fxn = 000, 001, 010, 011, 110 or 111.    
    six_adder M1 (.x(A), .y(B), .sel(sel), .c_out(c_out), .sum(sum), .overflow(overflow));
    
//'two_compliment_less' is instantiated so that it can provide the answer if fxn = 100.  
    twos_compliment_less M2 (.x(A), .y(B), .answer(less));    
    
//'bitwise_xnor' is instantiated so that it can provide the answer if fxn = 101.  
    bitwise_xnor M3 (.A(A), .B(B), .nxor_check(nxor_check));
    
    always@(*) begin
        case(fxn)
            //A is outputted when A is added to zero.
            3'b000: begin
                A = x;
                sel = 1'b0;                
                B = 6'b000000;
                answer = sum;
                carry = c_out;
                o_flow = overflow;    
            end 
            
            //B is outputted when zero is added to B.
            3'b001: begin
                A = 6'b000000;
                sel = 1'b0;                
                B = y;
                answer = sum;
                carry = c_out;
                o_flow = overflow;    
            end
            
            //-A is outputted when A is subtracted from zero.
            3'b010: begin
                A = 6'b000000;
                sel = 1'b1;                
                B = x;
                answer = sum;
                carry = c_out;
                o_flow = overflow;        
            end 
            
            //-B is outputted when B is subtracted from zero.
            3'b011: begin
                A = 6'b000000;
                sel = 1'b1;                
                B = y;     
                answer = sum; 
                carry = c_out;
                o_flow = overflow;         
            end
            
            //'twos_compliment_less checks if A < B. Irrelevant inputs and outputs are set to zero.
            3'b100: begin
                A = x;
                B = y;
                answer = less; 
                carry = 1'b0;
                o_flow = 1'b0;  
                sel = 1'b0;                
            end                             
            
            //'bitwise_xnor' checks which corresponding bits are equal. Irrelevant inputs and outputs are set to zero.
            3'b101: begin
                A = x;
                B = y;
                answer = nxor_check;
                carry = 1'b0;
                o_flow = 1'b0;
                sel = 1'b0;                
            end
            
            //A and B are added together.
            3'b110: begin
                A = x;
                sel = 1'b0;                
                B = y;
                answer = sum;
                carry = c_out;
                o_flow = overflow;                    
            end
            
            //B is subtracted from A.
            3'b111: begin
                A = x;
                sel = 1'b1;                
                B = y;
                answer = sum;
                carry = c_out;
                o_flow = overflow;    
            end         
        endcase                   
    end
                
endmodule
