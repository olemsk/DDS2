module sva_wrapper;
	bind hdlc_tb hdlc_props hdlc_props_sva_bind(
		.txclk(Txclk),
		.rxclk(RxClk),
		.tx(Tx),
		.rx(Rx),
		.txen(TxEN),
		.rxen(RxEN),
		.txdone(TxDone) // funkar detta? (kanskje DUT/TxBuff/TxDone ?)
	);
endmodule 

// https://verificationacademy.com/forums/systemverilog/question-related-sv-binding
