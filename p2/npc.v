module npc(pc,npc_sel,imm,zero,jr_in,npc,jal_save);
  input zero;
  input [2:0]npc_sel;
  input [25:0] imm;
  input [31:0] pc,jr_in;
  output [31:0] npc;
  output [31:0] jal_save;
  wire [31:0] pcnew,t1,t0,extout;
  wire [31:0]temp;
  reg [31:0]stay;
  
  assign temp=(npc_sel==3'b001)?{{16{imm[15]}},imm[15:0]}://beq
              (npc_sel==3'b010)?{pc[31:28],imm,2'b00}://jal
              (npc_sel==3'b011)?{pc[31:28],imm,2'b00}://j
              (npc_sel==3'b100)?jr_in:32'h00000000;//jr
  
  assign extout=temp<<2;
  assign t0=pc+4;
  assign t1=pc+extout;
  assign jal_save=pc;
  assign npc=(npc_sel==3'b001&&zero)?t1:
              (npc_sel!=3'b000&&npc_sel!=3'b001)?temp:t0;
endmodule