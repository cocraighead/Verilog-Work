module top ( input ADC_CLK_10, input [9:0]SW, input [1:0]KEY, output reg [9:0]LEDR, output reg [7:0]HEX5, output reg [7:0]HEX4, output reg [7:0]HEX3, output reg [7:0]HEX2, output reg [7:0]HEX1, output reg [7:0]HEX0 );

wire [7:0]HEX5_man;
wire [7:0]HEX4_man;
wire [7:0]HEX3_man;
wire [7:0]HEX2_man;
wire [7:0]HEX1_man;
wire [7:0]HEX0_man;
wire [9:0]LEDR_man;

wire [7:0]HEX5_auto;
wire [7:0]HEX4_auto;
wire [7:0]HEX3_auto;
wire [7:0]HEX2_auto;
wire [7:0]HEX1_auto;
wire [7:0]HEX0_auto;
wire [9:0]LEDR_auto;

wire mem_clock;

wire [9:0]all_switches;

wire [7:0]address_counter;
wire [7:0]address_value;

clock_divider #(.divide_by(20000000)) U20 (.clock_in(ADC_CLK_10), .reset_n(KEY[0]), .clock_out(mem_clock));

mem_counter U21 (.clock(mem_clock), .reset(KEY[0]), .count(address_counter[7:0]));

MK9	MK9_inst (.address(address_counter[2:0]), .clock(mem_clock), .q(address_value[7:0]));

car U22 ( .ADC_CLK_10(ADC_CLK_10), .SW({7'b0000000, address_value[2:0]}), .KEY({address_value[3],address_value[4]}), .LEDR(LEDR_auto[9:0]), .HEX5(HEX5_auto[7:0]), .HEX4(HEX4_auto[7:0]), .HEX3(HEX3_auto[7:0]), .HEX2(HEX2_auto[7:0]), .HEX1(HEX1_auto[7:0]), .HEX0(HEX0_auto[7:0]));

car U23 ( .ADC_CLK_10(ADC_CLK_10), .SW(SW[9:0]), .KEY(KEY[1:0]), .LEDR(LEDR_man[9:0]), .HEX5(HEX5_man[7:0]), .HEX4(HEX4_man[7:0]), .HEX3(HEX3_man[7:0]), .HEX2(HEX2_man[7:0]), .HEX1(HEX1_man[7:0]), .HEX0(HEX0_man[7:0]));


always @ (SW[9],HEX5_man,HEX4_man,HEX3_man,HEX2_man,HEX1_man,HEX0_man,LEDR_man,HEX5_auto,HEX4_auto,HEX3_auto,HEX2_auto,HEX1_auto,HEX0_auto,LEDR_auto) begin
    if ( SW[9] == 1) begin
        HEX5 = HEX5_auto;
        HEX4 = HEX4_auto;
        HEX3 = HEX3_auto;
        HEX2 = HEX2_auto;
        HEX1 = HEX1_auto;
        HEX0 = HEX0_auto;
        LEDR = LEDR_auto;
    end else begin
        HEX5 = HEX5_man;
        HEX4 = HEX4_man;
        HEX3 = HEX3_man;
        HEX2 = HEX2_man;
        HEX1 = HEX1_man;
        HEX0 = HEX0_man;
        LEDR = LEDR_man;
    end
end

endmodule