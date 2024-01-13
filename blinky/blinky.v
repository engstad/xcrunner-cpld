// -*- verilog-mode -*-

// FB1_1 : pmod0
// FB1_2 : pmod1
// FB1_3 : pmod2
// FB1_4 : pmod3       (GTS1)
// FB1_5 : led0/pmod4  (GTS0)
// FB1_6 : led1/pmod5  (GTS3)
// FB1_7 : led2/pmod6  (GTS2)
// FB1_8 : led3/pmod7  (GSR)
// FB1_9 : led4
// FB1_10: led5
// FB1_11: led6
// FB1_12: led7
// FB1_13: btn0
// FB1_14: btn1
// FB1_15: btn2
// FB1_16: btn3

// FB2_1 : ctrl0
// FB2_2 : ctrl1
// FB2_3 : ctrl2
// FB2_4 : ctrl3
// FB2_5 : clk0  (GCK0)
// FB2_6 : clk1  (GCK1)
// FB2_7 : clk2  (GCK2)
// FB2_8 : nc
// FB2_9 : data0
// FB2_10: data1
// FB2_11: data2
// FB2_12: data3
// FB2_13: data4
// FB2_14: data5
// FB2_15: data6
// FB2_16: data7

// FB3_1 : input


module top(led, clk_50Mhz);
   // NOTE: Must use LOC attributes rather than a .ucf file
   (* LOC = "FB2_7" *) input clk_50Mhz;
   (* LOC = "FB1_5" *) output led;   

   // NOTE: Must manually instantiate BUFG
   wire clk;
   BUFG bufg0 (.I(clk_50Mhz), .O(clk));

   wire [26:0] counter;
   //reg         reset;   

   // toggle counter[k] if (counter[k-1] & counter[k-2]).
   // counter[k-2] counter[k-1] counter[k] => counter[k]
   //      0           0             0     =>     0                0   1
   //      1           0             0     =>     0            00  0   1
   //      0           1             0     =>     0            01  0   1
   //      1           1             0     =>     1            11  1   0
   //      0           0             1     =>     1            10  0   1
   //      1           0             1     =>     1            
   //      0           1             1     =>     1
   //      1           1             1     =>     0
   
   
   //FTCP counter0(.C(clk), .PRE(1'b0), .CLR(0), .T(1'b1), .Q(counter[0]));
   //FTCP counter1(.C(clk), .PRE(1'b0), .CLR(0), .T(counter[0]), .Q(counter[1]));

   genvar      i;   
   for (i = 0; i < 27; i++) begin : gen_ftcp
      FTCP ftcp(.C(clk), .PRE(1'b0), .CLR(1'b0), .T((i == 0) ? 1 : (i == 1) ? counter[0] : counter[i-1] & counter[i-2]), .Q(counter[i]));
   end
   
   reg        LED_status;
   
   initial begin
      LED_status <= 1'b0;
      //reset <= 1'b0;      
   end

   //assign LED_status = counter[26];
   
   
   /*
   always @(posedge clk) 
     begin
        if (counter == 26'd25000000) begin
           LED_status <= ~LED_status;           
           //reset <= 1;           
        //end else begin
        //   reset <= 0;           
        end
     end
    */
   
   /*
   always @(posedge clk)
     begin
        if (reset)
          LED_status <= ~LED_status;
     end
   */
   
   // 50 Mhz => 1 sec = 50,000,000 ticks.
   //                 = 10_1111_1010_1111_0000_1000_0000 ticks
   //                    ^24  ^20  ^16  ^12  ^8   ^4   ^0
   // Toggling bit 0 takes 1 tick,
   // Toggling bit 1 takes 2 ticks,
   // Toggling bit n takes 2^n ticks.
   // By toggling on bit 26, the period should be 2^26 = 67,108,864 ticks = 1.34 sec
   
   assign led = counter[26]; //LED_status;   

endmodule // top
