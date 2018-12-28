`default_nettype none
module CPU();

	wire myclock;
	wire zero;
	wire regtoloc, branch, memread, memtoreg, aluop0 , aluop1 , memwrite, alusrc, regwrite;

	wire [31:0] instruction_memory_output ;
	wire [4:0] mux_befor_register_bank_to_register_bank;
	wire [3:0] alu_control_to_alu;

	wire [63:0] pc_output ;
	wire [63:0] adder_for_pc_to_mux_after_shift_adder ;
	wire [63:0] mux_after_shift_adder_to_pc;
	wire [63:0] adder_for_shift_to_mux_after_shift_adder;

	wire [63:0] register_bank_output1_to_alu ;
	wire [63:0] register_bank_output2_to_mux_after_register_bank;
	wire [63:0] mux_after_register_bank_to_alu;
	wire [63:0] data_after_sign_extend;

	wire [63:0] alu_result ;
	wire [63:0] memory_output_to_mux_after_memory;
	wire [63:0] mux_after_memory_to_register_bank;
	wire [63:0] shift_to_shift_adder;

	
	wire [31:0] IFID_instruction_memory_output;
	wire [5:0] IDEX_instruction_memory_output40;
	wire [5:0] EXMEM_instruction_memory_output40;
	wire [5:0] MEMWB_instruction_memory_output40;
	wire IDEX_regwrite,EXMEM_regwrite,MEMWB_regwrite;
	
	reg pcReset;

	clock MyClock(
		.clk(myclock)
	);
	initial begin
		 pcReset = 1'b1;
		#210 pcReset = 1'b0;
	end

	Controller MyController(
		.Instruction(IFID_instruction_memory_output[31:21]), 
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

	//the pc
	register MyRegister(//the same 
		.old_pc(pc_output),
		.clock(myclock),
		.new_pc(mux_after_shift_adder_to_pc),
		.reset(pcReset)
	);
	
	register#(.n(32)) IFID_instruction_reg(IFID_instruction_memory_output , myclock , instruction_memory_output , pcReset );


	adder MyAdderForPc(//the same
		.in1(pc_output),
		.in2(64'b100),
		.out(adder_for_pc_to_mux_after_shift_adder)
	);
	
	InstructionMemory MyInstructionMemory(//the same  
		.address(pc_output),
		.out(instruction_memory_output)
	);
	
	
	mux mux_befor_register_bank( // samed 
		.out(mux_befor_register_bank_to_register_bank), 
		.address(regtoloc),
		.in1(IFID_instruction_memory_output[20:16]),
		.in2(IFID_instruction_memory_output[4:0])
	);
	
	
	register#(.n(5)) IDEX_instruction_memory_output40_reg(IDEX_instruction_memory_output40 , myclock , IFID_instruction_memory_output[4:0] , pcReset );
	register#(.n(5)) EXMEM_instruction_memory_output40_reg(EXMEM_instruction_memory_output40 , myclock , IDEX_instruction_memory_output40 , pcReset );
	register#(.n(5)) MEMWB_instruction_memory_output40_reg(MEMWB_instruction_memory_output40 , myclock , EXMEM_instruction_memory_output40 , pcReset );
	
	
	register#(.n(1)) IDEX_regwrite_reg(IDEX_regwrite , myclock , regwrite, pcReset );
	register#(.n(1)) EXMEM_regwrite_reg(EXMEM_regwrite , myclock , IDEX_regwrite, pcReset );
	register#(.n(1)) MEMWB_regwrite_reg(MEMWB_regwrite , myclock , EXMEM_regwrite, pcReset );
	
	registerbank MyRegisterbank(//samed
		.clk(myclock),
		.write(MEMWB_regwrite),
		.address1(IFID_instruction_memory_output[9:5]),//samed
		.address2(mux_befor_register_bank_to_register_bank),//s
		.address3(MEMWB_instruction_memory_output40),
		.input_data(mux_after_memory_to_register_bank),//s
		.output_data1(register_bank_output1_to_alu),//s
		.output_data2(register_bank_output2_to_mux_after_register_bank)//s
	);
	
	signextend MySignExtend(//samed
		.instruction(IFID_instruction_memory_output),
		.extended_address(data_after_sign_extend)
	);

		
	wire IDEX_alusrc;
	wire [63:0] IDEX_data_after_sign_extend;
	wire [63:0] IDEX_register_bank_output2_to_mux_after_register_bank;
	
	register#(.n(1)) IDEX_alusrc_reg(IDEX_alusrc , myclock , alusrc, pcReset );	
	register#(.n(64)) IDEX_data_after_sign_extend_reg(IDEX_data_after_sign_extend , myclock , data_after_sign_extend, pcReset );
	register#(.n(64)) IDEX_register_bank_output2_to_mux_after_register_bank_reg(IDEX_register_bank_output2_to_mux_after_register_bank , myclock , register_bank_output2_to_mux_after_register_bank, pcReset );	
	
	mux mux_after_register_bank( 
		.out(mux_after_register_bank_to_alu), //t
		.address(IDEX_alusrc),
		.in1(IDEX_register_bank_output2_to_mux_after_register_bank),
		.in2(IDEX_data_after_sign_extend)
	);

	wire [63:0] IDEX_register_bank_output1_to_alu;
	
	register#(.n(64)) IDEX_register_bank_output1_to_alu_reg(IDEX_register_bank_output1_to_alu , myclock , register_bank_output1_to_alu, pcReset );	
	
	ALU MyAlu(
		.num1(IDEX_register_bank_output1_to_alu), 
		.num2(mux_after_register_bank_to_alu), 
		.op(alu_control_to_alu), 
		.z(zero), 
		.out(alu_result) 
	);
	wire [1:0] IDEX_alu_op;
	wire [31:0] IDEX_instruction_memory_output;
	register#(.n(2)) IDEX_alu_op_reg(IDEX_alu_op , myclock , {aluop1,aluop0}, pcReset );
	register#(.n(32)) IDEX_instruction_reg(IDEX_instruction_memory_output , myclock , IFID_instruction_memory_output , pcReset );
	
	ALU_Control MyAluControl(
		.ALU_Op(IDEX_alu_op),//this my will be wrong 
		.instruction(IDEX_instruction_memory_output),
		.ALU_In(alu_control_to_alu)
	);
	
	shift_2bit MyTwoBitShift(
		.in(IDEX_data_after_sign_extend),
		.out(shift_to_shift_adder)
	);
	
	wire [63:0] IFID_pc_output;
	wire [63:0] IDEX_pc_output;
	register#(.n(64)) IFID_pc_output_reg(IFID_pc_output , myclock , pc_output, pcReset );	
	register#(.n(64)) IDEX_pc_output_reg(IDEX_pc_output , myclock , IFID_pc_output, pcReset );	
	
	adder MyAdderForShift(
		.in1(IDEX_pc_output),
		.in2(shift_to_shift_adder),//differ
		.out(adder_for_shift_to_mux_after_shift_adder)
	);

	mux mux_after_shift_adder( 
		.out(mux_after_shift_adder_to_pc), 
		.address(zero&branch),
		.in1(adder_for_pc_to_mux_after_shift_adder),
		.in2(adder_for_shift_to_mux_after_shift_adder)
	);
	wire [63:0] EXMEM_alu_result;
	wire [63:0] EXMEM_register_bank_output2_to_mux_after_register_bank;	
	wire IDEX_memread , EXMEM_memread , IDEX_memwrite , EXMEM_memwrite;
	register#(.n(64)) EXMEM_alu_result_reg(EXMEM_alu_result , myclock , alu_result, pcReset );	
	register#(.n(64)) EXMEM_register_bank_output2_to_mux_after_register_bank_reg(EXMEM_register_bank_output2_to_mux_after_register_bank , myclock , IDEX_register_bank_output2_to_mux_after_register_bank, pcReset );	
	register#(.n(1)) IDEX_memread_reg(IDEX_memread , myclock , memread, pcReset );
	register#(.n(1)) EXMEM_memread_reg(EXMEM_memread , myclock , IDEX_memread, pcReset );
	register#(.n(1)) IDEX_memwrite_reg(IDEX_memwrite , myclock , memwrite, pcReset );
	register#(.n(1)) EXMEM_memwrite_reg(EXMEM_memwrite , myclock , IDEX_memwrite, pcReset );	
	memory myMemory(
		.d_out(memory_output_to_mux_after_memory), 
		.clock(myclock),
		.address(EXMEM_alu_result),
		.d_in(EXMEM_register_bank_output2_to_mux_after_register_bank),
		.read(EXMEM_memread),
		.write(EXMEM_memwrite) 
	);
	
	wire IDEX_memtoreg , EXMEM_memtoreg , MEMWB_memtoreg;
	wire [63:0] MEMWB_alu_result;
	wire [63:0] MEMWB_memory_output_to_mux_after_memory;
	
	register#(.n(1)) IDEX_memtoreg_reg(IDEX_memtoreg , myclock , memtoreg, pcReset );	
	register#(.n(1)) EXMEM_memtoreg_reg(EXMEM_memtoreg , myclock , IDEX_memtoreg, pcReset );	
	register#(.n(1)) MEMWB(MEMWB_memtoreg , myclock , EXMEM_memtoreg, pcReset );	
	register#(.n(64)) MEMWB_alu_result_reg(MEMWB_alu_result , myclock , EXMEM_alu_result, pcReset );	
	register#(.n(64)) MEMWB_memory_output_to_mux_after_memory_reg(MEMWB_memory_output_to_mux_after_memory , myclock , memory_output_to_mux_after_memory, pcReset );	
	mux mux_after_memory( 
		.out(mux_after_memory_to_register_bank), 
		.address(MEMWB_memtoreg),
		.in1(MEMWB_alu_result),
		.in2(MEMWB_memory_output_to_mux_after_memory)
	);



	






		
endmodule