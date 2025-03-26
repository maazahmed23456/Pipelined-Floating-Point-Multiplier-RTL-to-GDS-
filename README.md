# Pipelined-Floating-Point-Multiplier-RTL-to-GDS-
Designed a Pipelined Floating Point Multiplier that works with IEEE 754 Single Precision FP numbers at RTL level , performed synthesis and verified functionality by Gate Level Simulation (GLS) then performed the backedn physical design from Floorplan to Signoff using Innovus.

## A Glance at the FP Multiplier Architecture

Pipelined Floating-Point Multiplier (FP Multiplier) Architecture

A pipelined floating-point (FP) multiplier is a high-performance arithmetic unit designed for efficient multiplication of floating-point numbers, adhering to the IEEE 754 standard. The pipelining technique enhances throughput by breaking the multiplication process into sequential stages, enabling concurrent execution of multiple operations. This architecture is widely utilized in digital signal processing (DSP), machine learning, graphics processing, and high-performance computing applications.

Pipeline Stages

The pipelined FP multiplier consists of the following key stages:

- 1. Sign Logic


- 2. Exponent Addition


- 3. Mantissa Multiplication


- 4. Normalization & Rounding


- 5. Exception Handling
 
- **Applications**

- Digital Signal Processing (DSP): Real-time audio and video processing.

- Machine Learning & AI Accelerators: High-speed tensor computations in deep learning frameworks.

- Graphics Processing: Floating-point arithmetic in GPU shaders and image rendering.

- Scientific Computing: High-precision numerical simulations and matrix operations. 



## Base Paper

This work was referred from architectures proposed in the following paper -:

A. Y. N J and A. V R, "FPGA Implementation of a High Speed Efficient Single Precision Floating Point ALU," 2023 International Conference on Control, Communication and Computing (ICCC), Thiruvananthapuram, India, 2023, pp. 1-5, doi: 10.1109/ICCC57789.2023.10165441. keywords: {Power demand;Program processors;Simulation;Computer architecture;Dynamic range;Hardware;Hardware design languages;IEEE 754;ALU;FPGA;RISC V ISA;Exceptions},


## Block Diagram of the FP Multiplier 

 <p align="center">
  <img width="500" height="500" src="/Images/BLOCK.png">
</p>

## AMD Xilinx Vivado implementations
The RTL level design of the multiplier was developed in AMD Xilinx Vivado and functional verification and fpga synthesis was also performed.


## Schematic of the FP Multiplier

 <p align="center">
  <img width="800" height="500" src="/Images/Screenshot 2025-03-20 235011.png">
</p>


## Simulation of the FP Multiplier

 <p align="center">
  <img width="800" height="500" src="/Images/Screenshot 2025-03-20 235125.png">
</p>



## Synthesized Netlist in Genus

 <p align="center">
  <img width="800" height="500" src="/Images/NETLIST.png">
</p>

The logic which is the multiplier module consume a power of 0.555 watts 

## AREA

 <p align="center">
  <img width="800" height="500" src="/Images/AREA.png">
</p>

## POWER

<p align="center">
  <img width="800" height="500" src="/Images/POWER.png">
</p>

## TIMING

<p align="center">
  <img width="800" height="500" src="/Images/Screenshot 2025-03-26 193053.png">
</p>


## Innovus Implementation
The design was imported to Openlane on linux and a configuration script was developed which performed the synthesis to gds steps. Openlane is an open-source EDA tools that is used to perfrom the ASIC flow. The design was implemented by leveraging Skywater 130nm pdk.

## Final Routed Design

 <p align="center">
  <img width="800" height="500" src="/Images/PD.png">
</p>

## Summary

- Designed a 32-bit floating-point multiplier with 5-stage pipelining in Verilog, achieving a 3.78 ns critical path.

- Power & Area: Achieved 1.6 mW power and occupied 13207 μm² area, utilizing 1332 standard cells after synthesis in Cadence Genus.

- Physical Design: Completed floorplanning, placement, clock tree synthesis (CTS), and routing in Cadence Innovus (90nm technology).

- Final Design Metrics:

Chip Area: 137 × 137 μm²

Throughput: 8.47 Gbps

Performance: 0.265 GFLOPs


***************



## Future Work

- Design the division , adder and subtractor modules in similar floating point operation
- Integrate all the modules into a Floating Point ALU with opcode and clock for operation at highest frequency possible
- Perform the RTL to GDS flow of the FP ALU in Cadence or Synopsys EDA Tools or Openlane ASIC Flow
- Fabricate the chip for real time testing

## Contributors 

- **Maaz Ahmed**  

## Acknowledgments

- Dr.Ediga Raghuveera , AdHoc Faculty , NIT AP (mentor)
- Dr.Kiran Kumar Gurrala , Assistant Professor , NIT AP
- Dr.Puli Kishore Kumar , Assistant Professor , NIT AP
- Harika Banala , PhD , NIT AP

## Contact Information

- Shaik Maaz Ahmed , maazahmed23456@gmail.com




