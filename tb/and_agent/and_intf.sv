interface and_intf #(parameter AWIDTH =8)(input clk, rst);
    logic [AWIDTH-1:0] and_in1, and_in2;
    logic [AWIDTH-1:0] and_out;
endinterface :and_intf