onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hdlc_tb/Txclk
add wave -noupdate /hdlc_tb/RxClk
add wave -noupdate /hdlc_tb/TxEN
add wave -noupdate /hdlc_tb/DUT/TxCore/Frame_i
add wave -noupdate /hdlc_tb/Tx
add wave -noupdate /hdlc_tb/DUT/Tx_ValidFrame_D1
add wave -noupdate /hdlc_tb/DUT/Tx_AbortFrame_D1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {23303303 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 224
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
WaveRestoreZoom {23291307 ns} {23600558 ns}
