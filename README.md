# Computer Organization - HRY302

VHDL lab exercises for the **Computer Organization** course at the Technical University of Crete (Spring 2024), simulated with Xilinx tools.

The labs build up step by step to a **pipelined MIPS-like processor** with forwarding and hazard detection:

<p align="center"><img src="images/final_pipeline.png" alt="Final pipelined processor" width="800"></p>

## Labs

> [Lab 0](Project%20-%20part%200) - **Simple Memory System.** A 16-bit read/write memory unit in VHDL, introducing the Xilinx Core Generator.
>
> <p align="center"><img src="images/lab0_mem_unit.png" alt="Memory unit" width="500"></p>

> [Lab 1](Project%20-%20part%201) - **Single-Cycle Processor.** An ALU and register file, combined with the datapath and control unit to build a single-cycle processor.
>
> <p align="center"><img src="images/lab1_diagram.jpg" alt="Single-cycle processor" width="700"></p>

> [Lab 2](Project%20-%20part%202) - **Multi-Cycle Processor.** The single-cycle design converted to multiple cycles, adding registers between the datapath stages and an FSM-based control unit.
>
> <p align="center"><img src="images/lab2_diagram.png" alt="Multi-cycle processor" width="700"></p>
> <p align="center"><img src="images/lab2_fsm_ctrl_unit.png" alt="Control unit FSM" width="500"></p>

> [Lab 3](Project%20-%20part%203) - **Pipelined Processor.** A pipelined version of the processor with pipeline registers, forwarding and stalls to handle data hazards.
>
> <p align="center"><img src="images/lab3_showcase_assembly.png" alt="Assembly program running on the pipelined processor" width="700"></p>