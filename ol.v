module ol ( input [1:0]count_rb, input [1:0]count_lb, input count_h, input [2:0]current_state, output reg [9:0]LEDR, output reg [7:0]HEX5, output reg [7:0]HEX4, output reg [7:0]HEX3, output reg [7:0]HEX2, output reg [7:0]HEX1, output reg [7:0]HEX0 );

parameter IDEL  = 3'b000;
parameter LEFT  = 3'b001;
parameter RIGHT  = 3'b010;
parameter LBREAK  = 3'b011;
parameter RBREAK  = 3'b100;
parameter BREAK  = 3'b101;
parameter HAZARD  = 3'b110;

always @ ( current_state, count_rb, count_lb, count_h )
    begin
        LEDR[6:3] = 4'b0000;
        HEX4[7:0] = 8'b1111_1111;
        HEX3[7:0] = 8'b1111_1111;
        HEX2[7:0] = 8'b1111_1111;
        HEX1[7:0] = 8'b1111_1111;
        HEX0[7:0] = 8'b1111_1111;
        if ( current_state == IDEL ) begin
            HEX5[7:0] = 8'b1100_0000;
            LEDR[9:7] = 3'b000;
            LEDR[2:0] = 3'b000;
        end else if(current_state == LEFT ) begin
            HEX5[7:0] = 8'b1111_1001;
            LEDR[2:0] = 3'b000;
            case(count_lb)
                0 : LEDR[9:7] = 3'b000;
                1 : LEDR[9:7] = 3'b001;
                2 : LEDR[9:7] = 3'b011;
                3 : LEDR[9:7] = 3'b111;
                default: 
                    LEDR[9:7] = 3'b000;
            endcase
        end else if(current_state == RIGHT ) begin
            HEX5[7:0] = 8'b1010_0100;
            LEDR[9:7] = 3'b000;
            case(count_rb)
                0 : LEDR[2:0] = 3'b000;
                1 : LEDR[2:0] = 3'b100;
                2 : LEDR[2:0] = 3'b110;
                3 : LEDR[2:0] = 3'b111;
                default: 
                    LEDR[2:0] = 3'b000;
            endcase
        end else if(current_state == LBREAK ) begin
            HEX5[7:0] = 8'b1011_0000;
            LEDR[2:0] = 3'b111;
            case(count_lb)
                0 : LEDR[9:7] = 3'b000;
                1 : LEDR[9:7] = 3'b001;
                2 : LEDR[9:7] = 3'b011;
                3 : LEDR[9:7] = 3'b111;
                default: 
                    LEDR[9:7] = 3'b000;
            endcase
        end else if(current_state == RBREAK ) begin
            HEX5[7:0] = 8'b1001_1001;
            LEDR[9:7] = 3'b111;
            case(count_rb)
                0 : LEDR[2:0] = 3'b000;
                1 : LEDR[2:0] = 3'b100;
                2 : LEDR[2:0] = 3'b110;
                3 : LEDR[2:0] = 3'b111;
                default: 
                    LEDR[2:0] = 3'b000;
            endcase
        end else if(current_state == BREAK ) begin
            HEX5[7:0] = 8'b1001_0010;
            LEDR[9:7] = 3'b111;
            LEDR[2:0] = 3'b111;
        end else if(current_state == HAZARD ) begin
            HEX5[7:0] = 8'b1000_0010;
            case(count_h)
                0 : begin
                    LEDR[9:7] = 3'b000;
                    LEDR[2:0] = 3'b000;
                    end
                1 : begin
                    LEDR[9:7] = 3'b111;
                    LEDR[2:0] = 3'b111;
                    end
                default: begin
                    LEDR[9:7] = 3'b000;
                    LEDR[2:0] = 3'b000;
                    end
            endcase
        end else begin
            HEX5[7:0] = 8'b1000_0110;
        end
    end
endmodule