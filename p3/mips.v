module mips(clk,rst,PrDin,HWint,Praddr,WEcpu,PrDout);
  input clk,rst;
  //p3
  input [31:0] PrDin;
  input [7:2] HWint;
  output [31:0] PrDout;
  output [31:2] Praddr;
  output WEcpu;
  wire [31:2] epc;
  wire [3:0] cpu0sel;
  
  wire [31:0] cpu0_out;
  wire exlset,exlclr,IntReq,epcWr;
  //p2
  wire [2:0]nPCsel,writeData;
  wire [1:0]regDst,extsel,ALUsel,dmsel;
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
  
  assign Praddr=ALUreg_out[31:2];
  assign PrDout=Breg_out;
  assign WEcpu=(({Praddr,2'b00}>=32'h00007f00&&{Praddr,2'b00}<=32'h00008100)&&opcode==6'b101011&&DMWr==1)?1:0;

  
  
  pc pc1(clk,PCWr,npc,rst,pc);
  npc npc1(pc,nPCsel,{epc,2'b00},imm26,zero,ALUout,npc,jal_save);
  
  im_1k im1({pc[12:0]-13'b1000000000000},instruct);
  ir ir1(clk,IRWr,instruct,opcode,rs,rt,rd,imm26,funct);
  
  fsm f1(clk,reset,zero,IntReq,opcode,funct,rs,rd,PCWr,IRWr,regDst,ALUSrc,writeData,GPRWr,DMWr,nPCsel,extsel,
          ALUsel,overflow,slt_ctrl,dmsel,wen,exlset,exlclr,epcWr,cpu0sel);
  
  cp0 c1(pc[31:2],Breg_out,HWint,cpu0sel,wen,epcWr,exlset,exlclr,clk,rst,IntReq,epc,cpu0_out);
  
  always@(*)
  begin
    case(regDst)
      2'b00:addrinReg<=rt;
      2'b01:addrinReg<=rd;
      2'b10:addrinReg<=5'h1F;//$31
    endcase
    case(writeData)
      3'b000:writeinReg<=ALUreg_out;
      3'b001:writeinReg<=dmreg_out;
      3'b010:writeinReg<=jal_save;
      3'b011:writeinReg<={{31{1'b0}},less_than};//slt ??zero?????
      3'b100:writeinReg<=cpu0_out;
    endcase
    if(writeData&&ALUreg_out>=32'h00002fff)writeinReg<=PrDin;
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
  dm_1k d1(ALUreg_out[13:0],dmin_seled,(DMWr&&ALUreg_out<=32'h00002fff),clk,dmout);
  assign dmout_seled=(dmsel==2'b01)?{{24{dmout[7]}},dmout[7:0]}:dmout;
  a dr(clk,dmout_seled,dmreg_out);
endmodule