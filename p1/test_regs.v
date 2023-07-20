module test_regs;
  reg [4:0]rr1,rr2,wr;
  reg  [31:0]wd;
  reg less_thanflag;
  wire less_than;
  reg GPRWr,clk,rst;
  wire [31:0]readData1,readData2;
  //for alu
  wire [31:0] out;
  wire overflow_flag,zero;
  reg [1:0] sel;
  //for ext
  reg [2:0] ext_sel;
  reg[15:0] datain;
  wire [31:0]dataout;
  //ext e1(ext_sel,datain,dataout);
  GPR g1(GPRWr,clk,rr1,rr2,wr,wd,readData1,readData2,overflow_flag,less_thanflag);
  alu a1(readData1,dataout,sel,out,zero,overflow_flag,less_than);
  
  
  initial
  begin
    clk=1;
    sel=3'b00;
    GPRWr=1;
    wr<=5'b00001;
    wd<=32'h80000001;
    $display(g1.regs);
    #15 wr=5'b00010;
    wd<=32'h80000000;
    #15 GPRWr=0;
    rr1=5'b00001;
    rr2=5'b00010;
    #30 ;
    
  end
  
  always
    #30 clk=~clk;
    //$display(g1.regs[30]);
  endmodule
