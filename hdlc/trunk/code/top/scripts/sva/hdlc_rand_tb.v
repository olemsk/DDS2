module hdlc_rand_tb();

typedef struct {
	rand bit [7:0]start_flag;
	rand bit [3:0]address;
	rand bit [7:0]control;
	rand byte 	  information[]; //?
		  bit [7:0]fcs; // CRC?
	rand bit [7:0]end_flag;
} hdlc_frame_t;

class hdlc_frame;
	rand hdlc_frame_t frame;
	
	//Class methods
	
	task check_fcs(bit fcs_value);
		// howto check
	endtask

	task getbits(ref bit data_o, input int delay=1);
		bit [x:0] header;
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
