module bgetest;
  reg clk,rst;
  
  mips m1(clk,rst);
  
  initial
  begin
    clk=1;rst=0;
    #5 rst=1;
    #5 rst=0;
    
    $readmemh("bge.txt",m1.im1.im);
  end
  
  always
    begin
    #30 clk=~clk;
  end
endmodule