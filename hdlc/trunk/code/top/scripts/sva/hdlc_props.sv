module hdlc_props(txclk,rxclk,tx,rx,txen,rxen, txdone,dat_o,ack_o,clk_i,counter);
input logic clk_i;
input logic txclk;
input logic rxclk;
input logic tx;
input logic rx;
input logic txen;
input logic rxen;
input logic txdone;
input logic ack_o;
input logic [31:0]dat_o;
input logic [7:0]counter;

// sequence definition

// property definition
//property TxDone_check;
	//@(posedge txclk) txdone implies //4.5 avsnitt checks
//endproperty


//property check1;
  //@(posedge clk) reset implies state_s == IDLE;
//endproperty

property byte1_check;
@(posedge clk_i) $rose(ack_o) |-> ##1 dat_o[7:0] == counter;
endproperty

property byte2_check;
@(posedge clk_i) $rose(ack_o) |-> ##2 dat_o[15:8] == counter;
endproperty
//constrained randomization and coverage points
property byte3_check;
@(posedge clk_i) $rose(ack_o) |-> ##3 dat_o[23:16] == counter;
endproperty


property byte4_check;
@(posedge clk_i) $rose(ack_o) |-> ##4 dat_o[31:24] == counter;
endproperty

// assert, assume statement
assert_byte1: assert property (byte1_check)
	$display($time,,,"\tByte 1 PASS:: DAT_O=%b  counter=%b  \n", dat_o[7:0],counter[7:0]);
else $display($time,,,"\tByte 1 FAIL:: DAT_O=%b  counter=%b \n", dat_o[7:0],counter[7:0]);

assert_byte2: assert property (byte2_check)
	$display($time,,,"\tByte 2 PASS:: DAT_O=%b  counter=%b  \n", dat_o[15:8],$past(counter[7:0]));
else $display($time,,,"\tByte 2 FAIL:: DAT_O=%b  counter=%b \n", dat_o[15:8],$past(counter[7:0]));

assert_byte3: assert property (byte3_check)
	$display($time,,,"\tByte 3 PASS:: DAT_O=%b	counter=%b	\n", dat_o[23:16],$past(counter[7:0],2));
 else $display($time,,,"\tByte 3 FAIL:: DAT_O=%b  counter=%b \n", dat_o[23:16],$past(counter[7:0],2));
assert_byte4: assert property (byte4_check)
	$display($time,,,"\tByte 4 PASS:: DAT_O=%b	counter=%b	\n", dat_o[31:24],$past(counter[7:0],3));
else $display($time,,,"\tByte 4 FAIL:: DAT_O=%b	counter = %b \n",dat_o[31:24],$past(counter[7:0],3));



//cover statement
// Reuse below with a sequence with formal parameters
cover property (@(posedge txclk) !tx ##1 tx [*6] ##1 !tx)
	$display($stime,,,"\tTX flag, frame start\n"); // Looking for 01111110
cover property (@(posedge rxclk) !rx ##1 rx [*6] ##1 !rx)
	$display($stime,,,"\tRX flag, frame start\n"); // Looking for 01111110




endmodule