`timescale 1ns / 1ps

module fetch_ctrl_logic(
   input clk,
   input rst_n,
   input start,
   input [3:0] tone_sel,
   output reg [15:0] addr,
   output reg sampling_pulse
    );
    
 // -- Parameter declaration
 parameter IDLE  = 2'b00;
 parameter FETCH = 2'b01;
 parameter WAIT  = 2'b10;
 
 //-----Datatype declaration------
 reg [15:0] addr_int;
 reg [15:0] sampling_pulse_int;
 reg [1:0]  cs;
 reg [1:0]  ns;
 reg [15:0] base_addr;
 wire       done;
 wire       next; 
 
 // Address Boundary Logic
 always @ (posedge clk or negedge rst_n) begin
   if (~rst_n) begin
     base_addr <= 'b0; 
   end else begin 
     case (tone_sel)
       4'h0 : begin base_addr <= 16'h0000; end 
       4'h1 : begin base_addr <= 16'h0800; end 
       4'h2 : begin base_addr <= 16'h1000; end 
       4'h3 : begin base_addr <= 16'h1800; end
       4'h4 : begin base_addr <= 16'h2000; end 
       4'h5 : begin base_addr <= 16'h2800; end 
       4'h6 : begin base_addr <= 16'h3000; end 
       4'h7 : begin base_addr <= 16'h3800; end
       4'h8 : begin base_addr <= 16'h4000; end 
       4'h9 : begin base_addr <= 16'h4800; end 
       4'hA : begin base_addr <= 16'h5000; end 
       4'hB : begin base_addr <= 16'h5800; end
       4'hC : begin base_addr <= 16'h6000; end 
       4'hD : begin base_addr <= 16'h6800; end 
       4'hE : begin base_addr <= 16'h7000; end 
       4'hF : begin base_addr <= 16'h7800; end  
     endcase 
   end 
 end 
 
 // -- Done Logic 
 assign done = (addr == (base_addr + 16'h0400)) ? 1'b1 : 1'b0;
 
 // -- Next pulse decoding logic
 reg  [2:0] cnt;
 always @ (posedge clk  or negedge rst_n) begin
   if (~rst_n) begin
     cnt [2:0] <= 3'b0; 
   end else if (next) begin 
     cnt [2:0] <= 3'b0; 
   end else begin 
     cnt [2:0] <= cnt [2:0] + 1'b1; 
   end  
 end 
 
 assign next = (cnt == 3'b110) ? 1'b1 : 1'b0;
 
 //-----Memory part of FSM-----
 always @(posedge clk or negedge rst_n) begin
   if (~rst_n) begin 
     addr           <= 0;
     sampling_pulse <= 0;
     cs             <= IDLE;
   end else begin
     addr           <= addr_int;
     sampling_pulse <= sampling_pulse_int;
     cs             <= ns;
   end
 end

// -- FSM Decoding Logic 
 always @ (*) begin
   if (~rst_n) begin
     addr_int           <= 0;
     sampling_pulse_int <= 0; 
     ns                 <= IDLE;
   end else begin 
     case (cs)
       IDLE : begin
                if (start) begin
                  ns                 <= FETCH;
                  addr_int           <= base_addr;
                  sampling_pulse_int <= 1'b0;
                end else begin
                  ns                 <= IDLE;
                  addr_int           <= 16'b0;
                  sampling_pulse_int <= 1'b0;
                end  
              end 
       FETCH : begin
                if (done) begin
                  ns                 <= IDLE;
                  addr_int           <= 16'b0;
                  sampling_pulse_int <= 1'b0;                  
                end else begin
                  ns                 <= WAIT;
                  addr_int           <= addr;
                  sampling_pulse_int <= 1'b0;
                end  
              end 
        WAIT : begin
                if (next) begin
                  ns                 <= FETCH;
                  addr_int           <= addr + 1'b1;
                  sampling_pulse_int <= 1'b1;
                end else begin
                  ns                 <= WAIT;
                  addr_int           <= addr;
                  sampling_pulse_int <= 1'b0;
                end  
              end  
         default : begin
                    addr_int           <= 0;
                    sampling_pulse_int <= 0; 
                    ns                 <= IDLE;
                  end
     endcase 
   end 
 end 
 
endmodule
