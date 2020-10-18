module nsl ( input [2:0]current_state, input [9:0]SW, input [1:0]KEY, output reg [2:0]next_state, output reg reset_count_rb, output reg reset_count_lb, output reg reset_count_h );

parameter IDEL  = 3'b000;
parameter LEFT  = 3'b001;
parameter RIGHT  = 3'b010;
parameter LBREAK  = 3'b011;
parameter RBREAK  = 3'b100;
parameter BREAK  = 3'b101;
parameter HAZARD  = 3'b110;

always @ ( current_state, SW, KEY )
    begin
        if ( KEY[0] == 0) begin
            next_state = IDEL;
        end else if( SW[0] == 1 ) begin
            next_state = HAZARD;
        end else if( SW[1] == 1 ) begin
            if ( SW[2] == 1 ) begin
                if ( KEY[1] == 0 ) begin 
                    next_state = RBREAK;
                end else begin
                    next_state = LBREAK;
                end
            end else begin
                if ( KEY[1] == 0 ) begin 
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end
        end else if( SW[2] == 1) begin
            next_state = BREAK;
        end else begin 
            next_state = IDEL;
        end

        if(next_state == RIGHT || next_state == RBREAK ) begin
            reset_count_rb = 0;
        end else begin
            reset_count_rb = 1;
        end
        if(next_state == LEFT || next_state == LBREAK ) begin
            reset_count_lb = 0;
        end else begin
            reset_count_lb = 1;
        end
        if(next_state == HAZARD ) begin
            reset_count_h = 0;
        end else begin
            reset_count_h = 1;
        end
    end
endmodule