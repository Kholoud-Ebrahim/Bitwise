# Bitwise
A simple module which performs bitwise operations such as and, or, xor etc.

| Signal   |    Description                     | Direction| Width     |
|----------|------------------------------------|----------|-----------|
| clk      | system clock                       | input    | 1         |
| rst      | active high asynchronous reset     | input    | 1         |
| in1_a    | The first input of And             | input    | AWIDTH    |
| in2_a    | The second input of And  			    | input    | AWIDTH    |
| in1_o    | The first input of Or   	      		| input    | OWIDTH    |
| in2_o    | The second input of Or 	      		| input    | OWIDTH    |
| in1_x    | The first input of Xor             | input    | XWIDTH    |
| in2_x    | The second input of Xor      			| input    | XWIDTH    |
| in_sr    | The input of shift right       		| input    | SRWIDTH   |
| op_sr    | The shift right value  		      	| input    | SROPWIDTH |
| in_sl    | The input of shift left            | input    | SLWIDTH   |
| op_sl    | The shift left value   	      		| input    | SLOPWIDTH |
| out_a    | The output of And                  | output   | AWIDTH	   |
| out_o    | The output of Or               		| output   | OWIDTH    |
| out_x    | The output of XOr                  | output   | XWIDTH    |
| out_sr   | The output of shift right          | output   | SRWIDTH   |
| out_sl   | The output of shift left           | output   | SLWIDTH   |

## UVM based Verification of Bitwise Operations Design.
- The UVM env includes:
  1. Configuration Object for each agent and also the env.
  2. Virtual Sequences and Virtual Sequencer.
- The simulation results contain:
  1. Functional coverage report
  2. Code coverage report.
  
## Bitwise Block Diagram
![image](https://github.com/UserImages/user_images/blob/main/bitwise.png)
  
## UVM Based Testbench Architecture of bitwise
![image](https://github.com/UserImages/user_images/blob/main/bitwise_uvm.png)
