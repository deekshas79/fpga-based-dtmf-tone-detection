`timescale 1ns / 1ps

module comparator(
    input [31:0] a,
    input [31:0] b,
    input [31:0] c,
    input [31:0] d,
    output reg [3:0] pattern
    );
    
    reg [31:0] temp1, temp2;
    
    always @ (*)
    begin
    
    if (a>b)
      temp1 = a;
    else
      temp1 = b;
        
    if (c>d)
      temp2 = c;
    else
      temp2 = d;
    
    if (temp1 == a && temp2 == c)
    begin
      if (temp1 > temp2)
        pattern = 4'b1000;
      else
        pattern = 4'b0010;
    end
    
    else if (temp1 == a && temp2 == d)
    begin
      if (temp1 > temp2)
        pattern = 4'b1000;
      else
        pattern = 4'b0001;
    end

    else if (temp1 == b && temp2 == c)
    begin
      if (temp1 > temp2)
        pattern = 4'b0100;
      else
        pattern = 4'b0010;
    end

    else if (temp1 == b && temp2 == d)
    begin
      if (temp1 > temp2)
        pattern = 4'b0100;
      else
        pattern = 4'b0001;
    end

    else begin
      pattern = 4'b0000;
    end
    
    end
    
endmodule
