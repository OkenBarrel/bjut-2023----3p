 module testall;
  reg clk,rst;
  
  mips m1(clk,rst);
  
  initial
  begin
    clk=1;rst=0;
    #5 ;//m1.g1.rst=1;
    rst=1;
    #5 ;//m1.g1.rst=0;
    rst=0;
    
    $readmemh("p2-test.txt",m1.im1.im);
  end
  
  always
    begin
    #30 clk=~clk;
    
    end
endmodule