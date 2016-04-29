module hdlc_rand_tb();

////// Instantiate DUT //////

//DUT hdlc_dut (

////// Bind stufffff //////

bind hdlc_ent hdlc_props hdlc_props_sva_bind(
	.txclk(Txclk),
	.rxclk(RxClk),
	.tx(Tx),
	.rx(Rx),
	.txen(TxEN),
	.rxen(RxEN),
	.clk_i(CLK_I),
	.dat_o(DAT_O),
	.ack_o(ACK_O),
	.txdone(TxDone),
	.counter(WB_host.counter),
	.abortframe(Tx_AbortFrame_D1),
	.validframe(Tx_ValidFrame_D1),
	.frame(TxCore.Frame_i) // Internal Frame strobe to flag insert block
);


typedef struct {
	rand bit [7:0]start_flag;
	rand bit [2:0]address;
	rand bit [7:0]control;
	rand byte 	  information[]; //?
		  bit [15:0]fcs; // CRC?
	rand bit [7:0]end_flag;
} hdlc_frame_t;

class hdlc_frame;
	rand hdlc_frame_t frame;
	
	//Class methods
	
	task check_fcs(bit fcs_value);
		// howto check
	endtask

	task getbits(ref bit data_o, input int delay=1);
		bit [18:0] header;
		bit [x:0] tail;
		header = {frame.start_flag, frame.address, frame.control};
		tail = {frame.fcs, frame.end_flag};
		//$display("tail=%0b", tail);
		// step through frame and output each bit (from left to right)
		foreach(header[i]) #delay data_o = header[i];		
		foreach(message.frame[i,j]) #delay data_o = frame.information[i][j];
		foreach(tail[i]) #delay data_o = tail[i];
	endtask

endclass: hdlc_frame


////// Testbench section //////
bit data_o;
const int bit_interval = 1;
hdlc_frame test_frames[10];
int interval = 10;

initial
frame_gen: begin 
	for (int i = 0; i < 10; i++) begin
		test_frames[i] = new;
		test_frames[i].randomize();
		test_frames[i].getbits(data_o, bit_interval);
	end
	$finish;
end: frame_gen

endmodule
