module fsm(clk,rst,zero,IntReq,opcode,funct,mf,rd,PCWr,IRWr,regDst,ALUSrc,writeData,GPRWr,DMWr,nPCsel,extsel,ALUsel,overflow,slt_ctrl,dmsel,cpu0_wen,exlset,exlclr,epcWr,cpu0sel);
  input clk,rst,zero,IntReq;
  input [5:0]opcode,funct;
  input [4:0]mf,rd;
  wire addi,addiu,slt,jal,jr,addu,subu,ori,lw,sw,beq,lui,j,lb,sb,mfc0,mtc0,eret;
  wire f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10;
  output PCWr,IRWr,GPRWr,ALUSrc,slt_ctrl,DMWr,overflow;
  output [1:0] ALUsel,regDst,extsel,dmsel;
  output [2:0] nPCsel,writeData;
  output [3:0]cpu0sel;
  
  output cpu0_wen,exlset,exlclr,epcWr;
    
  parameter s0=4'b0000;
  parameter s1=4'b0001;
  parameter s2=4'b0010;
  parameter s3=4'b0011;
  parameter s4=4'b0100;
  parameter s5=4'b0101;
  parameter s6=4'b0110;
  parameter s7=4'b0111;
  parameter s8=4'b1000;
  parameter s9=4'b1001;
  parameter s10=4'b1010;
  parameter s11=4'b1011;
  
 // wire [3:0] next_state;
  reg [3:0] state;
  
  assign addi=~opcode[0]&&~opcode[1]&&~opcode[2]&&opcode[3]&&~opcode[4]&&~opcode[5];
  assign addiu=opcode[0]&&~opcode[1]&&~opcode[2]&&opcode[3]&&~opcode[4]&&~opcode[5];
  assign slt=~opcode[0]&&~opcode[1]&&~opcode[2]&&~opcode[3]&&~opcode[4]&&~opcode[5]&&~funct[0]&&funct[1]&&~funct[2]&&funct[3]&&~funct[4]&&funct[5];
  assign jal=opcode[0]&&opcode[1]&&~opcode[2]&&~opcode[3]&&~opcode[4]&&~opcode[5];
  assign jr=~opcode[0]&&~opcode[1]&&~opcode[2]&&~opcode[3]&&~opcode[4]&&~opcode[5]&&~funct[0]&&~funct[1]&&~funct[2]&&funct[3]&&~funct[4]&&~funct[5];
  assign addu=~opcode[0]&&~opcode[1]&&~opcode[2]&&~opcode[3]&&~opcode[4]&&~opcode[5]&&funct[0]&&~funct[1]&&~funct[2]&&~funct[3]&&~funct[4]&&funct[5];
  assign subu=~opcode[0]&&~opcode[1]&&~opcode[2]&&~opcode[3]&&~opcode[4]&&~opcode[5]&&funct[0]&&funct[1]&&~funct[2]&&~funct[3]&&~funct[4]&&funct[5];
  assign ori=opcode[0]&&~opcode[1]&&opcode[2]&&opcode[3]&&~opcode[4]&&~opcode[5];
  assign lw=opcode[0]&&opcode[1]&&~opcode[2]&&~opcode[3]&&~opcode[4]&&opcode[5];
  assign sw=opcode[0]&&opcode[1]&&~opcode[2]&&opcode[3]&&~opcode[4]&&opcode[5];
  assign beq=~opcode[0]&&~opcode[1]&&opcode[2]&&~opcode[3]&&~opcode[4]&&~opcode[5];
  assign lui=(opcode==6'b001111)?1:0;
  assign j=~opcode[0]&&opcode[1]&&~opcode[2]&&~opcode[3]&&~opcode[4]&&~opcode[5];
  assign lb=~opcode[0]&&~opcode[1]&&~opcode[2]&&~opcode[3]&&~opcode[4]&&opcode[5];
  assign sb=~opcode[0]&&~opcode[1]&&~opcode[2]&&opcode[3]&&~opcode[4]&&opcode[5];
  
  assign mfc0=(opcode==6'b010000)&&(mf==5'b00000);
  assign mtc0=(opcode==6'b010000)&&(mf==5'b00100);
  assign eret=(opcode==6'b010000)&&(funct==6'b011000);
  
  assign f0=~state[3]&~state[2]&~state[1]&~state[0];
  assign f1=~state[3]&~state[2]&~state[1]&state[0];
  assign f2=~state[3]&~state[2]&state[1]&~state[0];
  assign f3=~state[3]&~state[2]&state[1]&state[0];
  assign f4=~state[3]&state[2]&~state[1]&~state[0];
  assign f5=~state[3]&state[2]&~state[1]&state[0];
  assign f6=~state[3]&state[2]&state[1]&~state[0];
  assign f7=~state[3]&state[2]&state[1]&state[0];
  assign f8=state[3]&~state[2]&~state[1]&~state[0];
  assign f9=state[3]&~state[2]&~state[1]&state[0];
  assign f10=state[3]&~state[2]&state[1]&~state[0];
  assign f11=(state==4'b1011);
  
  always@(posedge clk,posedge rst)
  begin
    if(rst)
      state<=s0;
    else
      case(state)
        s0:                                                    //s0
        begin
          if(j&&IntReq)
            state<=s10;
          else
            state=s1;
        end
        s1:                                                    //s1
        begin
          if(lw||sw||lb||sb)
            state<=s2;
          else if(jal)
            state<=s9;
          else if(beq)
            state<=s8;
          else if(j)
            state<=s0;
          else if(mtc0||mfc0)
            state<=s11;
          else if(eret)
            state<=s10;
          else
            state<=s6;
            
        end
        s2:                                                    //s2
        begin
          if(lw||lb||sb)
            state<=s3;
          else  //sw
            state<=s5;
        end
        s3:                                                    //s3
        begin
          if(sb)
            state<=s5;
          else
            state<=s4;
        end
        s4:                                                    //s4
        begin
          if(IntReq)
            state<=s10;
          else
            state<=s0;
        end
        s5:                                                    //s5
        begin
          if(IntReq)
            state<=s10;
          else
            state<=s0;
        end
        s6:                                                    //s6
        begin
            state<=s7;
        end
        s7:                                                    //s7
        begin
          if(IntReq)
            state<=s10;
          else
            state<=s0;
        end
        s8:                                                    //s8
        begin
          if(IntReq)
            state<=s10;
          else
            state<=s0;
        end
        s9:                                                    //s9
        begin
          if(IntReq)
            state<=s10;
          else
            state<=s0;
        end
        s10:                                                    //s10
        begin
            state<=s0;
        end
        s11:
        begin
          if(mfc0)
            state<=s7;
          else
            state<=s0;
        end
        default:state<=s0;
      endcase
        
  end
  
  assign PCWr=f0||(j&&f1)||(jr&&f7)||(beq&&zero)&&f8||jal&&f9||f10;
  assign IRWr=f0;
  assign GPRWr=(lb||lw)&&f4||f7||jal&&f9;//?????????slt??
  assign ALUSrc=(ori||addi||addiu||lw||sw||lui||lb||sb)&&~f0;
  assign overflow=f7&&addi;
  assign DMWr=(sw||sb)&&f5;//???lb sb
  
  assign cpu0_wen=(f10&&IntReq||f11&&mtc0)?1:0;
  assign exlset=(f10&&IntReq)?1:0;//??????
  assign cpu0_sel=(~f0&&mtc0||~f0&&mfc0)?rd[3:0]:0;
  assign epcWr=(f10&&IntReq)?1:0;
  assign cpu0sel=(mtc0&&~f0||mfc0&&~f0)?rd[3:0]:4'b1110;
  assign exlclr=(eret&&f10)?1:0;
  
  assign dmsel=(lb&&~f0)?2'b01:
                (sb&&~f0)?2'b10:2'b00;
  assign nPCsel=(~f0&&beq)? 3'b001:
                (~f0&&jal)? 3'b010:
                (f1&&j)? 3'b011:
                (~f0&&jr)? 3'b100:
                (f10&&IntReq)?3'b101:
                (f10&&eret)?3'b110:
                3'b000;
  
  assign ALUsel=((subu||beq||slt)&~f0)? 2'b01:
                (ori&~f0)? 2'b10:2'b00;
  assign writeData=((lw||lb)&~f0)? 3'b001://dmout
                    (jal&~f0)? 3'b010://pc+4
                    (slt&~f0)? 3'b011:
                    (mfc0&~f0)? 3'b100:3'b000;//00aluout
  assign regDst=((addu||subu||slt)&~f0)? 2'b01://rd
                (jal&~f0)? 2'b10:2'b00;//00rt
  assign extsel=(ori&~f0)? 2'b00:
                (lui&~f0)? 2'b10:2'b01;
  
endmodule