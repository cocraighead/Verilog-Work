module csl ( input clock, input reset, input [2:0]next_state, output reg [2:0]current_state );

parameter IDEL  = 3'b000;
parameter LEFT  = 3'b001;
parameter RIGHT  = 3'b010;
parameter LBREAK  = 3'b011;
parameter RBREAK  = 3'b100;
parameter BREAK  = 3'b101;
parameter HAZARD  = 3'b110;

always @ ( posedge clock, negedge reset )
    begin
        if ( reset == 0 ) begin
            current_state <= IDEL;
        end else begin
            current_state <= next_state;
        end
    end
endmodule