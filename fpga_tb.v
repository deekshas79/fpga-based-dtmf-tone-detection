`timescale 1ns / 1ps

module fpga_tb;
reg        clk_p;
reg        clk_n;
reg        rst;
reg        start;
reg        [3:0] tone_sel;
wire [3:0] low_grp;
wire [3:0] high_grp;
parameter CLK_PRD = 20;

goertzel_top g1(
 clk_p,
 clk_n,
 rst,
 start,
 tone_sel,
 low_grp,
 high_grp
          );

//initial block to define init values
initial begin
     clk_n = 1'b0;
     clk_p = 1'b1;
     rst = 1'b0;
     start = 1'b0;
   end
   
   initial begin
     
      tone_sel = 4'b0000;
     #(CLK_PRD * 4) rst= 1'b1;
     #(CLK_PRD * 2) rst=1'b0;
     #(CLK_PRD * 2) start = 1'b1;
     #(CLK_PRD * 2) start=1'b0;
     #(CLK_PRD * 5);
     
       tone_sel = 4'b0001;
     #(CLK_PRD * 4) rst= 1'b1;
     #(CLK_PRD * 2) rst=1'b0;
     #(CLK_PRD * 2) start = 1'b1;
     #(CLK_PRD * 2) start=1'b0;
     #(CLK_PRD * 5);
     
       tone_sel = 4'b0010;
     #(CLK_PRD * 4) rst= 1'b1;
     #(CLK_PRD * 2) rst=1'b0;
     #(CLK_PRD * 2) start = 1'b1;
     #(CLK_PRD * 2) start=1'b0;
     #(CLK_PRD * 5);
   
   end
   
   initial begin
     #(CLK_PRD * 15 * 100) $finish;
   end
   
   // clock generation  
   always #(CLK_PRD/2) clk_n = ~clk_n;
   always #(CLK_PRD/2) clk_p = ~clk_p;

endmodule
