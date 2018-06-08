onerror {quit -f}
vlib work
vlog -work work contador.vo
vlog -work work contador.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.alarme_vlg_vec_tst
vcd file -direction contador.msim.vcd
vcd add -internal alarme_vlg_vec_tst/*
vcd add -internal alarme_vlg_vec_tst/i1/*
add wave /*
run -all
