module mem_counter ( input clock, input reset, output reg [7:0]count );

always @ ( posedge clock, negedge reset )
    begin
        if ( reset == 0 ) begin
            count <= 0;
        end else begin
            if ( count < 5) begin
                count <= count + 1;
            end else begin
                count = 0;
            end 
        end
    end
endmodule