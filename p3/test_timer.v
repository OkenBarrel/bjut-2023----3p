module test_timer;

reg clk;
reg [31:0] dat_i;
reg [3:2] add_i;
reg we_i,clk_i,rst_i;
wire [31:0] dat_o;
wire IQR;
timer t1(clk,rst_i,add_i,dat_i,we_i,dat_o,IQR);

always
 clk=~clk;
endmodule
