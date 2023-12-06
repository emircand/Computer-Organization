transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/mod_dp.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/mod_cu.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/mod.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/fa.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/cll_4bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/cla_4bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/cla_8bit.v}

vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/mod_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  mod_tb

add wave *
view structure
view signals
run -all
