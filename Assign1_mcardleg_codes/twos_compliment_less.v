`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TCD
// Engineer: Gwen McArdle
// Create Date: 15.11.2020 23:27:05
// Module Name: twos_compliment_less
//////////////////////////////////////////////////////////////////////////////////

module twos_compliment_less(
    input [5:0] x, y,
    output reg [5:0] answer );
   
//Wires are declared for signals that will not be written to in this module.
//Regs are declared for signals that will be written to on this module.        
    reg [7:0] A, B;
    wire gr, eq;
    
//'eight_bit_comparator' is instantiated so that it can provide the answer if 
// the two inputs are both positive or both negative.
    eight_bit_comparator M4 (.m(A), .n(B), .gr(gr), .eq(eq));  
    
    always@(*) begin
    
//Two new signals are created. The two MSBs of each set to zero 
//because a six bit number is being examined so two more bits are needed.   
//Bit 5 of each is set to zero because they communicate whether 
//a number is positive or negative, not it's magnitude.
//Bits 0-4 equal the corresponding bits of the inputs, so that they can be compared.
        A[7:5] = 3'b000;
        B[7:5] = 3'b000;
        A[4:0] = x[4:0]; 
        B[4:0] = y[4:0];
            
        case (x[5])
//If the signed bit of each input is 0, the comparator must check which has a greater magnitude.
//The output should be 1 if the first input is not greater than or equal to B.
//If the first input is positive and the second is negative, 
//the first cannot be less than the second, so the output should be 0.        
            1'b0: begin
                case(y[5])
                    1'b0: begin
                        answer[0] = ~gr & ~eq;
                        answer[5:1] = 5'b00000;  
                    end
                    1'b1: begin
                        answer = 6'b000000;
                    end
                endcase
            
            end
        
//If the first input is negative and the second is positive, 
//the first must be less than the second, so the output should be 1.      
//If the signed bit of each input is 1, the comparator must check which has a greater magnitude.
//The output should be 1 if the first input has a greater magnitude than B. 
//This is because they are negative numbers.
            1'b1: begin
                case(y[5])
                    1'b0: begin
                        answer = 6'b000001;  
                    end
                    1'b1: begin
                        answer[0] = gr & ~eq;
                        answer[5:1] = 5'b00000; 
                    end
                endcase
            
            end
        endcase
        
    end
    
endmodule
