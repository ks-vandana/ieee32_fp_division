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

### Netlist generation
Use the following commands
```
show
write_verilog -noattr /home/vandana/ieee32_fp_division/STAGE_1/ks_vandana_fp_div_netlist.v
```
  SInce there are 12009 cells and 11881 interconnect wires, ``show`` command doesnt give an output in the terminal
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
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/2e93899b-80d1-478b-adc1-b9793357b5a1)
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/51ddcd03-44fc-45fa-b9af-2065ad7ff1cf)
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/88215b0e-16fd-4b9d-ab91-234281321d23)

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
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/8b78fc9c-a7f4-494e-a4b9-e715abcd6a28)
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/cdb7ee91-bd13-4394-94b5-ff6582e474d2)
  ![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/fa8e640c-b204-4f32-883c-1cff2e1127e6)

We can see that the gtkwave result is the same as obtained above. Thus even after connecting the primitives, the results remain the same as above.

---

</details>

<details>

<summary><b> Stage 2 </b></summary>

### Floorplan

Run the following commands to generate floorplan
```
cd OpenLane/
sudo make mount
./flow.tcl -interactive
package require openlane 0.9
prep -design ks_vandana_fp_div
run_synthesis
run_floorplan
```

![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/724c239e-6f9f-4709-b312-20b968c853fd)

```
cd /home/vandana/OpenLane/designs/ks_vandana_fp_div/runs/RUN_2023.10.25_06.43.25/results/floorplan
magic -T /home/vandana/git_open_pdks/sky130/magic/sky130.tech lef read /home/vandana/OpenLane/designs/ks_vandana_fp_div/runs/RUN_2023.10.25_06.43.25/tmp/merged.nom.lef def read ks_vandana_fp_div.def &
```

![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/e771746c-492e-4c2a-89ff-fe404d6f0b9e)
![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/4cd6a357-ee9d-4143-a43f-720f4c6c76d4)

### Placement

```
cd OpenLane/
sudo make mount
./flow.tcl -interactive
package require openlane 0.9
prep -design ks_vandana_fp_div
run_synthesis
run_floorplan
run_placement
```

```
cd /home/vandana/OpenLane/designs/ks_vandana_fp_div/runs/RUN_2023.10.25_06.43.25/results/placement
magic -T /home/vandana/git_open_pdks/sky130/magic/sky130.tech lef read /home/vandana/OpenLane/designs/ks_vandana_fp_div/runs/RUN_2023.10.25_06.43.25/tmp/merged.nom.lef def read ks_vandana_fp_div.def &
```

![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/b30e320d-926a-4385-9118-9ba2313abe6a)
![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/d0ee7012-cb49-4ae7-a311-d000688ac310)

### Timing analysis
**my_base.scd** must be present inside the src folder of your design and pre_sta.conf must be present in the OpenLane folder. After ensuring that, run the following command.
```
sta pre_sta.conf
```

![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/007c4b30-6b8f-4b4b-86bb-1cc00f0cbe44)
![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/4c5566cd-ebbd-44f5-8c5e-5026c1b27f14)

As we can see, currently tns = -1998.54 and wns = -157.30. These values must be 0 or a postive number so we will need to improve those values.

Fanout when we used **sta** was seen to range from values 1 to 6. We will first reduce that by adding the following commands in the **config.tcl** file. After making the changes do **run_synthesis** and
```
"SYNTH_STRATEGY": "DELAY 1",
"MAX_FANOUT_CONSTRAINT": 4,
```
![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/1183d6ae-1112-4d61-a9c7-65a289b3fa7e)

We can see that now tns = -655.33 and wns = -56.52. These values need to be reduced more.

After the **replace_cells** command, tns and wns are further improved.
![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/632333cb-42d0-4c69-9088-e5e7a34f28c0)

As we can see, currently tns = -43.53 and wns = -7.28.


</details>
