module dm_1k(addr,din,we,clk,dout);
  input [13:0] addr;
  input [31:0] din;
  input we;
  input clk;
  output [31:0]dout;
  reg[7:0] dm[12287:0];
  
  assign dout={dm[addr+3],dm[addr+2],dm[addr+1],dm[addr+0]};
  always@(posedge clk)
  begin
    if(we)
      {dm[addr+3],dm[addr+2],dm[addr+1],dm[addr+0]}<=din;
  end
  
  integer i=0;
  initial
  begin
    #5;
    for(i=0;i<12288;i=i+1)
      dm[i]<=32'h00000000;
    #5;
  end
endmodule