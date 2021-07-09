`timescale 1ns / 1ps

module LFSR(
    input [255:0] s_key,
    input [127:0] IV,
    input clk,
    output wire [127:0] keystream
    );

    reg [15:0] a0;
    reg [15:0] a1;
    reg [15:0] a2;
    reg [15:0] a3;
    reg [15:0] a4;
    reg [15:0] a5;
    reg [15:0] a6;
    reg [15:0] a7;
    reg [15:0] a8;
    reg [15:0] a9;
    reg [15:0] a10;
    reg [15:0] a11;
    reg [15:0] a12;
    reg [15:0] a13;
    reg [15:0] a14;
    reg [15:0] a15;
    
    reg [15:0] b0;
    reg [15:0] b1;
    reg [15:0] b2;
    reg [15:0] b3;
    reg [15:0] b4;
    reg [15:0] b5;
    reg [15:0] b6;
    reg [15:0] b7;
    reg [15:0] b8;
    reg [15:0] b9;
    reg [15:0] b10;
    reg [15:0] b11;
    reg [15:0] b12;
    reg [15:0] b13;
    reg [15:0] b14;
    reg [15:0] b15;
    
    wire [127:0] T1;
    wire [127:0] T2;
    
    function [15 : 0] MUL_x(input [15 : 0] V, input [15 : 0] c);
    begin
        if(V & 16'h8000)
            MUL_x = (V << 1) ^ c;
        else
            MUL_x = (V << 1);        
    end
    endfunction
    
    function [15 : 0] MUL_x_inv(input [15 : 0] V, input [15 : 0] d);
    begin
        if(V & 16'h0001)
            MUL_x_inv = (V >> 1) ^ d;
        else
            MUL_x_inv = (V >> 1);        
    end
    endfunction
    
    always@(posedge clk) 
	begin
	    b15 = s_key[255:240];
	    b14 = s_key[239:224];  
	    b13 = s_key[223:208];
	    b12 = s_key[207:192];
	    b11 = s_key[191:176];
	    b10 = s_key[175:160];
	    b9 = s_key[159:144];
	    b8 = s_key[143:128];
	    b7 = 16'd0;
	    b6 = 16'd0;
	    b5 = 16'd0;
	    b4 = 16'd0;
	    b3 = 16'd0;
	    b2 = 16'd0;
	    b1 = 16'd0;
	    b0 = 16'd0;
	    #640;
	    b15 <= (a0 ^ (MUL_x_inv(b8,16'hE4B1) ^ (MUL_x(b0,16'hC963) ^ b3)));
	    b14 <= b15;  
	    b13 <= b14;
	    b12 <= b13;
	    b11 <= b12;
	    b10 <= b11;
	    b9 <= b10;
	    b8 <= b9;
	    b7 <= b8;
	    b6 <= b7;
	    b5 <= b6;
	    b4 <= b5;
	    b3 <= b4;
	    b2 <= b3;
	    b1 <= b2;
	    b0 <= b1;       
	end
    
    always@(posedge clk) 
	begin
	    a15 = s_key[127:112];
	    a14 = s_key[111:96];  
	    a13 = s_key[95:80];
	    a12 = s_key[79:64];
	    a11 = s_key[63:48];
	    a10 = s_key[47:32];
	    a9 = s_key[31:16];
	    a8 = s_key[15:0];
	    a7 = IV[127:112];
	    a6 = IV[111:96];
	    a5 = IV[95:80];
	    a4 = IV[79:64];
	    a3 = IV[63:48];
	    a2 = IV[47:32];
	    a1 = IV[31:16];
	    a0 = IV[15:0];
	    #640;
	    a15 <= (b0 ^ (MUL_x_inv(a8,16'hCC87) ^ (MUL_x(a0,16'h990F) ^ a1)));
	    a14 <= a15;  
	    a13 <= a14;
	    a12 <= a13;
	    a11 <= a12;
	    a10 <= a11;
	    a9 <= a10;
	    a8 <= a9;
	    a7 <= a8;
	    a6 <= a7;
	    a5 <= a6;
	    a4 <= a5;
	    a3 <= a4;
	    a2 <= a3;
	    a1 <= a2;
	    a0 <= a1;       
	end
    
    assign T1[127:112] = b8;
    assign T1[111:96] = b9;
    assign T1[95:80] = b10;
    assign T1[79:64] = b11;
    assign T1[63:48] = b12;
    assign T1[47:32] = b13;
    assign T1[31:16] = b14;
    assign T1[15:0] = b15;
    
    assign T2[127:112] = a7;
    assign T2[111:96] = a6;
    assign T2[95:80] = a5;
    assign T2[79:64] = a4;
    assign T2[63:48] = a3;
    assign T2[47:32] = a2;
    assign T2[31:16] = a1;
    assign T2[15:0] = a0;
    
    FSM f1(.T1(T1), .T2(T2), .clk(clk), .keystream(keystream));
    
endmodule
