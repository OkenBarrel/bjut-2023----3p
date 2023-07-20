`define DEBUG
module testall;
  reg clk,rst;
  
  mips m1(clk,rst);
  
  initial
  begin
    clk=1;rst=0;
    #5 rst=1;
    #5 rst=0;
    
    $readmemh("p1-test.txt",m1.im1.im);
  end
  
  always
    begin
    #30 clk=~clk;
    `ifdef DEBUG
  $display("R[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,%8X", 0, m1.g1.regs[1], m1.g1.regs[2], m1.g1.regs[3], m1.g1.regs[4], m1.g1.regs[5],m1.g1.regs[6], m1.g1.regs[7]);
  $display("R[08-15]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,%8X", m1.g1.regs[8], m1.g1.regs[9], m1.g1.regs[10], m1.g1.regs[11], m1.g1.regs[12],m1.g1.regs[13], m1.g1.regs[14], m1.g1.regs[15]);
  $display("R[16-23]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,%8X", m1.g1.regs[16], m1.g1.regs[17], m1.g1.regs[18], m1.g1.regs[19], m1.g1.regs[20],m1.g1.regs[21], m1.g1.regs[22], m1.g1.regs[23]);
  $display("R[24-31]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,%8X", m1.g1.regs[24], m1.g1.regs[25], m1.g1.regs[26], m1.g1.regs[27], m1.g1.regs[28],m1.g1.regs[29], m1.g1.regs[30], m1.g1.regs[31]);
  $display(" "); 
`endif

    //$display({m1.d1.dm[4+3],m1.d1.dm[4+2],m1.d1.dm[4+1],m1.d1.dm[4+0]}); 
    end
endmodule