# IEEE 32 BIT FLOATING POINT DIVISION

<details>
<summary><b> Code description </b></summary>

The following code performs division on 2 floating point numbers with representation as the IEE 754 format.

+ IEE 754 format

  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/93ff49ca-ab81-40f1-b1b6-421090a5d921)

+ Division algorithm used

  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/7a988498-8cf2-4005-a23b-ce8b9031a69f)


</details>

<details>
<summary><b> Verilog code </b></summary>

```
module ks_vandana_fp_div(
	a1,
	b1,
	c,
	clk
);
	input wire [31:0] a1;
	input wire [31:0] b1;
	input wire clk;
	output reg [31:0] c;
	reg [31:0] a;
	reg [31:0] b;
	reg sa;
	reg sb;
	reg sc;
	reg [7:0] ea;
	reg [7:0] eb;
	reg [7:0] ec;
	reg [23:0] ma;
	reg [23:0] mb;
	reg [23:0] mc;
	reg [49:0] rq;
	always @(posedge clk) begin
		a <= a1;
		b <= b1;
		c[31] <= sc;
		c[30:23] <= ec;
		c[22:0] <= mc[22:0];
	end
	always @(*) begin : sv2v_autoblock_1
		reg [0:1] _sv2v_jump;
		_sv2v_jump = 2'b00;
		sa = a[31];
		sb = b[31];
		sc = sa ^ sb;
		ea = a[30:23];
		eb = b[30:23];
		ec = (ea - eb) + 8'b01111111;
		ma = 24'b000000000000000000000000 + a[22:0];
		mb = 24'b000000000000000000000000 + b[22:0];
		mc = 24'b000000000000000000000000;
		rq = 50'b00000000000000000000000000000000000000000000000000;
		ma[23] = 1;
		mb[23] = 1;
		rq[46:23] = ma[23:0];
		begin : sv2v_autoblock_2
			reg signed [31:0] t;
			for (t = 0; t < 24; t = t + 1)
				begin
					rq = rq << 1;
					rq[49] = 0;
					rq[49:24] = rq[49:24] - mb[23:0];
					if (rq[49] == 1)
						rq[49:24] = rq[49:24] + mb[23:0];
					else
						rq[0] = 1;
				end
		end
		mc = rq[23:0];
		begin : sv2v_autoblock_3
			reg signed [31:0] l;
			begin : sv2v_autoblock_4
				reg signed [31:0] _sv2v_value_on_break;
				for (l = 0; l < 25; l = l + 1)
					if (_sv2v_jump < 2'b10) begin
						_sv2v_jump = 2'b00;
						if (~mc[23]) begin
							if (mc != 0) begin
								mc = mc << 1;
								ec = ec - 1;
								if (mc[23])
									_sv2v_jump = 2'b10;
							end
							else
								mc = mc;
						end
						_sv2v_value_on_break = l;
					end
				if (!(_sv2v_jump < 2'b10))
					l = _sv2v_value_on_break;
				if (_sv2v_jump != 2'b11)
					_sv2v_jump = 2'b00;
			end
		end
	end
endmodule
```

</details>

<details>
<summary><b> Testbench </b></summary>

```
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
```

</details>

<details>
<summary><b> STAGE 1 </b></summary>

### Yosys synthesis
Use the following commands
```
cd /home/vandana/VLSI/sky130RTLDesignAndSynthesisWorkshop/verilog_files/yosys
./yosys
read_liberty -lib /home/vandana/VLSI/sky130RTLDesignAndSynthesisWorkshop/my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog /home/vandana/ieee32_fp_division/Design/ks_vandana_fp_div.v
synth -top ks_vandana_fp_div
```
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/c55007fe-b22a-440a-8405-7f8f5f928691)
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/e113538e-4ec5-4dcb-9c40-d9acb8de43eb)

---

### abc
Use the following commands
```
abc -liberty /home/vandana/VLSI/sky130RTLDesignAndSynthesisWorkshop/my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/d94db74a-7db3-4755-a0e5-09b6c1d17c4c)
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/a40cbb3b-675a-428d-afc9-86c2c30716b4)
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/6291946f-a4c7-4372-a979-f6a09fa0e1e9)

---

### Simulation
Use the following commands
```
show
write_verilog -noattr /home/vandana/ieee32_fp_division/STAGE_1/ks_vandana_fp_div_netlist.v
```
  SInce there are 12009 cells, show command doesnt give an output in the terminal
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/16333ae4-c130-4d45-a336-e577f5073c99)
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/34b538f7-93a3-4b3d-9280-c712a2c37e86)

---

### GTKwave
Use the following commands
```
cd /home/vandana/VLSI/sky130RTLDesignAndSynthesisWorkshop/verilog_files
iverilog ks_vandana_fp_div.v ks_vandana_fp_div_tb.v
./a.out
gtkwave ks_vandana_fp_div.vcd
```
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/438e4f10-b7f6-4fa6-9819-48a43d9d3df3)
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/b3f3907e-f3bb-48e1-bd67-6a914ecfafc4)

</details>
