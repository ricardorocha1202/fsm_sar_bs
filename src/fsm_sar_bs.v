module fsm_sar_bs (
    input clk, // Entrada del reloj
    input SOC, // SOC=1 para realizar la conversión
    output reg EOC, // EOC=1 cuando la conversión haya terminado
    output reg sample, // para el circuito S&H
    output reg [6:0] D, // al DAC
    output reg [6:0] Q, // BORRAR 
    input cmp // desde el comparador
);

reg [1:0] state; // Estado actual en la máquina de estados
	reg [6:0] SR; // Bit para probar en la búsqueda binaria
	reg [6:0] result; // Mantener el resultado parcialmente convertido
	reg [6:0] qn;

// Parámetros de estado
parameter sWait = 2'b00, sSample = 2'b01, sConv = 2'b10, sDone = 2'b11;

// Diseño síncrono
always @(posedge clk) begin
    if (SOC) begin
        state <= sWait; // Detener y reiniciar si SOC=0
    end else begin
        case (state) // Elegir el próximo estado en la máquina de estados
            sWait: state <= sSample; 
            sSample: begin // Comenzar nueva conversión
                state <= sConv; // Entrar al estado de conversión
                SR <= 7'b1000000; // Restablecer SR solo al MSB
                result <= 7'b0000000; // Limpiar el resultado
            end
            sConv: begin
                // Establecer el bit si el comparador indica que la entrada es mayor que D
                // actualmente en consideración, de lo contrario dejar el bit claro
                if (cmp) result <= result | SR;
                // Desplazar SR para probar el próximo bit la próxima vez
                SR <= SR >> 1;
                // Terminado una vez que se ha hecho LSB
                if (SR[0]) state <= sDone;
            end
            sDone: ;
        endcase
    end
end

assign sample = (state == sSample); // Conducir sample and hold
assign D = result | SR; // (resultado hasta ahora) O (bit a probar)
assign EOC = (state == sDone); // Indicar cuando se haya terminado
assign Q = qn;

// LATCH D	
always @(posedge EOC) begin
    qn <= result; 	
end

endmodule
