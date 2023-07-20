module test;
  reg clk,reset,zero;
  reg npc_sel;
  wire [31:0]instr;
  wire [31:0] npc;
  wire [31:0]pc;
  wire [31:0] jr_in,jal_save;
  
  reg [5:0]opcode;
  reg [5:0]funct;
  wire [2:0]nPCsel;
  wire [1:0]regDst,extsel,writeData,ALUsel;
  wire ALUSrc,memWrite,overflow,regWrite;
  
  reg [9:0]addr;
  reg [31:0]din;
  reg we;
  wire [31:0]dout;
  dm_1k d(addr,din,we,clk,dout);
  /*pc p1(clk,npc,reset,pc);
  npc npc1(pc,nPCsel,instr[25:0],zero,jr_in,npc,jal_save);
  im_1k im1(pc[9:0],instr);
  control c1(instr[31:26],instr[5:0],regDst,ALUSrc,writeData,regWrite,memWrite,nPCsel,extsel,ALUsel,overflow);*/
  initial
  begin
    clk=1;//reset=0;
    #5 ;//reset=1;
    addr=10'b0000000001;
    we=1;
    din=32'h00000100;
    #5 ;//reset=0;
    addr=10'b0000000001;
    we=1;
    
    //$readmemh("p1-test.txt",im1.im);
  end
  
  always
    #30 clk=~clk;
    
  endmodule