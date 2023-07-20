module ir(clk,IRWr,in,opcode,rs,rt,rd,imm26,funct);
  input [31:0]in;
  input clk,IRWr;
  
  output [25:0] imm26;
  output [4:0] rs,rt,rd;
  output[5:0] opcode,funct;
  
  reg [31:0] ir;
  
  always@(posedge clk)
  begin
    if(IRWr)
      ir<=in;
    else
      ir<=ir;
  end
  
  assign opcode=ir[31:26];
  assign rs=ir[25:21];
  assign rt=ir[20:16];
  assign rd=ir[15:11];
  assign imm26=ir[25:0];
  assign funct=ir[5:0];
endmodule
