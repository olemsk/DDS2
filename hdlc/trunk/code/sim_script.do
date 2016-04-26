# Type: vsim -novopt -do top/scripts/model/build_hdlc_top.do
# to start Questasim, then run this script by: do sim_script.do

# NOTE: Adding comments after a command fucks shit up!
# NOTE: Run the script again if it returns error first time.

# Compile
vlog -sv top/scripts/sva/hdlc_props.v
vlog -sv top/scripts/sva/sva_wrapper.v

# Run
vsim -c work.hdlc_tb work.sva_wrapper

# Change wave file and runtime if desired
do top/scripts/model/wavetxen.do
run 100ms
