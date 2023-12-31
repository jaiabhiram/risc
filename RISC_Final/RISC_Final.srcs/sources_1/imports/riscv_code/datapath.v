module datapath(output [6:0] opcode,
                output [14:12] funct3, 
                output [31:25] funct7, 
                output [31:0] Result,output [31:0] Result2,
                input rst,clk, reg_wr,sel_A,sel_B,
                input [1:0] wb_sel,
                input [2:0] ImmSrc,input [3:0] alu_op, input [2:0] br_type, ReadControl, WriteControl,input test,input [7:0]test_addr,
                output zero,over_load);
	
	wire [31:0] PC, PCNext, PCPlus4, ImmExt, SrcA, RD1, RD2, SrcB, rdata, ALUResult, Instr;
	wire [24:20] rs2;
	wire [19:15] rs1;
	wire [11:7] rd;
    wire [31:7] imm;
    wire br_taken;

	//For Test Purpose
    wire [31:0] inpaddr_t;
    wire [31:0] Result2_t;
	assign inpaddr_t = test? test_addr:ALUResult[7:0];
	assign Result2 = test?rdata:Result2_t;
	//End of Test Purpose Code
	
	
	//instantiate and join all modules of datapath here
	mux2 #(32) pcnext(PCNext,PCPlus4,ALUResult,br_taken);
	pc pc_inst(PC,clk,rst,PCNext);
	adder pc_plus4(PCPlus4,PC,32'd4);
	instruction_memory ins_mem(Instr,PC);
	instruction_fetch ins_fetch(opcode,rd,funct3,rs1,rs2,funct7,imm,Instr);
	extend ext(ImmExt,Instr[31:7],ImmSrc);
	register_file reg_file(RD1,RD2,clk, reg_wr, rst, rs1,rs2,rd, Result);
	branch_cond Br_taken(br_taken,br_type,RD1,RD2);
	mux2 #(32) srcA(SrcA,PC,RD1,sel_A);
	mux2 #(32) srcB(SrcB,RD2,ImmExt,sel_B);
	alu aalu(SrcA,SrcB,alu_op, ALUResult,zero,over_load);
	data_memory data_mem(rdata,clk,rst,ReadControl,WriteControl,inpaddr_t,RD2);
	mux3 #(32) result(Result,PCPlus4,ALUResult,rdata,wb_sel);
	result2 #(32) r2(Result2_t,Result,wb_sel);
	
endmodule
