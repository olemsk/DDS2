onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary -radixshowbase 1 /hdlc_tb/RxSerData
add wave -noupdate /hdlc_tb/RxClk
add wave -noupdate /hdlc_tb/Tx
add wave -noupdate /hdlc_tb/Rx
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {141749 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 236
configure wave -valuecolwidth 288
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
WaveRestoreZoom {307400 ns} {319027 ns}
