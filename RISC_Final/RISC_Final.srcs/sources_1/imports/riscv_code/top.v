module top_riscv(input clk,input reset,output [3:0] Anode_Activate,output [6:0] LED_out,input test,input [7:0]test_addr,output zero,output overload);
	wire clk_slow;
	wire[31:0] Result,Result2;
    
	//For Test Purpose
    wire clk_slow_t;
    assign clk_slow_t=test?0:clk_slow;

	//end code of Test Purpose
	clock_divider s1 (.clk_in(clk),.clk_out(clk_slow));
	RV32I rv(Result,Result2,clk_slow_t,reset,test,test_addr,zero,overload);
	Seven_segment_LED_Display_Controller s4 (.clock_100Mhz(clk),.reset(reset),.result_useless(Result),.result(Result2),.Anode_Activate(Anode_Activate),.LED_out(LED_out));

endmodule
