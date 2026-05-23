`timescale 1ns / 1ps

module magnitude #(
   parameter M=0
)(
   input [31:0]Sprev1,
   input [31:0]Sprev2,
   input clk,
   input rst_n,
   input activation_pulse,
   output reg [31:0]mag
    );
   
   always @ (posedge clk or negedge rst_n)
   begin
     if (~rst_n)
     begin
       mag <= 32'b0;
     end
     else if(activation_pulse)
     begin
       mag <= Sprev1^2 + Sprev2^2 - (M * Sprev1 * Sprev2);
     end  
   end
endmodule
