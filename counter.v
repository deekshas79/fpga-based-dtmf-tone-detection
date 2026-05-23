`timescale 1ns / 1ps

module counter #(
   parameter THRESHOLD = 11'd1025 // cutoff sample
)(
  input clk,  			//clock
  input rst_n, 			// active low reset
  input sampling_pulse, 	// pulse used to receive signal data periodically
  output reg [10:0] cnt, 	// to count the no. of samples received
  output tres_pulse 		// Output of counter when threshold is reached
  );
 
  
  always @ (posedge clk or negedge rst_n) begin 
    if (~rst_n) begin
      cnt [10:0] <= 11'b0;
    end else if (tres_pulse) begin
      cnt [10:0] <= 11'b0;
    end else if (sampling_pulse) begin
      cnt [10:0] <= cnt [10:0] + 1'b1;
    end
  end
  
  assign tres_pulse = (cnt [10:0] == THRESHOLD) ? 1'b1 : 1'b0;
endmodule
