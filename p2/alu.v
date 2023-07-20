module alu(in1,in2,sel,out,zero,overflow_flag,less_than);
  input [31:0]in1,in2;
  input [1:0] sel;
  output [31:0]out;
  output overflow_flag;
  wire overflow;
  output zero;
  output less_than;
  wire [31:0] temp;
  //always@(*)
  //begin
    //case(sel)
      //3'b00:=in1+in2;//+
      //3'b01:{overflow,temp}<=in1-in2;//-
      //3'b10:temp<=in1|in2;//or
    //endcase
  //end
  assign {overflow,temp}=(sel==2'b00)? {{in1[31],in1}+{in2[31],in2}}:
                        (sel==2'b01)? {in1[31],in1}-{in2[31],in2}:in1|in2;
  assign out=temp;
  assign zero=(sel==2'b01&&out==32'h00000000)?1:0;
  assign overflow_flag=overflow^temp[31];
  assign less_than=(sel==2'b01&&temp[31])?1:0;
endmodule
