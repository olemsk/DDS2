vlib work
vlib utility
vlib hdlc
vlib memlib

vmap work
vmap utility
vmap hdlc
vmap memlib

# Type: vsim -novopt -do top/scripts/model/build_hdlc_top.do
# to start Questasim, then run this script by: do sim_script.do

# Compile
vlog -sv top/scripts/sva/hdlc_props.v
vlog -sv top/scripts/sva/sva_wrapper.v

# Run
vsim -c work.hdlc_tb work.sva_wrapper
do top/scripts/model/wavetxen.do # or change with different wave file
run 100ms # 
