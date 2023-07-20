module test_fsm;

  reg clk,reset,zero;
  reg npc_sel;
  wire [31:0]instr;
  wire [31:0] npc;
  wire [31:0]pc;
  wire [31:0] jr_in,jal_save;
  
  wire [5:0]opcode,funct;
  wire [4:0]rs,rt,rd;
  wire[25:0] imm26;
  
  wire [2:0]nPCsel;
  wire [1:0]regDst,extsel,writeData,ALUsel;
  wire ALUSrc,DMWr,overflow,GPRWr,PCWr,IRWr,slt_ctrl;
  
  pc p1(clk,PCWr,npc,reset,pc);
  npc npc1(pc,nPCsel,imm26,zero,jr_in,npc,jal_save);
  im_1k im1(pc[9:0],instr);
  ir ir1(clk,IRWr,instr,opcode,rs,rt,rd,imm26,funct);
  fsm f1(clk,reset,zero,opcode,funct,PCWr,IRWr,regDst,ALUSrc,writeData,GPRWr,DMWr,nPCsel,extsel,ALUsel,overflow,slt_ctrl);
  
  initial
  begin
    clk=1;reset=0;
    #5 reset=1;
    #5 reset=0;
    $readmemh("p2-test.txt",im1.im);
  end
  
  always
    #30 clk=~clk;
    
endmodule