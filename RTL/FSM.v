`timescale 1ns / 1ps

module FSM (
      input [127:0] T1,
      input [127:0] T2,
      input clk,
      output [127:0] keystream
    );
      reg [127:0] R1 = 128'd0;
      reg [127:0] R2 = 128'd0;
      reg [127:0] R3 = 128'd0;
      wire [127:0] x0;
      wire [127:0] x1;
      wire [127:0] x2;
      wire [127:0] x3;
      wire [127:0] x4;
      wire [127:0] temp;
      
      always@(posedge clk) 
      begin
        R1 <= x4;
        R2 <= x2; 
        R3 <= x3;        
      end
      
      assign temp = (R3 ^ T2);
      
      Modulo_Addition mt1(.a(temp[127:96]), .b(R2[127:96]), .sum(x1[127:96]));
      Modulo_Addition mt2(.a(temp[95:64]), .b(R2[95:64]), .sum(x1[95:64]));
      Modulo_Addition mt3(.a(temp[63:32]), .b(R2[63:32]), .sum(x1[63:32]));
      Modulo_Addition mt4(.a(temp[31:0]), .b(R2[31:0]), .sum(x1[31:0]));
      
      sigma s1(.in(x1), .out(x4));
      
      AES_round_func a1(.in(R1), .round_key(128'd0), .out(x2));
      
      AES_round_func a2(.in(R2), .round_key(128'd0), .out(x3));
      
      Modulo_Addition tm1(.a(T1[127:96]), .b(R1[127:96]), .sum(x0[127:96]));
      Modulo_Addition tm2(.a(T1[95:64]), .b(R1[95:64]), .sum(x0[95:64]));
      Modulo_Addition tm3(.a(T1[63:32]), .b(R1[63:32]), .sum(x0[63:32]));
      Modulo_Addition tm4(.a(T1[31:0]), .b(R1[31:0]), .sum(x0[31:0]));
      
      assign keystream = (x0 ^ R2);
      
endmodule