module mips(clk,rst);
  input clk,rst;
  wire [2:0]nPCsel;
  wire [1:0]regDst,extsel,writeData,ALUsel,dmsel;
  wire [31:0] npc,instruct,pc,jal_save;
  wire [5:0] opcode,funct;
  wire [4:0] rs,rt,rd;
  wire [25:0]imm26;
  wire zero,less_than,ALUSrc,DMWr,overflow_flag,GPRWr,slt_ctrl;
  wire PCWr,IRWr;
  //memtoReg
  wire [31:0]busA,busB;
  wire [31:0]ALUout;
  reg [4:0]addrinReg;
  reg [31:0]writeinReg;
  wire [31:0] ALUBin;
  wire [31:0]dmout,extout,dmin_seled,dmout_seled;
  
  wire [31:0] Areg_out,Breg_out,ALUreg_out,dmreg_out;
  
  pc pc1(clk,PCWr,npc,rst,pc);
  npc npc1(pc,nPCsel,imm26,zero,ALUout,npc,jal_save);
  
  im_1k im1(pc[9:0],instruct);
  ir ir1(clk,IRWr,instruct,opcode,rs,rt,rd,imm26,funct);
  
  fsm f1(clk,reset,zero,opcode,funct,PCWr,IRWr,regDst,ALUSrc,writeData,GPRWr,DMWr,nPCsel,extsel,ALUsel,overflow,slt_ctrl,dmsel);
  
  always@(*)
  begin
    case(regDst)
      2'b00:addrinReg<=rt;
      2'b01:addrinReg<=rd;
      2'b10:addrinReg<=5'h1F;//$31
    endcase
    case(writeData)
      2'b00:writeinReg<=ALUreg_out;
      2'b01:writeinReg<=dmreg_out;
      2'b10:writeinReg<=jal_save;
      2'b11:writeinReg<={{31{1'b0}},less_than};//slt ??zero?????
    endcase
  end 
  
  
  GPR g1(.GPRWr(GPRWr),.clk(clk),.rr1(rs),.rr2(rt),.wr(addrinReg),
      .wd(writeinReg),.readData1(busA),.readData2(busB),.alu_overflow(overflow&&overflow_flag),.slt_flag(slt_ctrl));//overflow_flag&&overflow_ctrl
  a aa(clk,busA,Areg_out);
  a bb(clk,busB,Breg_out);
  
  assign ALUBin=(ALUSrc==1'b0)?Breg_out:extout;
  
  ext e1(extsel,imm26[15:0],extout);
  
  alu a1(Areg_out,ALUBin,ALUsel,ALUout,zero,overflow_flag,less_than);
  a ALU_out(clk,ALUout,ALUreg_out);
  
  assign dmin_seled=(dmsel==2'b10)?{dmout[31:8],Breg_out[7:0]}:
                    (dmsel==2'b01)?{{24{1'b0}},Breg_out[7:0]}:Breg_out;
  dm_1k d1(ALUreg_out[9:0],dmin_seled,DMWr,clk,dmout);
  assign dmout_seled=(dmsel==2'b01)?{{24{dmout[7]}},dmout[7:0]}:dmout;
  a dr(clk,dmout_seled,dmreg_out);
endmodule