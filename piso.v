module invert (input wire i, output wire o);
   assign o = !i;
endmodule

module and2 (input wire i0, i1, output wire o);
  assign o = i0 & i1;
endmodule

module or2 (input wire i0, i1, output wire o);
  assign o = i0 | i1;
endmodule

module df (input wire clk, in, output wire out);
  reg df_out;
  always@(posedge clk) df_out <= in;
  assign out = df_out;
endmodule

module dfr (input wire clk, reset, in, output wire out);
  wire reset_, df_in;
  invert invert_0 (reset, reset_);
  and2 and2_0 (in, reset_, df_in);
  df df_0 (clk, df_in, out);
endmodule

module piso_slice (input wire prev, new, control, control_bar, clk, clear, output wire data);
    wire and_output[0:1];
    wire or_output;

    and2 and_1(prev, control, and_output[0]);
    and2 and_2(new, control_bar, and_output[1]);
    or2 or_1(and_output[0], and_output[1], or_output);

    dfr dfr_1(clk, clear, or_output, data);
endmodule

module piso (input wire control, clk, clear, input wire [0:3] data_in, output wire data_out);
    wire control_bar, dfr1_out;
    wire piso_slice_out[0:1];

    invert invert_1(control, control_bar);

    dfr dfr1(clk, clear, data_in[0], dfr1_out);
    piso_slice piso_slice1(dfr1_out, data_in[1], control, control_bar, clk, clear, piso_slice_out[0]);
    piso_slice piso_slice2(piso_slice_out[0], data_in[2], control, control_bar, clk, clear, piso_slice_out[1]);
    piso_slice piso_slice3(piso_slice_out[1], data_in[3], control, control_bar, clk, clear, data_out);
endmodule;