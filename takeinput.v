`timescale 1ns / 1ps

module takeinput(x,s,en,clk,rst_n);

    input en,clk,rst_n;
    input [31:0]x;
    output reg [31:0] s;
    
    always @ (posedge clk or negedge rst_n)
    begin
        if (~rst_n)
        begin
            s <= 32'b0;
        end
        else if(en)
        begin
            s <= x;
        end
    end
    
endmodule
