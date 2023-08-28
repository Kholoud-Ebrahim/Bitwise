module bitwise #(parameter AWIDTH =8, OWIDTH =8, XWIDTH =8, SRWIDTH =8, SROPWIDTH =8, SLWIDTH =8, SLOPWIDTH =8) 
    (clk, rst, in1_a, in2_a, in1_o, in2_o, in1_x, in2_x, in_sr, op_sr, in_sl, op_sl,
     out_a, out_o, out_x, out_sr, out_sl);
    
    input clk, rst;
    input [AWIDTH-1:0]    in1_a, in2_a;
    input [OWIDTH-1:0]    in1_o, in2_o;
    input [XWIDTH-1:0]    in1_x, in2_x;
    input [SRWIDTH-1:0]   in_sr;
    input [SROPWIDTH-1:0] op_sr;
    input [SLWIDTH-1:0]   in_sl;
    input [SLOPWIDTH-1:0] op_sl;

    output reg [AWIDTH-1:0]  out_a;
    output reg [OWIDTH-1:0]  out_o;
    output reg [XWIDTH-1:0]  out_x;
    output reg [SRWIDTH-1:0] out_sr;
    output reg [SLWIDTH-1:0] out_sl;

    always @(posedge clk, negedge rst) begin
        if(rst) begin
            out_a  <= {AWIDTH{1'b0}};
            out_o  <= {OWIDTH{1'b0}};
            out_x  <= {XWIDTH{1'b0}};
            out_sr <= {SRWIDTH{1'b0}};
            out_sl <= {SLWIDTH{1'b0}};
        end
        else begin
            out_a  <= in1_a & in2_a;
            out_o  <= in1_o | in2_o;
            out_x  <= in1_x ^ in2_x;
            out_sr <= in_sr >> op_sr;
            out_sl <= in_sl << op_sl;
        end
    end
endmodule