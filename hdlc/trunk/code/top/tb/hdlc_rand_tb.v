module hdlc_rand_tb();

////// Instantiate signals //////
// signals in hdlc_tb.vhd
parameter CLK_I = 10ns;
parameter TXCLK = 250ns;
parameter RXCLK = 250ns;

logic clk_i;
logic txclk;
logic rxclk;
logic tx;
logic rx;
logic txen;
logic rxen;
logic rst_i;
logic [2:0]adr_i;
logic [31:0]dat_o;
logic [31:0]dat_i;
logic we_i;
logic stb_i;
logic ack_o;
logic cyc_i;
logic rty_o;
logic tag0_o;
logic tag1_o;



/*  
// other signals
logic [7:0]counter;
logic txdone;
logic abortframe;
logic validframe;
logic frame; 
*/

////// Instantiate DUT //////
//DUT hdlc_dut (  // maybe not needed

////// Bind stufffff //////

bind hdlc_ent hdlc_props hdlc_props_sva_bind(
	.clk_i(CLK_I),
	.txclk(Txclk),
	.rxclk(RxClk),
	.tx(Tx),
	.rx(Rx),
	.txen(TxEN),
	.rxen(RxEN),
	.rst_i(RST_I),
	.adr_i(ADR_I),
	.dat_o(DAT_O),
	.dat_i(DAT_I),
	.we_i(WE_I),
	.stb_i(STB_I),
	.ack_o(ACK_O),
	.cyc_i(CYC_I),
	.rty_o(RTY_O),
	.tag0_o(TAG0_O),
	.tag1_o(TAG1_O),
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

	task getbits(ref bit data_o); //, input int delay=1);
		bit [18:0] header;
		bit [23:0] tail;
		header = {frame.start_flag, frame.address, frame.control};
		tail = {frame.fcs, frame.end_flag};
		//$display("tail=%0b", tail);
		// step through frame and output each bit (from left to right)
		foreach(header[i]) #(RXCLK) data_o = header[i];		
		foreach(message.frame[i,j]) #(RXCLK) data_o = frame.information[i][j];
		foreach(tail[i]) #(RXCLK) data_o = tail[i];
	endtask

endclass: hdlc_frame


////// Testbench section //////
bit data_o;
const int bit_interval = 1;
hdlc_frame test_frames[10];
int interval = 10;

initial
begin
clk_i = 1'b0;
txclk = 1'b0;
rxclk = 1'b0;

	fork
		begin 
			forever #(CLK_I/2) clk = ~clk_i;
		end 
		begin
			forever #(TXCLK/2) txclk = ~txclk;
		end
		begin
			forever #(RXCLK/2) rxclk = ~rxclk;
		end
	join_none
 
	for (int i = 0; i < 10; i++) begin
		test_frames[i] = new;
		test_frames[i].randomize();
		test_frames[i].getbits(data_o); //, bit_interval);
	end

	@(posedge rxclk)
		$display($stime,,, "data_o=%0b", data_o);

	$finish;
end

endmodule
