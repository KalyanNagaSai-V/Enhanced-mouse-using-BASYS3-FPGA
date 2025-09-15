module mouse_basys3_FPGA (
    input  wire        clock_100Mhz,
    input  wire        reset,
    input  wire        Mouse_Data,
    input  wire        Mouse_Clk,
    output reg  [3:0]  Anode_Activate,
    output reg  [6:0]  LED_out
);

    reg  [5:0]  Mouse_bits;
    reg  [15:0] displayed_number;
    reg  [3:0]  LED_BCD;
    reg  [20:0] refresh_counter;
    wire [1:0]  LED_activating_counter;

    always @(posedge Mouse_Clk or posedge reset) begin
        if (reset)
            Mouse_bits <= 0;
        else if (Mouse_bits <= 31)
            Mouse_bits <= Mouse_bits + 1;
        else
            Mouse_bits <= 0;
    end

    always @(negedge Mouse_Clk or posedge reset) begin
        if (reset) begin
            displayed_number <= 0;
        end else begin
            if (Mouse_bits == 1 && Mouse_Data) begin
                displayed_number <= displayed_number + 1;
            end else if (Mouse_bits == 2 && Mouse_Data && displayed_number > 0) begin
                displayed_number <= displayed_number - 1;
            end
        end
    end    

    always @(posedge clock_100Mhz or posedge reset) begin
        if (reset)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end

    assign LED_activating_counter = refresh_counter[20:19];

    always @(*) begin
        case (LED_activating_counter)
            2'b00: begin
                Anode_Activate = 4'b0111;
                LED_BCD = displayed_number / 1000;
            end
            2'b01: begin
                Anode_Activate = 4'b1011;
                LED_BCD = (displayed_number % 1000) / 100;
            end
            2'b10: begin
                Anode_Activate = 4'b1101;
                LED_BCD = (displayed_number % 100) / 10;
            end
            2'b11: begin
                Anode_Activate = 4'b1110;
                LED_BCD = displayed_number % 10;
            end
        endcase
    end

    always @(*) begin
        case (LED_BCD)
            4'd0: LED_out = 7'b0000001;
            4'd1: LED_out = 7'b1001111;
            4'd2: LED_out = 7'b0010010;
            4'd3: LED_out = 7'b0000110;
            4'd4: LED_out = 7'b1001100;
            4'd5: LED_out = 7'b0100100;
            4'd6: LED_out = 7'b0100000;
            4'd7: LED_out = 7'b0001111;
            4'd8: LED_out = 7'b0000000;
            4'd9: LED_out = 7'b0000100;
            default: LED_out = 7'b0000001;
        endcase
    end

endmodule
