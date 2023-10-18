module ks_vandana_fp_div_tb();
reg [31:0]a1,b1;
reg clk;
wire [31:0]c1;

ks_vandana_fp_div DUT(a1,b1,c1,clk);
initial clk=0;
always #5 clk=~clk;
initial begin
a1=32'b01000001000100000000000000000000;//4
b1=32'b01000010001101000000000000000000;//9
#250 $finish;
end
endmodule
