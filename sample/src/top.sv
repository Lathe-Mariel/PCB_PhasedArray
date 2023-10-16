module top(
input wire clk,
input wire sw,
output logic speaker1,
output logic led1
);

logic overflow;

//reg red=0;
//reg blue=0;
//reg green=0;
//reg printf;

timer1 timer_instance(clk, overflow);

assign led1 = speaker1;

always @(posedge overflow)begin
  if(sw)begin
    speaker1 <= ~speaker1;
  end
end

endmodule

module timer1 #(
  parameter COUNT_MAX = 13500
) (
  input  wire  clk,
  output logic overflow
);

  logic [$clog2(COUNT_MAX+1)-1:0] counter = 'd0;

  always_ff @ (posedge clk) begin
    if (counter == COUNT_MAX) begin
      counter  <= 'd0;
      overflow <= 'd1;
    end else begin
      counter  <= counter + 'd1;
      overflow <= 'd0;
    end
  end
endmodule

`default_nettype wire