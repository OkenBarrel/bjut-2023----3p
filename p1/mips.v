module mips(clk,rst);
  input clk,rst;
  wire [2:0]nPCsel;
  wire [1:0]regDst,extsel,writeData,ALUsel;
  wire [31:0] npc,instruct,pc,jal_save;
 // wire [26:0]imm;
  wire zero,less_than,ALUSrc,memWrite,overflow_ctrl,overflow_flag,regWrite,slt_ctrl,bge;
  //memtoReg
  wire [31:0]busA,busB;
  wire [31:0]ALUout;
  reg [4:0]addrinReg;
  reg [31:0]writeinReg;
  wire [4:0] rtin;
  wire [31:0] ALUBin;
  wire [31:0]dmout,extout;
  
  pc pc1(clk,npc,rst,pc);
  npc npc1(pc,nPCsel,instruct[25:0],zero,ALUout,npc,jal_save,~ALUout[31]&&bge);
  im_1k im1(pc[9:0],instruct);
  control c1(instruct[31:26],instruct[5:0],regDst,ALUSrc,writeData,regWrite,memWrite,nPCsel,extsel,ALUsel,overflow_ctrl,slt_ctrl,bge);
  always@(*)
  begin
    case(regDst)
      2'b00:addrinReg<=instruct[20:16];//rt
      2'b01:addrinReg<=instruct[15:11];//rd
      2'b10:addrinReg<=5'h1F;//$31
    endcase
    case(writeData)
      2'b00:writeinReg<=ALUout;
      2'b01:writeinReg<=dmout;
      2'b10:writeinReg<=jal_save;
      2'b11:writeinReg<={{31{1'b0}},less_than};//slt ??zero?????
    endcase
  end 
  assign ALUBin=(ALUSrc==1'b0)?busB:extout;
  assign rtin=(bge)?5'b00000:instruct[20:16];
  GPR g1(.GPRWr((regWrite&&~bge)||(bge&&~ALUout[31])),.clk(clk),.rr1(instruct[25:21]),.rr2(rtin),.wr(addrinReg),
      .wd(writeinReg),.readData1(busA),.readData2(busB),.alu_overflow(overflow_flag&&overflow_ctrl),.slt_ctrl(slt_ctrl&&less_than));
      
  ext e1(extsel,instruct[15:0],extout);
  alu a1(busA,ALUBin,ALUsel,ALUout,zero,overflow_flag,less_than);
  dm_1k d1(ALUout[9:0],busB,memWrite,clk,dmout);
  
endmodule