module fpga_top (
    input clk,
    input p1, 
    input p2,
    input btn,
    input rst,
    output reg [7:0] leds,
    output reg [7:0] btndowns,
    output reg [7:0] btnups
);
    wire [7:0] ledtmp;
    wire [7:0] downtmp;
    wire [7:0] uptmp;
    encoder jerry (.p1(p1), .p2(p2), .btn(btn), .rst(rst), .spin(ledtmp), .btndowns(downtmp), .btnups(uptmp));
    always @ * begin
        leds = ledtmp;
        btndowns = downtmp;
        btnups = uptmp;
    end
endmodule

module encoder (
    input p1, 
    input p2, 
    input btn, 
    input rst,
    output reg[7:0] spin,
    output reg[7:0] btndowns,
    output reg[7:0] btnups
);
    reg [1:0] prevstate;
    always @ * begin
        if (prevstate != {p1,p2}) begin
            case (prevstate)
                2'b00 : spin = spin + (2'b01 == {p1,p2}) ? 1 : -1;
                2'b01 : spin = spin + (2'b11 == {p1,p2}) ? 1 : -1;
                2'b11 : spin = spin + (2'b10 == {p1,p2}) ? 1 : -1;
                2'b10 : spin = spin + (2'b00 == {p1,p2}) ? 1 : -1;
            endcase
            prevstate = {p1,p2};
        end
    end
    reg prevbtn;
    always @ * begin
        if(btn != prevbtn) begin
            case (btn)
                1: btndowns = btndowns + 1;
                0: btnups = btnups + 1;
            endcase 
        end
    end
endmodule
