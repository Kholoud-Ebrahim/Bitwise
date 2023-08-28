interface shift_intf #(parameter SRWIDTH =8, SROPWIDTH =8, SLWIDTH =8, SLOPWIDTH =8)(input clk, rst);
    logic [SRWIDTH-1:0] shift_right_in;
    logic [SLWIDTH-1:0] shift_left_in;

    logic [SROPWIDTH-1:0] shift_right_op;
    logic [SLOPWIDTH-1:0] shift_left_op;

    logic [SRWIDTH-1:0] shift_right_out;
    logic [SLWIDTH-1:0] shift_left_out;
endinterface :shift_intf