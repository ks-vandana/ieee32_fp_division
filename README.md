# IEEE 32 BIT FLOATING POINT DIVISION

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

### abc
Use the following commands
```
abc -liberty /home/vandana/VLSI/sky130RTLDesignAndSynthesisWorkshop/my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/d94db74a-7db3-4755-a0e5-09b6c1d17c4c)
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/a40cbb3b-675a-428d-afc9-86c2c30716b4)
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/6291946f-a4c7-4372-a979-f6a09fa0e1e9)

### Simulation
Use the following commands
```
show
write_verilog -noattr /home/vandana/ieee32_fp_division/STAGE_1/ks_vandana_fp_div_netlist.v
```
  SInce there are 12009 cells, show command doesnt give an output in the terminal
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/16333ae4-c130-4d45-a336-e577f5073c99)
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/34b538f7-93a3-4b3d-9280-c712a2c37e86)

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
