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
		.txdone(DUT.TxDone),
		.counter(DUT.WB_host.counter),
		.abortframe(DUT.Tx_AbortFrame_D1),
		.validframe(DUT.Tx_ValidFrame_D1),
		.frame(DUT.TxCore.Frame_i) // Internal Frame strobe to flag insert block
		.counter(DUT.WB_host.counter)
);
endmodule
