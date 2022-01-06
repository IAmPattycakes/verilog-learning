module fpga_top (
    input clk, 
    input [5:0] settime,
    input setampm,
    input sethour,
    input setminute,
    input clockon,
    input reset,
    output reg [16:0] leds
);
    reg [31:0] dur;
    initial begin
        dur = 0;
    end
    always @ (posedge clk) begin
        if(clockon) begin
            dur = dur + 1; 
        end
        fork //This will lead to the second disappearing before the minute counts up, but that'd only be visible for 1/32768th of a second, so that's fine. 
            if(dur[20:15] == 60) begin
                dur[21] = ~dur[21];
                dur[20:15] = 0;
            end
            if(dur[26:21] == 60 && !setminute) begin
                dur[27] = ~dur[27];
                dur[26:21] = 0;
            end
            if(dur[30:27] == 12 && !sethour) begin
                dur[31] = ~dur[31];
                dur[30:27] = 0;
            end
            if(setminute) begin
                dur[26:21] = settime;
            end
            if(sethour) begin
                dur[30:27] = settime[3:0];
            end
            if(setampm) begin
                dur[31] = settime[0];
            end
        join
        leds = dur[31:15];
    end
endmodule
