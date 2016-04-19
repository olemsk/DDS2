module sva_wrapper;
	bind hdlc_tb hdlc_props hdlc_props_sva_bind(
		.txclk(Txclk),
		.rxclk(RxClk),
		.tx(Tx),
		.rx(Rx),
		.txen(TxEN),
		.rxen(RxEN),
		.clk_i(CLK_I),
		.dat_o(DAT_O),
		.ack_o(ACK_O),
		.txdone(DUT.TxDone)
		//.counter(counter)
);
endmodule
