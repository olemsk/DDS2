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
		.counter(DUT.WB_host.counter),
       		.txdone(DUT.TxDone),
                .abortframe(DUT.Tx_AbortFrame_D1),
       		.validframe(DUT.Tx_ValidFrame_D1),
        	.frame(DUT.TxCore.Frame_i), // Internal Frame strobe to flag insert block
		.rxabortframe(DUT.RxChannel.Controller.AbortedFrame),
		.flagdetect(DUT.RxChannel.Controller.FlagDetect),
		.shiftreg(DUT.RxChannel.flag_detect.ShiftReg),
		.abort(DUT.RxChannel.Controller.Abort),
		.databuff(DUT.RxBuff.DataBuff),
		.rxd(DUT.RxFCS.RxD),
		.data_out(DUT.RxBuff.Buff.data_out),
		.wr(DUT.RxBuff.Buff.WR),
		.cs(DUT.RxBuff.Buff.cs),
		.add(DUT.RxBuff.Buff.add),
		.data_in(DUT.RxBuff.Buff.data_in),
		.readbyte(DUT.Rx_Readbyte_D1),
		.zeroFlag(DUT.RxChannel.zero_backend.flag),
		.enableZeroFlag(DUT.RxChannel.enable_i),
		.aval(DUT.RxChannel.zero_backend.aval)
);


endmodule
