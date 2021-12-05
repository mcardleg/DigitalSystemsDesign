// Listing 4.18
module stop_watch_if
   (
    input wire stream,                                          //line added
    input wire clk,
    input wire go, clr,
    output wire [3:0] d3, d2, d1, d0,
    output wire [19:0] count
    );

   // declaration
   localparam  DVSR = 10000000;
   reg [23:0] ms_reg;
   wire [23:0] ms_next;
   reg [3:0] d3_reg, d2_reg, d1_reg, d0_reg;                    //d3_reg added
   reg [3:0] d3_next, d2_next, d1_next, d0_next;                //d3_next added
   wire ms_tick;
   wire detected;
   
   sequence_detector M4 (.clk(clk), .reset(clr), .stream(stream), .detected(detected));               //line added                                                            

   // body
   // register
   always @(posedge clk)
   begin
      ms_reg <= ms_next;
      d3_reg <= d3_next;                                        //line added
      d2_reg <= d2_next;
      d1_reg <= d1_next;
      d0_reg <= d0_next;
   end

   // next-state logic
   // 0.1 sec tick generator: mod-5000000
   assign ms_next = (clr || (ms_reg==DVSR && go)) ? 4'b0 :
                    (go) ? ms_reg + 1 :
                           ms_reg;
   assign ms_tick = (ms_reg==DVSR) ? 1'b1 : 1'b0;
   // 3-digit bcd counter
   always @*
   begin
      // default: keep the previous value
      d0_next = d0_reg;
      d1_next = d1_reg;
      d2_next = d2_reg;
      d3_next = d3_reg;                                         //line added
      if (clr)
         begin
            d0_next = 4'b0;
            d1_next = 4'b0;
            d2_next = 4'b0;
            d3_next = 4'b0;                                     //line added
      end
      else if (detected) begin                  //"&& detected" added
            if (d0_reg != 9)
                d0_next = d0_reg + 1;
            else              // reach XXX9
                begin
                d0_next = 4'b0;
                if (d1_reg != 9) 
                     d1_next = d1_reg + 1;
                else        // reach XX99
                     begin
                     d1_next = 4'b0;                       
                     if (d2_reg != 9)                        
                        d2_next = d2_reg + 1;
                     else  // reach X599
                        begin                                   //line added
                            d2_next = 4'b0;                     
                            if (d3_next != 9)                   //line added
                                d3_next = d3_next + 1;          //line added
                            else  //reach 9599                  //line added
                                d3_next = 4'b0;                 //line added
                     end       
                end                                        //line added
            end
      end
   end

   // output logic
   assign d0 = d0_reg;
   assign d1 = d1_reg;
   assign d2 = d2_reg;
   assign d3 = d3_reg;                                          //line added
   
    reg [19:0] counter, counter_next;
    always @(posedge clk) begin
         counter <= counter_next;
    end
   
    always @ (*) begin
         counter_next = counter;
         if (clr) counter_next = 0;
         else if (detected) counter_next = counter + 1;
    end
   
    assign count = counter;


endmodule