/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_fsm_sar_bs (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  //assign uio_out = 0;
  //assign uio_oe  = 0;

    //fsm_sar_bs #(.Width(6)) C2 (.clk_i(ui_in[7]), .rst_i(ui_in[6]), .start_i(ui_in[5]), .cmp_i(ui_in[4]) , .result_o(uio_out[5:0]), .sample_o(uio_out[6]), .dac_o(uo_out[5:0]), .eoc_o(uo_out[6]));   
    fsm_sar_bs T2 (.thermometer_input[6:0](uio_in[6:0]) ,.binary_output(uo_out[2:0]));       
    assign uio_eo[7:0] = 8'b00000000;
    //assign uio_out[7]= 1'b0;
    assign uo_out[7:4] = 4'b0000;
endmodule
