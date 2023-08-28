interface or_intf #(parameter OWIDTH =8)(input clk, rst);
    logic [OWIDTH-1:0] or_in1, or_in2;
    logic [OWIDTH-1:0] or_out;
endinterface :or_intf