module fsm_sar_bs (
    input [15:0] thermometer_input,
    output reg [3:0] binary_output
);

always @(*) begin
    case(thermometer_input)
        15'b000000000000000: binary_output = 4'b0000; // 0000000 0000000 -> 0000
        15'b000000000000001: binary_output = 4'b0001; // 0000000 0000001 -> 0001
        15'b000000000000011: binary_output = 4'b0010; // 0000000 0000011 -> 0010
        15'b000000000000111: binary_output = 4'b0011; // 0000000 0000111 -> 0011
        15'b000000000001111: binary_output = 4'b0100; // 0000000 0001111 -> 0100
        15'b000000000011111: binary_output = 4'b0101; // 0000000 0011111 -> 0101
        15'b000000000111111: binary_output = 4'b0110; // 0000000 0111111 -> 0110
        15'b000000001111111: binary_output = 4'b0111; // 0000000 1111111 -> 0111
		15'b000000011111111: binary_output = 4'b1000; // 0000000 0000000 -> 1000
        15'b000000111111111: binary_output = 4'b1001; // 0000000 0000001 -> 1001
        15'b000001111111111: binary_output = 4'b1010; // 0000000 0000011 -> 1010
        15'b000011111111111: binary_output = 4'b1011; // 0000000 0000111 -> 1011
        15'b000111111111111: binary_output = 4'b1100; // 0000000 0001111 -> 1100
        15'b001111111111111: binary_output = 4'b1101; // 0000000 0011111 -> 1101
        15'b011111111111111: binary_output = 4'b1110; // 0000000 0111111 -> 1110
        15'b111111111111111: binary_output = 4'b1111; // 0000000 1111111 -> 1111
		
        default: binary_output = 4'b0000; // Default case (if input exceeds 7 bits)
    endcase
end

endmodule
