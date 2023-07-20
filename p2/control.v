module control(opcode,funct,regDst,ALUSrc,writeData,regWrite,memWrite,nPCsel,extsel,ALUsel,overflow,slt_ctrl);
  input [5:0]opcode;
  input [5:0]funct;
  output [2:0]nPCsel;
  output [1:0]regDst,extsel,writeData,ALUsel;
  reg [2:0]nPCsel1;
  reg [1:0]regDst1,extsel1,writeData1,ALUsel1;
  output ALUSrc,memWrite,overflow,regWrite,slt_ctrl; 
  //memtoReg
  always@(*)
  begin
    if(opcode==6'b000011)//jal
      regDst1<=2'b10;
    else if(opcode==6'b000000)
      regDst1<=2'b01;
    else
      regDst1<=2'b00;
      
    if(opcode==6'b100011)
      writeData1<=2'b01;
    else if(opcode==6'b000011)
      writeData1<=2'b10;
    //else if(opcode==6'b000000&&funct==6'b101010)
      //writeData1<=2'b11;
    else
      writeData1<=2'b00;
      
    if(opcode==6'b000100)
      nPCsel1<=3'b001;
    else if(opcode==6'b000011)//jal
      nPCsel1<=3'b010;
    else if(opcode==6'b000010)//j
      nPCsel1<=3'b011;
    else if(opcode==6'b000000&&funct==6'b001000)
      nPCsel1<=3'b100;
    else
      nPCsel1<=3'b000;
      
    if(opcode==6'b001101)
      extsel1<=2'b00;
    else if(opcode==6'b001111)
      extsel1<=2'b10;
    else
      extsel1<=2'b01;
      
    if((opcode==6'b000000&&(funct==6'b100011||funct==6'b101010))||opcode==6'b000100)
      ALUsel1<=2'b01;
    else if(opcode==6'b001101)
      ALUsel1<=2'b10;
    else
      ALUsel1<=2'b00;

  end
   
 // assign memtoReg=(opcode==6'b100011)?1:0;  
  assign ALUSrc=(opcode==6'b000000||opcode==6'b000100||opcode==6'b000011)?0:1;    
  assign regWrite=(opcode==6'b101011||opcode==6'b000010||(opcode==6'b000000&&funct==6'b001000)||opcode==6'b000100)?0:1;   
  assign memWrite=(opcode==6'b101011)?1:0;
  assign overflow=(opcode==6'b001000)?1:0;
  assign slt_ctrl=(opcode==6'b000000&&funct==6'b101010)?1:0;
  assign regDst=regDst1;
  assign extsel=extsel1;
  assign nPCsel=nPCsel1;
  assign ALUsel=ALUsel1;
  assign writeData=writeData1;
endmodule