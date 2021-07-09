`timescale 1ns / 1ps

module testbench;
    reg [255:0] s_key;
    reg [127:0] IV;
    reg clk;
    wire [127:0] keystream;
    
    SNOW_V tb(.s_key(s_key), .IV(IV), .clk(clk), .keystream(keystream));
    
    initial
    begin
        s_key = 256'h0f33b29436c2bd4f92e798f2ed0824f19b15acd9aacf80d8f3f46eea61237fc9;
        IV = 128'h122052e9c61e2e7e45208419998a007c;
        clk=0;
        forever #50 clk = ~clk;
    end

endmodule
