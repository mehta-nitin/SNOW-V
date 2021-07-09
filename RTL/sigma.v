`timescale 1ns / 1ps

module sigma(
    input [127:0] in,
    input clk,
    output [127:0] out
    );
    
    integer i,j;
    reg [127:0] temp = 128'd0;
    
    function [15 : 0] make16(input [15:0] a, input [15:0] b);
    begin
        assign make16 = ((a << 8) | b);
    end
    endfunction
      
    function [31 : 0] make32(input [31:0] a, input [31:0] b);
    begin
        assign make32 = ((a << 16) | b);
    end
    endfunction
      
    function [4 : 0] sigma(input [4:0] z);
    begin
        case(z)
            4'd0: sigma = 4'd0;
            4'd1: sigma = 4'd4;
            4'd2: sigma = 4'd4;
            4'd3: sigma = 4'd12;
            4'd4: sigma = 4'd1;
            4'd5: sigma = 4'd5;
            4'd6: sigma = 4'd9;
            4'd7: sigma = 4'd13;
            4'd8: sigma = 4'd2;
            4'd9: sigma = 4'd6;
            4'd10: sigma = 4'd10;
            4'd11: sigma = 4'd14;
            4'd12: sigma = 4'd3;
            4'd13: sigma = 4'd7;
            4'd14: sigma = 4'd11;
            4'd15: sigma = 4'd15;        
        endcase
    end
    endfunction
    //b08d861d6ba87f00e04aaa5844c347c5
    always@(posedge clk)  
    begin
        for (i = 0, j = 0 ; i < 128 ; i = i + 8, j = j + 1)
        begin
            temp[i +: 8] <= in[(sigma(j) >> 2) +: 8];
        end          
    end
        
    assign out = temp;
    
endmodule
