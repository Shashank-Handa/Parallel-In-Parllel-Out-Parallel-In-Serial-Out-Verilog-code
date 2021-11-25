`timescale 1 ns/1 ns

module piso_tb;
    reg clk;
    reg shift = 0;
    reg[0:3] in;
    reg clear;
    wire out;

    piso p_0(.control(shift), .clk(clk), .clear(clear), .data_in(in), .data_out(out));
    
    initial begin
        clk=0;
        forever #5 clk=~clk;
    end

    initial begin
        clear=1'b1;
        #6clear=1'b0;
    end

    initial begin
        shift=1'b0;
        #5 in=4'b1110;
        #10 shift=1'b1; 
        #39 shift=1'b0;
        #1 in=4'b0110;
        #5 shift=1'b1;
        #44 shift=1'b0;
        in=4'b1111;
        #2 shift=1'b1;
        #40 $finish;
    end
    initial begin
        $dumpfile("pisodmp.vcd");
        $dumpvars(0,piso_tb); 

    end
endmodule