module hdlc_props(txclk,rxclk,tx,rx,txen,rxen, txdone, dat_o, ack_o, clk_i, counter, abortframe, validframe, frame);

input logic clk_i;
input logic txclk;
input logic rxclk;
input logic tx;
input logic rx;
input logic txen;
input logic rxen;
input logic txdone;
input logic [7:0]counter;
input logic ack_o;
input logic [31:0]dat_o;
input logic abortframe;
input logic validframe;
input logic frame;

// sequence definition
sequence framestartTx;
	!tx ##1 tx[*6] ##1 !tx;
endsequence

sequence framestartRx;
	!rx ##1 rx [*6] ##1 !rx;
endsequence

sequence abortpatternTx;
	tx[*7] ##1 !tx;
endsequence

sequence abortpatternRx;
	rx[*7] ##1 !rx;
endsequence

// property definition

  // Tx assertions
property generated_startframe; // Legge til and validframe?
	@(posedge txclk) $rose(frame) and !abortframe and txen |-> ##2 framestartTx; // and frame
endproperty

property generated_abortpattern;
	@(posedge txclk) $rose(abortframe) and txen |-> ##2 abortpatternTx;
endproperty

property generated_endframe;
	@(posedge txclk) $fell(frame) and txen |-> ##2 framestartTx;
endproperty

/*
property abortedtrans_check;
	@(posedge txclk)
endproperty

property ready_check; // Can accept new data
	@(posedge txclk)
endproperty

property write_byte;
	@(posedge txclk)
endproperty
*/

//property TxDone_check;
//	@(posedge txclk) txdone implies //4.5 avsnitt checks
//endproperty

  // Rx assertions





property byte1_check;
	@(posedge clk_i) $rose(ack_o) |-> dat_o[7:0] == counter;
endproperty

property byte2_check;
	@(posedge clk_i) $rose(ack_o) |-> dat_o[15:8] == counter;
endproperty

//property byte3_check;
////DAT_0=(23 downto 16) = counter when ??
//endproperty

//property byte4_check;
////DAT_0=(31 downto 24) = counter when ??
//endproperty

// assert, assume statement
 // Tx assertions

assert_generated_startframe: assert property (generated_startframe)
	$display($time,,,"\tGenerated startframe PASS:: TxEN=%b  AbortFrame=%b Frame=%b  \n", txen, abortframe, frame);
else $display($time,,,"\tGenerated startframe FAIL:: TxEN=%b  AbortFrame=%b Frame=%b  \n", txen, abortframe, frame);

assert_generated_endframe: assert property (generated_endframe)
	$display($time,,,"\tGenerated endframe PASS:: TxEN=%b  AbortFrame=%b Frame=%b  \n", txen, abortframe, frame);
else $display($time,,,"\tGenerated endframe FAIL:: TxEN=%b  AbortFrame=%b Frame=%b  \n", txen, abortframe, frame);

//assert_byte1: assert property (byte1_check)
//	$display($time,,,"\tByte 1 PASS:: DAT_O=%b  ACK_O=%b  \n", dat_o,$rose(ack_o));
//else $display($time,,,"\tByte 1 FAIL:: DAT_O=%b  ACK_O=%b \n", dat_o,$rose(ack_o));
/*
assert_byte2: assert property (byte2_check)
	$display($time,,,"\tByte 2 PASS:: DAT_O=%b  ACK_O=%b  \n", dat_o[15:8],$rose(ack_o));
else $display($time,,,"\tByte 2 FAIL:: DAT_O=%b  ACK_O=%b \n", dat_o[15:8],$rose(ack_o));
*/

//cover statement
// Reuse below with a sequence with formal parameters
cover property (@(posedge txclk) framestartTx)
	$display($stime,,,"\tTX flag, frame start\n"); // Looking for 01111110
cover property (@(posedge rxclk) framestartRx)
	$display($stime,,,"\tRX flag, frame start\n"); // Looking for 01111110

//cover property (@(posedge txclk) txdone)
//	$display($stime,,,"\tRX flag, frame start\n"); // Looking for 01111110


endmodule