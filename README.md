The project was carried out in the following phases:


<img width="940" height="691" alt="image" src="https://github.com/user-attachments/assets/95dac115-cdd4-41a0-8340-e70819bfbc0e" />

- DTMF signal tones are generated using MATLAB.
- The tone detection using Goertzel algorithm is implemented using Verilog HDL.
- The tone detection is implemented on FPGA by exporting the Verilog code onto the board. The board used is AMD Kintex™ 7 FPGA KC705 Evaluation Kit.

The following modules were created to accomplish tone detection:
1.	takeinput: To get input and store it in a register. The output of this module is later given as input to other modules.
2.	goertzel_engine: To compute the Goertzel equation. These are referred to as Goertzel engines. Each engine has its respective parameters (M1, M2, …. M8). 
3.	magnitude: To compute the magnitude of s (n).
4.	counter: To keep count of the number of input samples processed and to give an enable signal to the magnitude blocks.
5.	comparator: to compare magnitude values and generate a corresponding pattern.

The above modules are instantiated in a top module.

A Block RAM (BRAM) is created to store DTMF values. The DTMF values, for each key, that were generated through MATLAB, are compiled into a .coe file. The values from the .coe file are loaded into the BRAM at power-up. A control logic is written to fetch values from BRAM. These values are fed to the tone detection module. After DTMF tone detection process, patterns are obtained, based on which LEDs are made to glow. Constraint file (.xdc) is written to assign pins to the signals. The design is synthesized, implemented and a bitstream is generated. The bitstream is uploaded to the FPGA board. The tone selection is done through four DIP switches on the board. Output is observed through eight LEDs, four each for low group and high group patterns.
