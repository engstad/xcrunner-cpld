// -*- verilog-mode -*-

// FB1_1 : pmoda_0
// FB1_2 : pmoda_1
// FB1_3 : pmoda_2
// FB1_9 : pmoda_3 (GTS1)
// FB1_10: pmoda_4 (GTS0)
// FB1_11: pmoda_5 (GTS3)
// FB1_12: pmoda_6 (GTS2)
// FB1_13: pmoda_7 (GSR)

// FB3_1 : pmodb_0
// FB3_2 : pmodb_1
// FB3_3 : pmodb_2
// FB3_6 : pmodb_3
// FB3_10: pmodb_4
// FB3_11: pmodb_5
// FB3_12: pmodb_6
// FB3_14: pmodb_7

// FB2_1 : ctrl_0 [PA9 : I2C2_SCL, USART1_TX]
// FB2_2 : ctrl_1 [PA10: SPI2_MISO, USART1_RX]
// FB2_5 : ctrl_2 [PB4 : JTRST, SPI1_MISO, SPI3_MISO, USART2_RX]
// FB2_6 : ctrl_3 [PB0 : ..]

// FB2_13: data_0 [PA3 : USART2_RX] 
// FB4_1 : data_1 [PA1 : ..]
// FB4_2 : data_2 [PA0 : ..]
// FB4_7 : data_3 [PF1 : SPI2_SCK]
// FB4_11: data_4 [PF0 : I2C2_SDA, SPI2_NSS] 
// FB4_13: data_5 [PB7 : USART1_RX]
// FB4_14: data_6 [PB6 : USART1_TX]
// FB4_15: data_7 [PB5 : SPI1_MOSI, SPI3_MOSI, USART2_CK]

// FB2_7 : clk0  (GCK0) 50 Mhz
// FB2_8 : clk1  (GCK1) [PA2 : LSCO] 
// FB2_10: clk2  (GCK2) [PA8 : MCO]
// FB2_12: extra [PA15]
// FB3_15: input 

//
// PMOD OLEDrgb: https://digilent.com/reference/pmod/pmodoledrgb/reference-manual
// Note that v0.1 and v0.2 of PCB have pins in the wrong order.
//
// pmod0 = CS     
// pmod1 = PICO   
// pmod2 = nc     (no POCI signal).
// pmod3 = SCK    
//
// pmod4 = D/C    (data/command)
// pmod5 = RES    (reset)
// pmod6 = VCCEN  (power on display VCC)
// pmod7 = PMODEN (VDD logic voltage control)

module top(pmod_a0, pmod_a1, pmod_a2, pmod_a3, pmod_a4, pmod_a5, pmod_a6, pmod_a7,
           data_0, data_1, data_2, data_3, data_4, data_5, data_6, data_7);
   // NOTE: Must use LOC attributes rather than a .ucf file
   (* LOC = "FB2_13" *) input wire data_0;   
   (* LOC = "FB4_1"  *) input wire data_1;   
   (* LOC = "FB4_2"  *) input wire data_2;   
   (* LOC = "FB4_7"  *) input wire data_3;   
   (* LOC = "FB4_11" *) input wire data_4;   
   (* LOC = "FB4_13" *) input wire data_5;   
   (* LOC = "FB4_14" *) input wire data_6; 
   (* LOC = "FB4_15" *) input wire data_7;   

   (* LOC = "FB1_1"  *) output pmod_a0;   
   (* LOC = "FB1_2"  *) output pmod_a1;
   (* LOC = "FB1_3"  *) output pmod_a2;   
   (* LOC = "FB1_9"  *) output pmod_a3;      
   (* LOC = "FB1_10" *) output pmod_a4;   
   (* LOC = "FB1_11" *) output pmod_a5;   
   (* LOC = "FB1_12" *) output pmod_a6;   
   (* LOC = "FB1_13" *) output pmod_a7;   
   
   assign pmod_a0 = data_0;
   assign pmod_a1 = data_1;
   assign pmod_a2 = data_2;   
   assign pmod_a3 = data_3;   
   assign pmod_a4 = data_4;
   assign pmod_a5 = data_5;
   assign pmod_a6 = data_6;
   assign pmod_a7 = data_7;
   
endmodule // top
