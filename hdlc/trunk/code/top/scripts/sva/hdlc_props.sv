module hdlc_props(txclk,rxclk,tx,rx,txen,rxen, txdone, dat_o, ack_o, clk_i);
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

// sequence definition

// property definition
//property TxDone_check;
//	@(posedge txclk) txdone implies //4.5 avsnitt checks
//endproperty


//property check1;
  //@(posedge clk) reset implies state_s == IDLE;
//endproperty

property byte1_check;
	@(posedge clk_i) $rose(ack_o) |-> dat_o[7:0] == 8'b0;
endproperty

property byte2_check;
	@(posedge clk_i) $rose(ack_o) |=> dat_o[15:8] == 8'b1;
endproperty

//property byte3_check;
////DAT_0=(23 downto 16) = counter when ??
//endproperty

//property byte4_check;
////DAT_0=(31 downto 24) = counter when ??
//endproperty

// assert, assume statement
assert_byte1: assert property (byte1_check)
	$display($time,,,"\tByte 1 PASS:: DAT_O=%b  ACK_O=%b  \n", dat_o,$rose(ack_o));
else $display($time,,,"\tByte 1 FAIL:: DAT_O=%b  ACK_O=%b \n", dat_o,$rose(ack_o));

assert_byte2: assert property (byte2_check)
	$display($time,,,"\tByte 2 PASS:: DAT_O=%b  ACK_O=%b  \n", dat_o[15:8],$rose(ack_o));
else $display($time,,,"\tByte 2 FAIL:: DAT_O=%b  ACK_O=%b \n", dat_o[15:8],$rose(ack_o));


//cover statement
// Reuse below with a sequence with formal parameters
cover property (@(posedge txclk) !tx ##1 tx [*6] ##1 !tx)
	$display($stime,,,"\tTX flag, frame start\n"); // Looking for 01111110
cover property (@(posedge rxclk) !rx ##1 rx [*6] ##1 !rx)
	$display($stime,,,"\tRX flag, frame start\n"); // Looking for 01111110

cover property (@(posedge txclk) txdone)
	$display($stime,,,"\tRX flag, frame start\n"); // Looking for 01111110


endmodule
