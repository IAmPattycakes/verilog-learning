module fpga_top (
    input clk;
    output servo;
);
    always @ (posedge clk) begin
        
    end
endmodule

module servo_driver #(parameter CLK_HZ = 16000000, SERVO_HZ = 50) (
    input clk,
    input dir,
    input step,
    output wire signal
);
    localparam degreemulti = ;
    reg [$clog2(CLK_HZ/SERVO_HZ)-1:0] cycle_timer;
    reg [$clog2((CLK_HZ/SERVO_HZ)/10):0] pulse_timer;
    always @ (posedge clk) begin
        cycle_timer = cycle_timer - 1;
        
    end

endmodule
