module fsm_sar_bs (clk,SOC,EOC,Q ,sample,D,cmp);

input clk; // clock input
input SOC; // SOC=1 to perform conversion
output EOC; // EOC=1 when conversion finished
//output [9:0] result; // 8 bit result output
output sample; // to S&H circuit
output [7:0] D; // to DAC
output [7:0] Q; // BORRAR 
input cmp; // from comparator

reg [1:0] state; // current state in state machine
reg [7:0] SR; // bit to test in binary search
reg [7:0] result; // hold partially converted result
reg [7:0] qn;
wire EOCN;

	parameter sWait=0, sSample=1, sConv=2, sDone=3;

// synchronous design
	always @(posedge clk) begin
		if (SOC) state <= sWait; // stop and reset if SOC=0
	else case (state) // choose next state in state machine
		sWait :  state <= sSample; 
	sSample :
		begin // start new conversion so
			state <= sConv; // enter convert state next
		SR <= 7'b1000000; // reset SR to MSB only
		result <= 7'b0000000; // clear result
	end

	sConv :
		begin
					// set bit if comparitor indicates input larger than
					// D currently under consideration, else leave bit clear
	if (cmp) result <= result | SR;
					// shift SR to try next bit next time
	SR <= SR>>1;
					// finished once LSB has been done
	if (SR[0]) state <= sDone;
	end

	sDone :;
	endcase

	end

	assign sample = state==sSample; // drive sample and hol
	assign D = result | SR; // (result so far) OR (bit to try)
	assign EOC = state==sDone; // indicate when finished
	assign EOCN = state==sDone; // indicate when finished
	assign Q = qn;
// LATCH D
  
	always @(posedge EOCN) begin
	  qn = result; 	
	end
	endmodule
