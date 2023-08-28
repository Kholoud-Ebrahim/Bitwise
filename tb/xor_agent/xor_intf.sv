interface xor_intf #(parameter XWIDTH =8)(input clk, rst);
    logic [XWIDTH-1:0] xor_in1, xor_in2;
    logic [XWIDTH-1:0] xor_out;
endinterface :xor_intf