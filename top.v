// FB1_1 : P38 : pmod0
// FB1_2 : P37 : pmod1
// FB1_3 : P36 : pmod2
// FB1_4 : P34 : pmod3       (GTS1)
// FB1_5 : P33 : led0/pmod4  (GTS0)
// FB1_6 : P32 : led1/pmod5  (GTS3)
// FB1_7 : P31 : led2/pmod6  (GTS2)
// FB1_8 : P30 : led3/pmod7  (GSR)
// FB1_9 : P29 : led4
// FB1_10: P28 : led5
// FB1_11: P27 : led6
// FB1_12: P23 : led7
// FB1_13: P22 : but0
// FB1_14: P21 : but1
// FB1_15: P20 : but2
// FB1_16: P19 : btn3

// FB2_1 : P39 : ctrl0
// FB2_2 : P40 : ctrl1
// FB2_3 : P41 : ctrl2
// FB2_4 : P42 : ctrl3
// FB2_5 : P43 : clk0  (GCK0)
// FB2_6 : P44 : clk1  (GCK1)
// FB2_7 : P1  : clk2  (GCK2)
// FB2_8 : P2  : nc
// FB2_9 : P3  : data0
// FB2_10: P5  : data1
// FB2_11: P6  : data2
// FB2_12: P8  : data3
// FB2_13: P12 : data4
// FB2_14: P13 : data5
// FB2_15: P14 : data6
// FB2_16: P16 : data7

// FB3_1 : P18 : input_only

module top(output led0, output led1, output led2, output led3,
           output led4, output led5, output led6, output led7,
           input data0, input data1, input data2, input data3,
           input data4, input data5, input data6, input data7,
           input clk_50Mhz);

   // NOTE: Must manually instantiate BUFG
   wire clk;
   BUFG bufg0 (.I(clk_50Mhz), .O(clk));

   assign led0 = data0;
   assign led1 = data1;
   assign led2 = data2;
   assign led3 = data3;
   assign led4 = data4;
   assign led5 = data5;
   assign led6 = data6;
   assign led7 = data7;

endmodule // top
