module hdlc_props(txclk,rxclk,tx,rx,txen,rxen, txdone,dat_o,ack_o,clk_i,counter,abortframe,validframe,frame,flagdetect,rxabortframe,shiftreg,abort,rxd,databuff,data_out,wr,cs,add,data_in);
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
input logic [31:0]counter;
input logic abortframe;
input logic validframe;
input logic frame;
input logic flagdetect;
input logic rxabortframe;
input logic [7:0]shiftreg;
input logic abort;
input logic [7:0]rxd;
input logic [7:0]databuff;
input logic cs;
input logic wr;
input logic [7:0] data_out;
input logic [7:0]data_in;
input logic [6:0] add;
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
property TxEnable;
    @(posedge txclk) $rose(frame) and !abortframe and txen |-> ##2 framestartTx; // and frame
endproperty
 
property generated_abortpattern;
    @(posedge txclk) $rose(abortframe) and txen |-> ##1 abortpatternTx;
endproperty
 
property generated_end_of_frame_pattern;
    @(posedge txclk) $fell(frame) and txen |-> ##1 framestartTx;
endproperty

// Rx assertions
property notabortwhenflag;
    @(posedge rxclk) flagdetect |-> ##1 !rxabortframe;
endproperty  

property detectFlag;
    @(posedge rxclk) shiftreg == 8'b01111110 |-> ##1 flagdetect;
endproperty


property abortFrame;
    @(posedge rxclk) abort |-> ##1 rxabortframe;
endproperty



property writeenable;
    @(posedge clk_i) $fell(wr) |-> ##1 data_out == 8'b11111111; 
endproperty

property setDataOut;
    @(posedge clk_i) disable iff ($isunknown(data_out)) cs and !wr |-> ##2 (data_out == data_in+1);
endproperty

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
//assert_byte1: assert property (byte1_check);
	//$display($time,,,"\tByte 1 PASS:: DAT_O=%b  counter=%b  \n", dat_o[7:0],counter[7:0]);
//else $display($time,,,"\tByte 1 FAIL:: DAT_O=%b  counter=%b \n", dat_o[7:0],counter[7:0]);

//assert_byte2: assert property (byte2_check);
	//$display($time,,,"\tByte 2 PASS:: DAT_O=%b  counter=%b  \n", dat_o[15:8],$past(counter[7:0]));
//else $display($time,,,"\tByte 2 FAIL:: DAT_O=%b  counter=%b \n", dat_o[15:8],$past(counter[7:0]));

//assert_byte3: assert property (byte3_check);
	//$display($time,,,"\tByte 3 PASS:: DAT_O=%b	counter=%b	\n", dat_o[23:16],$past(counter[7:0],2));
 //else $display($time,,,"\tByte 3 FAIL:: DAT_O=%b  counter=%b \n", dat_o[23:16],$past(counter[7:0],2));
//assert_byte4: assert property (byte4_check);
//	$display($time,,,"\tByte 4 PASS:: DAT_O=%b	counter=%b	\n", dat_o[31:24],$past(counter[7:0],3));
//else $display($time,,,"\tByte 4 FAIL:: DAT_O=%b	counter = %b \n",dat_o[31:24],$past(counter[7:0],3));

assert_txenable: assert property (TxEnable)
    $display($time,,,"\tTxEnable PASS:: TxEN=%b  AbortFrame=%b Frame=%b  \n", txen, abortframe, frame);
else $display($time,,,"\tTxEnable FAIL:: TxEN=%b  AbortFrame=%b Frame=%b  \n", txen, abortframe, frame);

assert_notabortwhenflag: assert property (notabortwhenflag)
    $display($time,,,"\tNotAbort PASS:: flagDetect=%b  AbortFrame=%b  \n", flagdetect, rxabortframe);
else $display($time,,,"\tnotAbort FAIL:: flagDetect=%b  AbortFrame=%b  \n", flagdetect, rxabortframe);

assert_detectflag: assert property (detectFlag)
    $display($time,,,"\tdetectFlag PASS:: flagDetect=%b  ShiftReg=%b  \n", flagdetect, shiftreg);
else $display($time,,,"\tdetectFlag FAIL:: flagDetect=%b  ShiftReg=%b  \n", flagdetect, shiftreg);

assert_abortFrame: assert property (abortFrame)
    $display($time,,,"\tdetectFlag PASS:: abort=%b  abortFrame=%b  \n", abort, rxabortframe);
else $display($time,,,"\tdetectFlag FAIL:: abort=%b  abortFrame=%b  \n", abort, rxabortframe);

assert_lemon: assert property (writeenable);
//    $display($time,,,"\tWrite enable PASS:: wr=%b  data_out=%b  \n", $past(wr), $past(data_out));
//else $display($time,,,"\tWrite enbale FAIL:: wr=%b  data_out=%b  \n", $past(wr), $past(data_out));

assert_datain_dataout: assert property (setDataOut)
    $display($time,,,"\tSet Data Out PASS:: wr=%b  data_out=%b  \n", $past(wr), $past(data_out));
else $display($time,,,"\tSet Data Out FAIL:: wr=%b  data_out=%b  \n", $past(wr), $past(data_out));

//cover statement
// Reuse below with a sequence with formal parameters
cover property (@(posedge txclk) !tx ##1 tx [*6] ##1 !tx)
	$display($stime,,,"\tTX flag, frame start\n"); // Looking for 01111110
cover property (@(posedge rxclk) !rx ##1 rx [*6] ##1 !rx)
	$display($stime,,,"\tRX flag, frame start\n"); // Looking for 01111110




endmodule
