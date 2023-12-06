transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/mux_32_8to1.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/xor_operation.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/or_operation.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/not_32.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/nor_operation.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/mux8to1.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/mux4to1.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/mux2to1.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/mod_dp.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/mod_cu.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/mod.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/less_than.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/fa.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/cll_4bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/cla_4bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/and_operation.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/cla_8bit.v}

vlog -vlog01compat -work work +incdir+C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules {C:/Users/emirc/Desktop/CodeWorks/verilog/1901042674_project2/my_modules/alu_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  alu_tb

add wave *
view structure
view signals
run -all
