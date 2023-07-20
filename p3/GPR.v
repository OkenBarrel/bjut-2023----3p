`define DEBUG
module GPR(GPRWr,clk,rr1,rr2,wr,wd,readData1,readData2,alu_overflow,slt_flag);
  input [4:0]rr1,rr2,wr;
  input  [31:0]wd;
  input GPRWr,clk,alu_overflow,slt_flag;
  reg rst;
  output [31:0]readData1,readData2;
  
  reg [31:0]regs[31:0];
  integer i=0;
  initial
  begin
    #5;
    for(i=0;i<1024;i=i+1)
      regs[i]<=32'h00000000;
    #5;
  end
  
  assign readData1=regs[rr1+0];
  assign readData2=regs[rr2+0];
        
  always@(posedge clk)
  begin
    if(GPRWr&&wr!=5'b00000)
      begin
      regs[wr+0]<=wd;
      `ifdef DEBUG
          $display("R[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,%8X", 0, regs[1], regs[2], regs[3], regs[4], regs[5],regs[6], regs[7]);
          $display("R[08-15]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,%8X", regs[8], regs[9], regs[10], regs[11], regs[12],regs[13], regs[14], regs[15]);
          $display("R[16-23]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,%8X", regs[16], regs[17], regs[18], regs[19], regs[20],regs[21], regs[22], regs[23]);
          $display("R[24-31]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,%8X", regs[24], regs[25], regs[26], regs[27], regs[28],regs[29], regs[30], regs[31]);
      `endif

    end
    else
      regs[wr+0]<=regs[wr+0];
    if(alu_overflow&&GPRWr)
      begin
      regs[30][0]<=1;
      `ifdef DEBUG
          $display("R[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,%8X", 0, regs[1], regs[2], regs[3], regs[4], regs[5],regs[6], regs[7]);
          $display("R[08-15]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,%8X", regs[8], regs[9], regs[10], regs[11], regs[12],regs[13], regs[14], regs[15]);
          $display("R[16-23]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,%8X", regs[16], regs[17], regs[18], regs[19], regs[20],regs[21], regs[22], regs[23]);
          $display("R[24-31]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,%8X", regs[24], regs[25], regs[26], regs[27], regs[28],regs[29], regs[30], regs[31]);
      `endif
      end
    if(GPRWr&&slt_flag)
      begin
      regs[wr+0]<=regs[wr+0]||wd;
      `ifdef DEBUG
          $display("R[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,%8X", 0, regs[1], regs[2], regs[3], regs[4], regs[5],regs[6], regs[7]);
          $display("R[08-15]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,%8X", regs[8], regs[9], regs[10], regs[11], regs[12],regs[13], regs[14], regs[15]);
          $display("R[16-23]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,%8X", regs[16], regs[17], regs[18], regs[19], regs[20],regs[21], regs[22], regs[23]);
          $display("R[24-31]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,%8X", regs[24], regs[25], regs[26], regs[27], regs[28],regs[29], regs[30], regs[31]);
      `endif
      end
  end
endmodule