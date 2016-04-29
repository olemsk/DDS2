onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hdlc_tb/DUT/Rx_Readbyte_D1
add wave -noupdate /hdlc_tb/DUT/RxChannel/ValidFrame_i
add wave -noupdate /hdlc_tb/DUT/RxChannel/aval_i
add wave -noupdate /hdlc_tb/DUT/RxChannel/enable_i
add wave -noupdate /hdlc_tb/DUT/RxChannel/initzero_i
add wave -noupdate /hdlc_tb/DUT/RxChannel/RxD_i
add wave -noupdate /hdlc_tb/DUT/RxChannel/RxData
add wave -noupdate /hdlc_tb/DUT/Rx_rdy_D1
add wave -noupdate /hdlc_tb/DUT/RxClk
add wave -noupdate /hdlc_tb/DUT/rst_n
add wave -noupdate /hdlc_tb/DUT/RxChannel/zero_backend/DataRegister
add wave -noupdate /hdlc_tb/DUT/RxChannel/zero_backend/flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {307868 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 375
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
WaveRestoreZoom {398423 ns} {400083 ns}
