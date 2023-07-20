module out32(clk,in,we,out);
  input we,clk;
  input [31:0]in;
  output [31:0] out;
//input [1:0] sel;
  reg [31:0] out32;
  
  initial
  begin
  #5 out32<=32'h00000000;
  # 5;
  end
  
  always@(posedge clk)
    if(we)
      out32<=in;
  
  assign out=out32;
endmodule
