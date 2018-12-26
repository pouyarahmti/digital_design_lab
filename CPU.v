module CPU();

	wire myclock;

	wire [63:0] pc_output ;
	wire [63:0] adder_for_pc_to_mux_after_shift_adder ;
	wire [63:0] mux_after_shift_adder_to_pc;
	wire [63:0] adder_for_shift_to_mux_after_shift_adder;
	wire [31:0] instruction_memory_output ;
	wire [4:0] mux_befor_register_bank_to_register_bank;
	wire [63:0] register_bank_output1_to_alu ;
	wire [63:0] register_bank_output2_to_mux_after_register_bank;
	wire [63:0] mux_after_register_bank_to_alu;
	wire [63:0] data_after_sign_extend;
	wire [3:0] alu_control_to_alu;
	wire [63:0] alu_result ;
	wire [63:0] memory_output_to_mux_after_memory;
	wire [63:0] mux_after_memory_to_register_bank;
	wire [63:0] shift_to_shift_adder;
	wire [63:0] mux_after;

	wire zero;
	
	wire regtoloc, branch, memread, memtoreg, aluop0 , aluop1 , memwrite, alusrc, regwrite;

	clock(
		.clk(myclock)
	);

	registerbank(
		.clk(myclock),
		.write(regwrite),
		.address1(instruction_memory_output[9:5]),
		.address2(mux_befor_register_bank_to_register_bank),
		.address3(instruction_memory_output[4:0]),
		.input_data(mux_after_memory_to_register_bank),
		.output_data1(register_bank_output1_to_alu),
		.output_data2(register_bank_output2_to_mux_after_register_bank)
	);

	//the pc
	register(
		.old_pc(pc_output),
		.clock(myclock),
		.new_pc(mux_after_shift_adder_to_pc),
		.write(),
		.reset()
	);

	ALU(.
		num1(register_bank_output1_to_alu), 
		.num2(mux_after_register_bank_to_alu), 
		.op(alu_control_to_alu), 
		.z(zero), 
		.out(alu_result) 
	);

	mux_befor_register_bank( 
		.out(mux_befor_register_bank_to_register_bank), 
		.address(regtoloc),
		.in1(instruction_memory_output[20:16]),
		.in2(instruction_memory_output[4:0])
	);
	mux_after_register_bank( 
		.out(mux_after_register_bank_to_alu), 
		.address(alusrc),
		.in1(register_bank_output2_to_mux_after_register_bank),
		.in2(data_after_sign_extend)
	);
	mux_after_memory( 
		.out(mux_after_memory_to_register_bank), 
		.address(memtoreg),
		.in1(alu_result),
		.in2(memory_output_to_mux_after_memory)
	);
	mux_after_shift_adder( 
		.out(mux_after_shift_adder_to_pc), 
		.address(zero&branch),
		.in1(adder_for_pc_to_mux_after_shift_adder),
		.in2(adder_for_shift_to_mux_after_shift_adder)
	);

	adder_for_shift(
		.in1(pc_output),
		.in2(shift_to_shift_adder),
		.out(adder_for_shift_to_mux_after_shift_adder)
	);

	adder_for_pc(
		.in1(pc_output),
		.in2(4),
		.out(adder_for_pc_to_mux_after_shift_adder)
	);
	
	signextend(
		.instruction(instruction_memory_output[31:0]),
		.extended_address(data_after_sign_extend)
	);
	
	InstructionMemory( 
		.address(pc_output),
		.out(instruction_memory_output)
	);

	ALU_Control(
		.ALU_Op({aluop1,aluop0}),//this my will be wrong 
		.Op_Code(instruction_memory_output[31:21]),
		.ALU_In(alu_control_to_alu)
	);
	
	Controller(
		.Instruction(instruction_memory_output[31:21]), 
		.Reg2Loc(regtoloc), 
		.ALUSrc(alusrc), 
		.MemtoReg(memtoreg), 
		.RegWrite(regwrite), 
		.MemRead(memread), 
		.MemWrite(memwrite), 
		.Branch(branch), 
		.ALUOp1(aluop1), 
		.ALUOp0(aluop0)
	);
	memory(
		.d_out(memory_output_to_mux_after_memory), 
		.clock(myclock),
		.address(alu_result),
		.d_in(register_bank_output2_to_mux_after_register_bank),
		.read(memread),
		.write(memwrite) 
	);
	
	shift_2bit(
		.in(data_after_sign_extend),
		.out(shift_to_shift_adder)
	);

		
endmodule