vlib work
vlog src/pipeline/alu.sv
vlog src/pipeline/control_unit.sv
vlog src/pipeline/data_memory.sv
vlog src/pipeline/imm_gen.sv
vlog src/pipeline/instruction_memory.sv
vlog src/pipeline/register_file.sv
vlog src/pipeline/if_stage.sv
vlog src/pipeline/id_stage.sv
vlog src/pipeline/ex_stage.sv
vlog src/pipeline/mem_stage.sv
vlog src/pipeline/wb_stage.sv
vlog src/pipeline/forwarding_unit.sv
vlog src/pipeline/hazard_unit.sv
vlog src/pipeline/top.sv
vlog src/pipeline/accelerator/matmul_unit.sv
vlog src/pipeline/accelerator/mac_unit.sv
vlog src/pipeline/accelerator/address_decoder.sv
vlog tb/tb_pipeline.sv
vopt +acc tb_pipeline -o tb_pipeline_acc
vsim tb_pipeline_acc
add wave -r /*