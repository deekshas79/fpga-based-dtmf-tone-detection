`timescale 1ns / 1ps

module goertzel_top(
          input        clk_p,
          input        clk_n,
          input        rst,
          input        start,
          input  [3:0] tone_sel,
          output [3:0] low_grp,
          output [3:0] high_grp
          );

// -- DataTypee declarations
wire    [31:0] dout;
wire    [15:0] addr;
wire           rst_n;
wire           clk;

// ----------------------------------------------
// -- Misceallaneous Logic
assign rst_n = ~rst;

IBUFDS u_ibufds (
       .O   (clk),
       .I   (clk_p),
       .IB  (clk_n)
        );

// -----------------------------------------------
// -- Instantiation of Goertzel engine top
goertzel_engine_top u_goertzel_engine_top(
   .clk                         (clk),
   .rst_n                       (rst_n),
   .signal                      (dout),
   .sampling_pulse              (sampling_pulse),            
   .low_grp_freq                (low_grp),
   .high_grp_freq               (high_grp)
   );

// -----------------------------------------------
// -- Instantiation of Fetch Control Logic
fetch_ctrl_logic u_fetch_ctrl_logic (
   .clk           (clk),
   .rst_n         (rst_n),
   .start         (start),
   .tone_sel      (tone_sel),
   .addr          (addr),
   .sampling_pulse(sampling_pulse)
    );
// -----------------------------------------------
// -- Instantiation of BRAM

blk_mem_gen_0 u_blk_mem (
  .clka          (clk),
  .rsta          (~rst_n),
  .ena           (1'b1),
  .wea           (1'b0),
  .addra         (addr),
  .dina          (32'b0),
  .douta         (dout),
  .rsta_busy     (rsta_busy)
);

endmodule
