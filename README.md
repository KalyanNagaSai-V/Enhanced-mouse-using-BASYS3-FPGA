## Overview
Implemented an enhanced mouse interface on the BASYS3 FPGA board using Verilog. Enables real-time cursor control, click detection, and gesture recognition for advanced interactivity.

## Features
- **PS/2 Mouse Interface:** Implemented PS/2 protocol communication between the mouse and FPGA.  
- **Cursor Control:** Real-time on-screen cursor movement based on mouse input.  
- **Click Detection:** Supports standard mouse operations including left-click, right-click, and double-click.  
- **Gesture Recognition:** Recognizes specific mouse gestures to extend functionality beyond standard operations.  

## Implementation Details
- Developed entirely in **Verilog** and synthesized using **Xilinx Vivado**.  
- Deployed and tested on the **BASYS3 FPGA board**.  
- Modular design allows for future feature extensions.  

## Usage
1. Connect the PS/2 mouse to the BASYS3 board.  
2. Program the FPGA using Vivado with the synthesized bitstream.  
3. Move the mouse to control the cursor; perform clicks or gestures to interact with the system.  

## Outcome
- Successfully demonstrated cursor movement, click operations, and gesture-based commands on FPGA hardware.  
- Enhanced BASYS3 board usability as an interactive input device.
