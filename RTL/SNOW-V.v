`timescale 1ns / 1ps

module SNOW_V(
    input [255:0] s_key,
    input [127:0] IV,
    input clk,
    output [127:0] keystream
    );
    LFSR l1(.s_key(s_key), .IV(IV), .clk(clk), .keystream(keystream));
endmodule
