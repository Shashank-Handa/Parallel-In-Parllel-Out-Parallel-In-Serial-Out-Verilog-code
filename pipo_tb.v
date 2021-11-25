`timescale 1 ns / 100 ps

module pipo_tb;
reg clk;
reg [3:0]d;
wire [3:0]q;
reg rst;
pipo p_0(.data(d),.reset(rst),.clk(clk),.out(q));

initial 
begin
  clk=1'b0;
  forever #5 clk=~clk;
end

initial begin
  rst=1'b1;
  #12 rst=1'b0;
end

initial
begin
    #10 d=4'b0000;
    #10 d=4'b0001;
    #10 d=4'b0011;
    #10 d=4'b0111;
    #10 d=4'b0110;
    #10 d=4'b1010;
    #400 $finish;
end

initial 
begin 
  $dumpfile("pipodmp.vcd");
  $dumpvars(0,pipo_tb); 
end

endmodule



