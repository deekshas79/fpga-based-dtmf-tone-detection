`timescale 1ns / 1ps

module goertzel_engine #(
   parameter M=1 // M = 2* cos(omega)
)(
   input    clk,  		// clock
   input    rst_n, 		//active low reset
   input    [31:0]xn, 		// sampled tone 
   input    [31:0]Sprev1, 	// first previous value of GE
   input    [31:0]Sprev2, 	// second previous value of GE
   output   reg [31:0]sn 	// output of Goertzel engine
    );
   
    always @ (posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            sn <= 32'b0;
        end 
        else begin
            sn <= xn + ((M*Sprev1)/2^16) - Sprev2;
        end 	//end of reset else block
    end 	//end of always block

endmodule
