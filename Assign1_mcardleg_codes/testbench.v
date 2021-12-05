`timescale 1ns / 1ps

module testbench;

//The pseudo inputs and outputs are declared to be tested.
    reg [5:0] test_x0, test_x1, test_x2, test_x3;
    reg [5:0] test_y0, test_y1, test_y2, test_y3;
    reg [3:0] test_fxn0, test_fxn1, test_fxn2, test_fxn3;
    wire [5:0] test_answer0, test_answer1, test_answer2, test_answer3;
    wire test_overflow0, test_overflow1, test_overflow2, test_overflow3;
    wire test_carry0, test_carry1, test_carry2, test_carry3;
    
//I have used the module 4 times so that all of the functions can be tested in the same waveform.
    alu_module t0 (.x(test_x0), .y(test_y0), .fxn(test_fxn0), .answer(test_answer0), .carry(test_carry0), .o_flow(test_overflow0));
    alu_module t1 (.x(test_x1), .y(test_y1), .fxn(test_fxn1), .answer(test_answer1), .carry(test_carry1), .o_flow(test_overflow1));
    alu_module t2 (.x(test_x2), .y(test_y2), .fxn(test_fxn2), .answer(test_answer2), .carry(test_carry2), .o_flow(test_overflow2));
    alu_module t3 (.x(test_x3), .y(test_y3), .fxn(test_fxn3), .answer(test_answer3), .carry(test_carry3), .o_flow(test_overflow3));


//Note each column in the waveform displays test vectos of the same function.
    initial
    begin
    
    //test A 0
    test_fxn0 = 3'b000;
    test_x0 = 6'b111111;
    test_y0 = 6'b000000;
    //test A 1
    test_fxn1 = 3'b000;
    test_x1 = 6'b000000;
    test_y1 = 6'b111111;    
    //test A 2
    test_fxn2 = 3'b000;
    test_x2 = 6'b111111;
    test_y2 = 6'b111111;    
    //test A 3
    test_fxn3 = 3'b000;
    test_x3 = 6'b101010;
    test_y3 = 6'b101010;    
    #100
    
    //test B 0
    test_fxn0 = 3'b001;
    test_x0 = 6'b111111;
    test_y0 = 6'b000000;
    //test B 1
    test_fxn1 = 3'b001;
    test_x1 = 6'b000000;
    test_y1 = 6'b111111;   
    //test B 2
    test_fxn2 = 3'b001;
    test_x2 = 6'b111111;
    test_y2 = 6'b111111;    
    //test B 3
    test_fxn3 = 3'b001;
    test_x3 = 6'b101010;
    test_y3 = 6'b101010;    
    #100 
    
    //test C 0
    test_fxn0 = 3'b010;
    test_x0 = 6'b111111;
    test_y0 = 6'b000000;
    //test C 1
    test_fxn1 = 3'b010;
    test_x1 = 6'b000000;
    test_y1 = 6'b111111;    
    //test C 2
    test_fxn2 = 3'b010;
    test_x2 = 6'b111111;
    test_y2 = 6'b111111;    
    //test C 3
    test_fxn3 = 3'b010;
    test_x3 = 6'b101010;
    test_y3 = 6'b101010;    
    #100
    
    //test D 0
    test_fxn0 = 3'b011;
    test_x0 = 6'b111111;
    test_y0 = 6'b000000;
    //test D 1
    test_fxn1 = 3'b011;
    test_x1 = 6'b000000;
    test_y1 = 6'b111111;    
    //test D 2
    test_fxn2 = 3'b011;
    test_x2 = 6'b111111;
    test_y2 = 6'b111111;    
    //test D 3
    test_fxn3 = 3'b011;
    test_x3 = 6'b101010;
    test_y3 = 6'b101010;    
    #100
    
    //test E 0
    test_fxn0 = 3'b100;
    test_x0 = 6'b111111;
    test_y0 = 6'b011111;
    //test E 1
    test_fxn1 = 3'b100;
    test_x1 = 6'b000000;
    test_y1 = 6'b100000;    
    //test E 2
    test_fxn2 = 3'b100;
    test_x2 = 6'b111110;
    test_y2 = 6'b111111;    
    //test E 3
    test_fxn3 = 3'b100;
    test_x3 = 6'b111111;
    test_y3 = 6'b111110;    
    #100 
    
    //test F 0
    test_fxn0 = 3'b101;
    test_x0 = 6'b000111;
    test_y0 = 6'b111000;
    //test F 1
    test_fxn1 = 3'b101;
    test_x1 = 6'b000000;
    test_y1 = 6'b000000;    
    //test F 2
    test_fxn2 = 3'b101;
    test_x2 = 6'b111000;
    test_y2 = 6'b000111;    
    //test F 3
    test_fxn3 = 3'b101;
    test_x3 = 6'b010111;
    test_y3 = 6'b011110;    
    #100 
    
    //test G 0
    test_fxn0 = 3'b110;
    test_x0 = 6'b010101;
    test_y0 = 6'b101010;
    //test G 1
    test_fxn1 = 3'b110;
    test_x1 = 6'b000011;
    test_y1 = 6'b100111;    
    //test G 2
    test_fxn2 = 3'b110;
    test_x2 = 6'b111110;
    test_y2 = 6'b110111;    
    //test G 3
    test_fxn3 = 3'b110;
    test_x3 = 6'b011101;
    test_y3 = 6'b011100;    
    #100 
    
    //test H 0
    test_fxn0 = 3'b111;
    test_x0 = 6'b111111;
    test_y0 = 6'b011111;
    //test H 1
    test_fxn1 = 3'b111;
    test_x1 = 6'b000000;
    test_y1 = 6'b100000;    
    //test H 2
    test_fxn2 = 3'b111;
    test_x2 = 6'b111110;
    test_y2 = 6'b110111;    
    //test H 3
    test_fxn3 = 3'b111;
    test_x3 = 6'b111111;
    test_y3 = 6'b101010;    
    #100


       
    $stop;
    end  
    
endmodule
