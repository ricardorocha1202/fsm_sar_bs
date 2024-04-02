module fsm_sar_bs (
    input [6:0] thermometer_input,
    output reg [2:0] binary_output
);

always @(*) begin
    case(thermometer_input)
        7'b0000000: binary_output = 3'b000; // 0000000 -> 000
        7'b0000001: binary_output = 3'b001; // 0000001 -> 001
        7'b0000011: binary_output = 3'b010; // 0000011 -> 010
        7'b0000111: binary_output = 3'b011; // 0000111 -> 011
        7'b0001111: binary_output = 3'b100; // 0001111 -> 100
        7'b0011111: binary_output = 3'b101; // 0011111 -> 101
        7'b0111111: binary_output = 3'b110; // 0111111 -> 110
        7'b1111111: binary_output = 3'b111; // 1111111 -> 111
        default: binary_output = 3'b000; // Default case (if input exceeds 7 bits)
    endcase
end
