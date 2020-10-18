module car ( input ADC_CLK_10, input [9:0]SW, input [1:0]KEY, output reg [9:0]LEDR, output reg [7:0]HEX5, output reg [7:0]HEX4, output reg [7:0]HEX3, output reg [7:0]HEX2, output reg [7:0]HEX1, output reg [7:0]HEX0 );

wire [2:0]qns_state;
wire [2:0]qcs_state;

wire slow_clock;

wire reset_blinker_right;
wire reset_blinker_left;
wire reset_hazard;

wire [1:0]count_blinker_right;
wire [1:0]count_blinker_left;
wire [1:0]count_hazards;

wire [7:0]HEX5_temp;
wire [7:0]HEX4_temp;
wire [7:0]HEX3_temp;
wire [7:0]HEX2_temp;
wire [7:0]HEX1_temp;
wire [7:0]HEX0_temp;
wire [9:0]LEDR_temp;

clock_divider #(.divide_by(2500000/*2*/)) U0 (.clock_in(ADC_CLK_10), .reset_n(KEY[0]), .clock_out(slow_clock));

counter U1 (.clock(slow_clock), .reset(KEY[0]), .reset_hold(reset_blinker_right), .count(count_blinker_right[1:0]));
counter U2 (.clock(slow_clock), .reset(KEY[0]), .reset_hold(reset_blinker_left), .count(count_blinker_left[1:0]));
counter U3 (.clock(slow_clock), .reset(KEY[0]), .reset_hold(reset_hazard), .count(count_hazards[1:0]));

nsl U4 (.current_state(qcs_state[2:0]), .SW(SW[9:0]), .KEY(KEY[1:0]), .next_state(qns_state[2:0]), .reset_count_rb(reset_blinker_right), .reset_count_lb(reset_blinker_left), .reset_count_h(reset_hazard) );

csl U5 (.clock(slow_clock), .reset(KEY[0]), .next_state(qns_state[2:0]), .current_state(qcs_state[2:0]));

ol U6 ( .count_rb(count_blinker_right[1:0]), .count_lb(count_blinker_left[1:0]), .count_h(count_hazards[0]), .current_state(qcs_state[2:0]), .LEDR(LEDR_temp[9:0]), .HEX5(HEX5_temp[7:0]), .HEX4(HEX4_temp[7:0]), .HEX3(HEX3_temp[7:0]), .HEX2(HEX2_temp[7:0]), .HEX1(HEX1_temp[7:0]), .HEX0(HEX0_temp[7:0]) );

always @ (HEX5_temp,HEX4_temp,HEX3_temp,HEX2_temp,HEX1_temp,HEX0_temp,LEDR_temp) begin
    HEX5 = HEX5_temp;
    HEX4 = HEX4_temp;
    HEX3 = HEX3_temp;
    HEX2 = HEX2_temp;
    HEX1 = HEX1_temp;
    HEX0 = HEX0_temp;
    LEDR = LEDR_temp;
end

endmodule