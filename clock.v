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
	for (i = 0; i < 14; i = i + 1) begin
		t_flipflop(.clk(feedback[i]), .rstn(rstn), .t(on), .q(feedback[i+1]));
	end 
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

module flipflop_4wide (
	input clk,
	input rstn,
	input [3:0] timeset,
	input setting,
	output wire [3:0] q
);
	wire [3:0] feedback;
	t_flipflop(.clk(clk), .rstn(rstn), .t(1), .q(feedback[0]));
	t_flipflop(.clk(q[0]), .rstn(rstn), .t(1), .q(feedback[1]));
	t_flipflop(.clk(q[1]), .rstn(rstn), .t(1), .q(feedback[2]));
	t_flipflop(.clk(q[2]), .rstn(rstn), .t(1), .q(feedback[3]));
	assign q = setting ? timeset : feedback;
endmodule
