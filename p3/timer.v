module timer(clk_i,rst_i,add_i,dat_i,we_i,dat_o,IQR);
  output IQR;
  input [31:0] dat_i;
  input [3:2] add_i;
  input we_i,clk_i,rst_i;
  output [31:0] dat_o;
  reg iqr=0;
  
  //reg [31:0] ctrl;
  reg im,enable;
  reg [2:1] mode;
  
  reg [31:0] present,count;
  always@(posedge clk_i,posedge rst_i)
  begin
    if(rst_i)
      begin
        {im,mode,enable}<={1'b0,2'b00,1'b0};
        present<=32'h0;
        count<=32'h0;
      end
    else
      begin
        if(enable&&count!=32'h0)//??????
          begin
          count<=count-1;
          end
        
        if(count==32'h0)//???0?
          begin
            if(im&&enable)//????
              begin
                im<=0;
                iqr<=1'b1;
                enable<=1'b0;
              end
            else if(mode==2'b01)
              count<=present;
          end
          
        if(we_i&&add_i==2'b00)//??ctrl???
          {im,mode,enable}<={dat_i[3],dat_i[2:1],dat_i[0]};
        else if(we_i&&add_i==2'b01)
          if(~im)
            begin
              present=dat_i;
              im=1;
            end
          else
            begin
            present=dat_i;
            if(~enable&&im&&present!=32'h00000000)
              count<=present;
              enable=1;
              iqr=0;
              im=1;
            end
          
       end
  end
  assign dat_o=(add_i==2'b00)?{28'h0,im,mode,enable}:
               (add_i==2'b01)?present:count;
  assign IQR=(iqr)?1:0;
  
endmodule 