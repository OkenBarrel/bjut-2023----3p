module a(clk,in,out);
  input clk;
  input [31:0]in,out;
  reg[31:0] aa;
  
  always@(posedge clk)
  begin
    aa<=in;
  end
  
  assign out=aa;
endmodule
