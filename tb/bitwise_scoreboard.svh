`uvm_analysis_imp_decl(_and)
`uvm_analysis_imp_decl(_or)
`uvm_analysis_imp_decl(_shift)
`uvm_analysis_imp_decl(_xor)

class bitwise_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(bitwise_scoreboard)

    and_seq_item     and_queue[$];
    or_seq_item      or_queue[$];
    shift_seq_item   shift_queue[$];
    xor_seq_item     xor_queue[$];


    uvm_analysis_imp_and   #(and_seq_item  , bitwise_scoreboard) and_scb_imp;
    uvm_analysis_imp_or    #(or_seq_item   , bitwise_scoreboard) or_scb_imp;
    uvm_analysis_imp_shift #(shift_seq_item, bitwise_scoreboard) shift_scb_imp;
    uvm_analysis_imp_xor   #(xor_seq_item  , bitwise_scoreboard) xor_scb_imp;

    function new(string name = "bitwise_scoreboard", uvm_component parent);
        super.new(name, parent);
        and_scb_imp   = new("and_scb_imp", this);
        or_scb_imp    = new("or_scb_imp", this);
        shift_scb_imp = new("shift_scb_imp", this);
        xor_scb_imp   = new("xor_scb_imp", this);
    endfunction :new

    function void write_and(and_seq_item and_item_f);
        and_queue.push_front(and_item_f);
    endfunction :write_and

    function void write_or(or_seq_item or_item_f);
        or_queue.push_front(or_item_f);
    endfunction :write_or

    function void write_shift(shift_seq_item shift_item_f);
        shift_queue.push_front(shift_item_f);
    endfunction :write_shift

    function void write_xor(xor_seq_item xor_item_f);
        xor_queue.push_front(xor_item_f);
    endfunction :write_xor

    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
            fork
                begin
                    and_seq_item     and_item;
                    wait(and_queue.size() != 0);
                    and_item = and_queue.pop_back();
                    and_compare(and_item);
                end
                begin
                    or_seq_item     or_item;
                    wait(or_queue.size() != 0);
                    or_item = or_queue.pop_back();
                    or_compare(or_item);
                end
                begin
                    shift_seq_item     shift_item;
                    wait(shift_queue.size() != 0);
                    shift_item = shift_queue.pop_back();
                    shift_compare(shift_item);
                end
                begin
                    xor_seq_item     xor_item;
                    wait(xor_queue.size() != 0);
                    xor_item = xor_queue.pop_back();
                    xor_compare(xor_item);
                end
            join
        end
    endtask :run_phase

    task and_compare(and_seq_item  and_item);
        logic [AWIDTH-1:0] expected_and_out, actual_and_out;
        expected_and_out = and_item.and_in1 & and_item.and_in2;
        actual_and_out   = and_item.and_out;

        ass1: assert(expected_and_out == actual_and_out)
            `uvm_info("COMPARE_AND_PASSED", $sformatf("@%5t: in1=%0b   in2=%0b   Actual=%0b   Exp=%0b",
                        $time, and_item.and_in1, and_item.and_in2, actual_and_out, expected_and_out), UVM_LOW)
        else
            `uvm_error("COMPARE_AND_FAILED", $sformatf("@%5t: in1=%0b   in2=%0b   Actual=%0b   Exp=%0b",
                        $time, and_item.and_in1, and_item.and_in2, actual_and_out, expected_and_out))
    endtask :and_compare

    task or_compare(or_seq_item  or_item);
        logic [OWIDTH-1:0] expected_or_out, actual_or_out;
        expected_or_out  = or_item.or_in1 | or_item.or_in2;
        actual_or_out    = or_item.or_out;

        ass2: assert(expected_or_out == actual_or_out)
            `uvm_info("COMPARE_OR_PASSED", $sformatf("@%5t: in1=%0b   in2=%0b   Actual=%0b   Exp=%0b",
                        $time, or_item.or_in1, or_item.or_in2, actual_or_out, expected_or_out), UVM_LOW)
        else
            `uvm_error("COMPARE_OR_FAILED", $sformatf("@%5t: in1=%0b   in2=%0b   Actual=%0b   Exp=%0b",
                        $time, or_item.or_in1, or_item.or_in2, actual_or_out, expected_or_out))
    endtask :or_compare

    task shift_compare(shift_seq_item  shift_item);
        logic [SRWIDTH-1:0] expected_shift_right_out, actual_shift_right_out;
        logic [SLWIDTH-1:0] expected_shift_left_out , actual_shift_left_out;

        expected_shift_right_out = shift_item.shift_right_in >> shift_item.shift_right_op;
        actual_shift_right_out   = shift_item.shift_right_out;

        expected_shift_left_out = shift_item.shift_left_in << shift_item.shift_left_op;
        actual_shift_left_out   = shift_item.shift_left_out;

        ass3: assert(expected_shift_right_out == actual_shift_right_out)
            `uvm_info("COMPARE_SHIFT_RIGHT_PASSED", $sformatf("@%5t: in=%0b   op=%0b   Actual=%0b   Exp=%0b",
                        $time, shift_item.shift_right_in, shift_item.shift_right_op, actual_shift_right_out, expected_shift_right_out), UVM_LOW)
        else
            `uvm_error("COMPARE_SHIFT_RIGHT_FAILED", $sformatf("@%5t: in=%0b   op=%0b   Actual=%0b   Exp=%0b",
                        $time, shift_item.shift_right_in, shift_item.shift_right_op, actual_shift_right_out, expected_shift_right_out))


        ass4: assert(expected_shift_left_out == actual_shift_left_out)
            `uvm_info("COMPARE_SHIFT_LEFT_PASSED", $sformatf("@%5t: in=%0b   op=%0b   Actual=%0b   Exp=%0b",
                        $time, shift_item.shift_left_in, shift_item.shift_left_op, actual_shift_left_out, expected_shift_left_out), UVM_LOW)
        else
            `uvm_error("COMPARE_SHIFT_LEFT_FAILED", $sformatf("@%5t: in=%0b   op=%0b   Actual=%0b   Exp=%0b",
                        $time, shift_item.shift_left_in, shift_item.shift_left_op, actual_shift_left_out, expected_shift_left_out))
            
        
          endtask :shift_compare

    task xor_compare(xor_seq_item  xor_item);
        logic [XWIDTH-1:0] expected_xor_out, actual_xor_out;
        expected_xor_out  = xor_item.xor_in1 ^ xor_item.xor_in2;
        actual_xor_out    = xor_item.xor_out;

        ass5: assert(expected_xor_out == actual_xor_out)
            `uvm_info("COMPARE_XOR_PASSED", $sformatf("@%5t: in1=%0b   in2=%0b   Actual=%0b   Exp=%0b",
                        $time, xor_item.xor_in1, xor_item.xor_in2, actual_xor_out, expected_xor_out), UVM_LOW)
        else
            `uvm_error("COMPARE_XOR_FAILED", $sformatf("@%5t: in1=%0b   in2=%0b   Actual=%0b   Exp=%0b",
                        $time, xor_item.xor_in1, xor_item.xor_in2, actual_xor_out, expected_xor_out))
    endtask :xor_compare
    
endclass :bitwise_scoreboard