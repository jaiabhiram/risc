
module RV32I(output [31:0] Result,output [31:0] Result2,input clk,rst,input test,input [7:0] test_addr,output zero,overload );
wire [6:0] opcode;
wire [14:12] funct3; 
wire [31:25] funct7; 
wire [31:0] Instr;
wire br_taken,ResultSrc,reg_wr,sel_A,sel_B; 
wire [3:0] alu_op;
wire [2:0] ImmSrc, br_type, ReadControl,WriteControl;
wire [1:0] wb_sel;

//For test Purpose code
wire [2:0] ReadControl_t;

assign ReadControl_t = test ? 3'b010:ReadControl;

//End for Test Purpose Code


datapath dp(opcode, funct3, funct7, Result,Result2, rst,clk,reg_wr,sel_A,sel_B, wb_sel, ImmSrc, alu_op,br_type,ReadControl_t,WriteControl,test,test_addr,zero,overload);
controller con(ImmSrc,alu_op,br_type,ReadControl,WriteControl, reg_wr, sel_A, sel_B, wb_sel, opcode, funct3, funct7,rst);

endmodule

