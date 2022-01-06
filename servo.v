module fpga_top (
    input clk;
    output wire servo;
);
    
endmodule

module servo_driver #(parameter CLK_HZ = 16000000, SERVO_HZ = 50, SERVO_DEGREES = 180) (
    input clk,
    input dir,
    input step,
    output wire signal
);
    //minimum pulse is 1ms. Maximum pulse is 2ms. Full cycle is 20ms. 
    localparam PULSE_MIN = (CLK_HZ/SERVO_HZ)/20;
    localparam PULSE_MAX = (CLK_HZ/SERVO_HZ)/10;
    localparam PULSE_DEGREE_MULT = (PULSE_MIN-PULSE_MAX)/SERVO_DEGREES;
    localparam CYCLE_DURATION = CLK_HZ/SERVO_HZ;

    reg [$clog2(CYCLE_DURATION)-1:0] cycle_timer;
    reg [$clog2(PULSE_MAX):0] pulse_timer;
    reg [$clog2(SERVO_DEGREES):0] curr_angle; 
    always @ (posedge clk) begin
        cycle_timer = cycle_timer - 1;
        if(pulse_timer > 0)
            pulse_timer = pulse_timer = 1;
        if(cycle_timer == 0) begin
            cycle_timer = CYCLE_DURATION;
            pulse_timer = PULSE_MIN + (curr_angle*PULSE_DEGREE_MULT);
        end
    end

    assign signal = (pulse_timer > 0) ? 1 : 0;

endmodule
