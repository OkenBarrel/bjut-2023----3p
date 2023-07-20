module bridge(addr,WEcpu,writeData,timer_rd,in32_rd,out32_rd,readData,dev_addr,dev_writeData,we);
  input [31:2]addr;
  input [31:0] writeData;
  input WEcpu;
  
  output [1:0]dev_addr;
  input [31:0] in32_rd,out32_rd,timer_rd;
  output [31:0] readData;
  output [2:0]we;
  wire hit1,hit2,hit3;
  output [31:0] dev_writeData;
  
  assign dev_addr=addr[3:2];
  wire [31:0] Addr;
  assign Addr={addr,2'b00};
  
  assign hit1=(Addr==32'h00008000);//in
  assign hit2=(Addr==32'h00008100);//out
  assign hit3=(Addr[31:8]=='h00007f);//timer
  assign readData=(hit1)?in32_rd:
                  (hit2)?out32_rd:timer_rd;
  
  assign we={hit1,hit2&&WEcpu,hit3&&WEcpu};
  
  assign dev_writeData=writeData;
endmodule
  
