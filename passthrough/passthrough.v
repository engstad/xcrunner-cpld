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

// FB2_1 : ctrl0 [PF1]
// FB2_2 : ctrl1 [PF0]
// FB2_3 : ctrl2 [PB8 (BOOT0)] (only when in CTRL mode, otherwise floating)
// FB2_4 : ctrl3 [PB1]         (only when in CTRL mode, otherwise floating)
// FB2_5 : clk0  (GCK0)
// FB2_6 : clk1  (GCK1)
// FB2_7 : clk2  (GCK2)
// FB2_8 : nc
// FB2_9 : data0 [PA0] (         USART2_CTS)
// FB2_10: data1 [PA1] (         USART2_RTS)
// FB2_11: data2 [PA2] (         USART2_TX)
// FB2_12: data3 [PA3] (         USART2_RX)
// FB2_13: data4 [PA4] (SPI_NSS, USART2_CK)
// FB2_14: data5 [PA5] (SPI_SCK)
// FB2_15: data6 [PA6] (SPI_POCI)
// FB2_16: data7 [PA7] (SPI_PICO)

// FB3_1 : input

// PMOD OLEDrgb: https://digilent.com/reference/pmod/pmodoledrgb/reference-manual
//
// pmod0 = CS     [PA4]
// pmod1 = PICO   [PA7]
// pmod2 = nc     [PA6] (no POCI signal).
// pmod3 = SCK    [PA5]
//
// pmod4 = D/C    (data/command)
// pmod5 = RES    (reset)
// pmod6 = VCCEN  (power on display VCC)
// pmod7 = PMODEN (VDD logic voltage control)

module top(pmod_cs, pmod_pico, pmod_poci, pmod_sck, pmod_dc, pmod_res, pmod_vccen, pmod_pmoden,
           spi_cs, spi_pico, spi_poci, spi_sck, in_dc, in_reset, in_vccen, in_pmoden);
   // NOTE: Must use LOC attributes rather than a .ucf file
   (* LOC = "FB2_9" *)  input wire in_dc;   
   (* LOC = "FB2_10" *) input wire in_reset;   
   (* LOC = "FB2_11" *) input wire in_vccen;   
   (* LOC = "FB2_12" *) input wire in_pmoden;   
   (* LOC = "FB2_13" *) input wire spi_cs;   
   (* LOC = "FB2_14" *) input wire spi_sck;   
   (* LOC = "FB2_15" *) input wire spi_poci; 
   (* LOC = "FB2_16" *) input wire spi_pico;   

   (* LOC = "FB1_1" *) output pmod_cs;   
   (* LOC = "FB1_2" *) output pmod_pico;
   (* LOC = "FB1_3" *) output pmod_poci;   
   (* LOC = "FB1_4" *) output pmod_sck;   
   
   (* LOC = "FB1_5" *) output pmod_dc;   
   (* LOC = "FB1_6" *) output pmod_res;   
   (* LOC = "FB1_7" *) output pmod_vccen;   
   (* LOC = "FB1_8" *) output pmod_pmoden;   
   // (* LOC = "FB1_9" *) output led4;   
   // (* LOC = "FB1_10" *) output led5;   
   // (* LOC = "FB1_11" *) output led6;   
   // (* LOC = "FB1_12" *) output led7;

   assign pmod_cs = spi_cs;
   assign pmod_pico = spi_pico;
   assign pmod_poci = spi_poci;   
   assign pmod_sck = spi_sck;
   
   assign pmod_dc = in_dc;
   assign pmod_res = in_reset;
   assign pmod_vccen = in_vccen;
   assign pmod_pmoden = in_pmoden;
   
endmodule // top
