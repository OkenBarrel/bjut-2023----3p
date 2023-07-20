module ext(ext_sel,datain,dataout);
  input [1:0]ext_sel;
  input[15:0] datain;
  output[31:0] dataout;
  reg[31:0] temp;
  
  always@(*)
  begin
    case(ext_sel)
      3'b00:temp<={{16{1'b0}},datain};
      3'b01:temp<={{16{datain[15]}},datain};
      3'b10:temp<={datain,{16{1'b0}}};
    endcase
  end
  assign dataout=temp;
endmodule