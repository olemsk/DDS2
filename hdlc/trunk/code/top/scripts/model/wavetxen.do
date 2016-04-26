onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hdlc_tb/Txclk
add wave -noupdate /hdlc_tb/RxClk
add wave -noupdate /hdlc_tb/TxEN
add wave -noupdate /hdlc_tb/DUT/TxCore/Frame_i
add wave -noupdate /hdlc_tb/Tx
add wave -noupdate /hdlc_tb/DUT/Tx_ValidFrame_D1
add wave -noupdate /hdlc_tb/DUT/Tx_AbortFrame_D1
add wave -noupdate /hdlc_tb/DUT/TxCore/inProgress_i
add wave -noupdate /hdlc_tb/DUT/TxCore/BackendEnable_i
add wave -noupdate /hdlc_tb/DUT/TxCore/AbortTrans_i
add wave -noupdate /hdlc_tb/DUT/TxCore/abortedTrans_i
add wave -noupdate /hdlc_tb/DUT/Tx_WriteByte_D1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {99997356 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 269
configure wave -valuecolwidth 112
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {99996738 ns} {100000172 ns}
