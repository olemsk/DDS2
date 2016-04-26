vlib work
vlib utility
vlib hdlc
vlib memlib

vmap work
vmap utility
vmap hdlc
vmap memlib


vlog -sv top/scripts/sva/hdlc_props.sv
vlog -sv top/scripts/sva/sva_wrapper.v

vsim -c -coverage work.hdlc_tb work.sva_wrapper

do top/scripts/model/wave.do
