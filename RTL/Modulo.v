`timescale 1ns / 1ps


module Modulo_Addition #(parameter two_32=40'd2147483648)(
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] sum
);
    integer a1,b1,sum1;
    
    always@(*)
    begin
        a1 <= a;
        b1 <= b;
        sum1 <= a1 + b1;
        if (sum1 < two_32)
            sum <= sum1;
        else if (sum1 == two_32)
            sum <= 32'd0;
        else
            sum <= sum1 % two_32;      
    end
endmodule