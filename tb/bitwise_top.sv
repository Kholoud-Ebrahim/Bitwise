`timescale 1ns/100ps  

import uvm_pkg::*;
`include "uvm_macros.svh"

import param_pkg::*;
import bitwise_pkg::*;

module bitwise_top;
    bit clk, rst;

    and_intf   #(AWIDTH) and_if (.clk(clk), .rst(rst));
    or_intf    #(OWIDTH) or_if  (.clk(clk), .rst(rst));
    xor_intf   #(XWIDTH) xor_if (.clk(clk), .rst(rst));
    shift_intf #(SRWIDTH, SROPWIDTH, SLWIDTH, SLOPWIDTH) shift_if (.clk(clk), .rst(rst));

    bitwise #(AWIDTH, OWIDTH, XWIDTH, SRWIDTH, SROPWIDTH, SLWIDTH, SLOPWIDTH) rtl(
        .clk(clk), 
        .rst(rst),
        .in1_a(and_if.and_in1), 
        .in2_a(and_if.and_in2), 
        .in1_o(or_if.or_in1), 
        .in2_o(or_if.or_in2), 
        .in1_x(xor_if.xor_in1), 
        .in2_x(xor_if.xor_in2), 
        .in_sr(shift_if.shift_right_in), 
        .op_sr(shift_if.shift_right_op), 
        .in_sl(shift_if.shift_left_in), 
        .op_sl(shift_if.shift_left_op),
        .out_a(and_if.and_out),
        .out_o(or_if.or_out), 
        .out_x(xor_if.xor_out), 
        .out_sr(shift_if.shift_right_out), 
        .out_sl(shift_if.shift_left_out)
    );
    initial begin
        uvm_config_db #(virtual and_intf #(AWIDTH))::set(null, "*", "and_vif",and_if);
        uvm_config_db #(virtual or_intf  #(OWIDTH))::set(null, "*", "or_vif", or_if);
        uvm_config_db #(virtual xor_intf #(XWIDTH))::set(null, "*", "xor_vif", xor_if);
        uvm_config_db #(virtual shift_intf #(SRWIDTH, SROPWIDTH, SLWIDTH, SLOPWIDTH))::set(null, "*", "shift_vif", shift_if);
        
        run_test();
    end

    initial begin
        rst = 1; 
        #(PERIOD*2);
        rst = 0;
    end

    initial begin
        $timeformat (-9, 0," ns", 16);
        forever begin
            #(PERIOD/2.0);  clk = ~clk;
        end
    end

    /*
    initial begin
        $dumpfile("bitwise.vcd");
        $dumpvars;
    end
    */
endmodule :bitwise_top