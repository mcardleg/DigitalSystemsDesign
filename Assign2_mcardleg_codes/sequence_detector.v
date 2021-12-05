`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TCD
// Engineer: Gwen McArdle
// Create Date: 13.12.2020 16:25:19
// Module Name: sequence_detector
// Project Name: Assignment 2
//////////////////////////////////////////////////////////////////////////////////
module sequence_detector (clk, reset, stream, detected);

    input wire clk, reset;
    input wire stream;
    output wire detected;
    
    reg [4:0] current_state;
    reg [4:0] next_state;
    reg detector;
    wire [4:0] seq;
    assign seq = 5'b10011;

    always @ (posedge clk, posedge reset) begin
        if (reset) 
        current_state <= 5'b00000;
        else 
        current_state <= next_state;
    end
    
    always @ (*) begin
        case (current_state)
            5'b00000: begin
                if (stream == seq[4]) next_state = 5'b00001;
                else next_state = 0;               
            end
            5'b00001: begin
                if (stream == seq[3]) next_state = 5'b00011;
                else next_state = 0;               
            end
            5'b00011: begin
                if (stream == seq[2]) next_state = 5'b00111;
                else next_state = 0;               
            end
            5'b00111: begin
                if (stream == seq[1]) next_state = 5'b01111;
                else next_state = 0;               
            end        
            5'b01111: begin
                if (stream == seq[0]) next_state = 5'b11111;
                else next_state = 0;               
            end         
            5'b11111: begin
                next_state = 5'b00000;
                next_state = 0;
            end     
            default: next_state = 0;
        endcase   
    end
    
    always @ (*) begin
        case (current_state)
            5'b00000: begin
                detector = 0;               
            end
            5'b00001: begin
                detector = 0;               
            end
            5'b00011: begin
                detector = 0;               
            end
            5'b00111: begin
                detector = 0;                            
            end        
            5'b01111: begin
                detector = 0;                          
            end         
            5'b11111: begin
                detector = 1;                              
            end  
            default: detector = 0;   
        endcase   
    end
    
    assign detected = detector;
   
endmodule
