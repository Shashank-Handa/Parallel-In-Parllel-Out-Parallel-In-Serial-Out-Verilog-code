module invert (input wire i, output wire o);
   assign o = !i;
endmodule

module and2 (input wire i0, i1, output wire o);	
  assign o = i0 & i1;
endmodule

module df (input wire clk, in, output wire out);
  reg df_out;
  always@(posedge clk) df_out <= in;
  assign out = df_out;
endmodule

module dfr (input wire in, reset, clk, output wire out);
  wire reset_, df_in;
  invert invert_0 (reset, reset_);
  and2 and2_0 (in, reset_, df_in);
  df df_0 (clk, df_in, out);
endmodule

module pipo(input wire [3:0]data,input wire reset,clk,output wire [3:0]out);

	dfr d0(data[0],reset,clk,out[0]);

	dfr d1(data[1],reset,clk,out[1]);

	dfr d2(data[2],reset,clk,out[2]);

	dfr d3(data[3],reset,clk,out[3]);

endmodule
// module pipo ( data ,reset ,clk ,dout );
// output [3:0] dout ;
// reg [3:0] dout ;
// input [3:0] data ;
// wire [3:0] data ;
// input clk ;
// wire clk ;
// input reset ;
// wire reset ;
// always @ (posedge (clk)) begin
// if (reset)
// dout <= 0;
// else
// dout <= data;
// end
// endmodule

// module pipo(clk, d, q);
// input clk;
// input [3:0]d;
// output reg [3:0]q;
// always @(posedge clk)
// begin
// 	q[3]<=d[3];
// 	q[2]<=d[2];
// 	q[1]<=d[1];
// 	q[0]<=d[0];	
// end
// endmodule