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

### Timing analysis
**my_base.scd** must be present inside the src folder of your design and **pre_sta.conf** must be present in the OpenLane folder. 
Some changes made in the config.tcl file are
```
"CLOCK_PERIOD": 30.000,
"MAX_FANOUT_CONSTRAINT": 4,
"SYNTH_STRATEGY": "DELAY 0",
"SYNTH_SIZING":1,
```
First we need to synthesize the design as the results from synthesis is used in the **pre_sta.conf** file
```
cd OpenLane
sudo make mount
./flow.tcl -interactive
package require openlane 0.9
prep -design ks_vandana_fp_div
run_synthesis
```
After ensuring that, run the following command after **run_synthesis**.
```
sta pre_sta.conf
```
![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/4aed4051-195a-4529-9f76-eb20a825c9e0)
![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/d0cdce40-1cd1-4f09-9f8f-d86dd9aa6ed4)
![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/66806b21-9194-4a54-aabf-564cb550276b)

We can see that tns = 0 and wns = 0. But slack = 4.43. Even though slack is met, we need to ensure that this value is as minimum as possible. We can ensure this by reducing the clock period.
After reducing clock period, perform the above commands again. When clock period was set as 25

![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/ef1f4924-506f-4f1e-a247-cbe07f5c8888)

Hence changes still need to be made as now slack is violated. When clock period is set as 26

![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/6f341fba-802f-4a19-b0c8-3bf4188e2e2d)

Thus slack is now in an acceptable range.

### Floorplan

Now that timing analysis before synthesis is done, run the following commands to generate floorplan
```
run_floorplan
```
![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/857d54ba-f5d4-4042-a999-aa054f24134f)

```
cd /home/vandana/OpenLane/designs/ks_vandana_fp_div/runs/RUN_2023.11.01_09.00.10/results/floorplan
magic -T /home/vandana/git_open_pdks/sky130/magic/sky130.tech lef read /home/vandana/OpenLane/designs/ks_vandana_fp_div/runs/RUN_2023.11.01_09.00.10/tmp/merged.nom.lef def read ks_vandana_fp_div.def &
```
![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/835a2cdb-76cf-421c-b745-75f842a75d93)
![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/9e3dc98a-9b92-4cfe-98e7-ac7e1ccf852b)

### Placement

```
run_placement
```
![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/9af37d05-b00e-4b64-89db-f07ba69e37fb)

```
cd /home/vandana/OpenLane/designs/ks_vandana_fp_div/runs/RUN_2023.11.01_09.00.10/results/placement
magic -T /home/vandana/git_open_pdks/sky130/magic/sky130.tech lef read /home/vandana/OpenLane/designs/ks_vandana_fp_div/runs/RUN_2023.11.01_09.00.10/tmp/merged.nom.lef def read ks_vandana_fp_div.def &
```
![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/ebe2064c-fdda-4366-a624-27aadd0c9259)
![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/c8a13097-1613-4014-a11d-ec103dc9248d)
![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/1218ec3b-a0f1-4f97-b4d8-f7e9e3628da8)

### Clock tree synthesis

```
run_cts
```
![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/9d1fb383-62fc-455c-8988-ca954c5e79b7)

### Power Distribution Network
```
gen_pdn
```
![image](https://github.com/ks-vandana/ieee32_fp_division/assets/116361300/f942a029-d449-40f0-9107-700ed15bd48b)

### Routing
```
run_routing
```


</details>
