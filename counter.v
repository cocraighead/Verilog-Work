module counter ( input clock, input reset, input reset_hold, output reg [1:0]count );

always @ ( posedge clock, negedge reset )
    begin
        if ( reset == 0 ) begin
            count <= 0;
        end else if ( reset_hold == 1 ) begin
            count <= 3;
        end else begin
            count <= count + 1;
        end
    end
endmodule