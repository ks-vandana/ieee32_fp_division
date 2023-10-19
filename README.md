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
<summary><b> Stage 1 </b></summary>

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

### Pre-synthesis simulation
Use the following commands
```
cd /home/vandana/VLSI/sky130RTLDesignAndSynthesisWorkshop/verilog_files
iverilog ks_vandana_fp_div.v ks_vandana_fp_div_tb.v
./a.out
gtkwave ks_vandana_fp_div.vcd
```
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/438e4f10-b7f6-4fa6-9819-48a43d9d3df3)
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/933b51e8-9fcf-4733-be9f-4726e3abcd6d)

```
Values in testbench:
1) a1=32'b01000010111101111011001100110011 = 123.85 in decimal

   b1=32'b01000010001101100000000000000000 = 45.5 in decimal

   Output expected : c1 = 32'b01000000001011100011010011100011 = 2.72197 in decimal

   Output seen in gtkwave : c1 = 32'b1000000001011100011010011100011 = 2.72197 in decimal
   
3) a1=32'b01000010000101110101000011100101 = 37.829 in decimal

   b1=32'b01000000000010001110010101100000 = 2.139 in decimal

   Output expected : c1 = 32'b01000001100011010111101110100010 = 17.68536 in decimal

   Output seen in gtkwave : c1 = 32'b01000001100011010111101110100001 = 17.68536 in decimal
   
5) a1=32'b01000010100001101101001101110101 = 67.413 in decimal

   b1=32'b01000001000011110001001001101111 = 8.942 in decimal

   Output expected : c1 = 32'b01000000111100010011111011010000 = 7.53891 in decimal

   Output seen in gtkwave : c1 = 32'b01000000111100010011111011001110 = 7.53891 in decimal
```
Thus the code is accurate upto 5 decimal places.

### Post-synthesis simulation

Now we use the following commands
```
iverilog ../my_lib/verilog_model/primitives.v ../my_lib/verilog_model/sky130_fd_sc_hd.v ../verilog_files/ks_vandana_fp_div_netlist.v ../verilog_files/ks_vandana_fp_div_tb.v
./a.out
gtkwave ks_vandana_fp_div.vcd
```
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/7ed4e4cc-9f8f-4640-be54-92dbe727cfe5)
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/065ae3be-1054-48b2-946d-43f46d481272)

We can see that the gtkwave result is the same as obtained above. Thus even after connecting the primitives, the results remain the same as above.

---

</details>
