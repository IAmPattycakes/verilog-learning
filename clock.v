module fpga_top (
    input      clk,
    input[5:0] time_set,
    input      hour_set,
    input      minute_set,
    input      clock_on,
	input      reset,
	output reg [16:0] leds
);
	under_seconds(.clk(clk), .on(clock_on))	
endmodule


module t_flipflop (
    input clk,
    input rstn,
    input t,
    output reg q
);
	always @ (posedge clk) begin
		if(!rstn)
			q <= 0;
		else begin
			if (t)
				q <= ~q;
			else 
				q <= q;
		end
	end 
endmodule

module under_seconds (
	input clk,
	input rstn,
	input on,
	output wire second_clk
);
	wire [14:0] feedback;
	t_flipflop(.clk(clk), .rstn(rstn), .t(on), .q(feedback[0]));
	t_flipflop(.clk(feedback[0]), .rstn(rstn), .t(on), .q(feedback[1]));
	t_flipflop(.clk(feedback[1]), .rstn(rstn), .t(on), .q(feedback[2]));
	t_flipflop(.clk(feedback[2]), .rstn(rstn), .t(on), .q(feedback[3]));
	t_flipflop(.clk(feedback[3]), .rstn(rstn), .t(on), .q(feedback[4]));
	t_flipflop(.clk(feedback[4]), .rstn(rstn), .t(on), .q(feedback[5]));
	t_flipflop(.clk(feedback[5]), .rstn(rstn), .t(on), .q(feedback[6]));
	t_flipflop(.clk(feedback[6]), .rstn(rstn), .t(on), .q(feedback[7]));
	t_flipflop(.clk(feedback[7]), .rstn(rstn), .t(on), .q(feedback[8]));
	t_flipflop(.clk(feedback[8]), .rstn(rstn), .t(on), .q(feedback[9]));
	t_flipflop(.clk(feedback[9]), .rstn(rstn), .t(on), .q(feedback[10]));
	t_flipflop(.clk(feedback[10]), .rstn(rstn), .t(on), .q(feedback[11]));
	t_flipflop(.clk(feedback[11]), .rstn(rstn), .t(on), .q(feedback[12]));
	t_flipflop(.clk(feedback[12]), .rstn(rstn), .t(on), .q(feedback[13]));
	t_flipflop(.clk(feedback[13]), .rstn(rstn), .t(on), .q(feedback[14]));
	t_flipflop(.clk(feedback[14]), .rstn(rstn), .t(on), .q(second_clk));
endmodule

module flipflop_6wide (
	input clk,
	input rstn,
	input [5:0] timeset,
	input setting,
	output wire [5:0] q
);
	wire [5:0] feedback;
	t_flipflop(.clk(clk), .rstn(rstn), .t(1), .q(feedback[0]));
	t_flipflop(.clk(q[0]), .rstn(rstn), .t(1), .q(feedback[1]));
	t_flipflop(.clk(q[1]), .rstn(rstn), .t(1), .q(feedback[2]));
	t_flipflop(.clk(q[2]), .rstn(rstn), .t(1), .q(feedback[3]));
	t_flipflop(.clk(q[3]), .rstn(rstn), .t(1), .q(feedback[4]));
	t_flipflop(.clk(q[4]), .rstn(rstn), .t(1), .q(feedback[5]));
	assign q = setting ? timeset : feedback;
endmodule

module flipflop_5wide (
	input clk,
	input rstn,
	input [5:0] timeset,
	input setting,
	output wire [4:0] q
);
	wire [4:0] feedback;
	t_flipflop(.clk(clk), .rstn(rstn), .t(1), .q(feedback[0]));
	t_flipflop(.clk(q[0]), .rstn(rstn), .t(1), .q(feedback[1]));
	t_flipflop(.clk(q[1]), .rstn(rstn), .t(1), .q(feedback[2]));
	t_flipflop(.clk(q[2]), .rstn(rstn), .t(1), .q(feedback[3]));
	t_flipflop(.clk(q[3]), .rstn(rstn), .t(1), .q(feedback[4]));
	assign q = setting ? timeset : feedback;
endmodule
