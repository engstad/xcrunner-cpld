// -*- verilog-mode -*-

// `define USE_FTCP 1

module my_ftcp(C, T, Q);
   input C, T;
   output wire Q;
   reg         Q_;

   initial begin
      Q_ <= 0;
   end

   always @(posedge C) begin
      if (T == 1)
        Q_ <= ~Q_;      
   end
   
   assign Q = Q_;
endmodule // my_ftcp

module top(led0, led1, led2, led3, led4, led5, led6, led7, clk1);
   // NOTE: Must use LOC attributes rather than a .ucf file
   // (* LOC = "FB2_7" *) input clk_50Mhz;
   (* LOC = "FB2_8" *) input clk1;
   
   (* LOC = "FB1_1" *) output led0;
   (* LOC = "FB1_2" *) output led1;
   (* LOC = "FB1_3" *) output led2;
   (* LOC = "FB1_9" *) output led3;
   (* LOC = "FB1_10" *) output led4;
   (* LOC = "FB1_11" *) output led5;
   (* LOC = "FB1_12" *) output led6;
   (* LOC = "FB1_13" *) output led7;

   // NOTE: Must manually instantiate BUFG
   wire clk;
   BUFG bufg0 (.I(clk1), .O(clk));

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

   localparam COUNTER_BITS = 24;   
   
`ifdef USE_FTCP
   wire [COUNTER_BITS:0] counter;
   genvar      i;   
   for (i = 0; i <= COUNTER_BITS; i++) begin : gen_ftcp
      my_ftcp ftcp(.C(clk), .T((i == 0) ? 1 : & counter[i-1:1]), .Q(counter[i]));
   end
`else
   reg [COUNTER_BITS:0] counter;
   always @(posedge clk) begin
      counter <= counter + 1;      
   end
`endif

   assign led7 = counter[COUNTER_BITS-1];
   assign led6 = counter[COUNTER_BITS-2];
   assign led5 = counter[COUNTER_BITS-3];
   assign led4 = counter[COUNTER_BITS-4];
   assign led3 = counter[COUNTER_BITS-5];
   assign led2 = counter[COUNTER_BITS-6];
   assign led1 = counter[COUNTER_BITS-7];
   assign led0 = counter[COUNTER_BITS-8];

endmodule // top

   // 50 Mhz => 1 sec = 50,000,000 ticks.
   //                 = 10_1111_1010_1111_0000_1000_0000 ticks
   //                    ^24  ^20  ^16  ^12  ^8   ^4   ^0
   // Toggling bit 0 takes 1 tick,
   // Toggling bit 1 takes 2 ticks,
   // Toggling bit n takes 2^n ticks.
   // By toggling on bit 26, the period should be 2^26 = 67,108,864 ticks = 1.34 sec


