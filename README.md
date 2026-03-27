# 🔄 8051 Bidirectional UART Communication

##  Overview

This project implements **bidirectional serial communication** between two 8051 microcontrollers. The system features a custom **Select Mode** (Serial Mode) that allows the user to control the direction and format of the UART communication.

Key highlights:
*   **Real-time Interaction:** Full-duplex simulation between two MCUs.
*   **Mode Selection:** Integrated logic to switch communication states via hardware triggers.

---

##  Hardware Components (Per MCU)


| Component | Specification |
| :--- | :--- |
| **Microcontroller** | 8051 (AT89S52) |
| **Crystal Oscillator** | 11.0592 MHz |
| **Resistors** | 10kΩ |
| **Input** | Push Buttons / Switches |
| **Output** | LEDs (optional status indicators) |
| **Power Supply** | 5V DC |

---

##  Circuit Simulation (SimulIDE)

Below is the architectural layout of the bidirectional link:

<p align="center">
  <img src="https://github.com/user-attachments/assets/a64b21cf-cd18-4342-ab35-3efd759065ee" alt="SimulIDE Circuit Screenshot" width="90%">
</p>

---

##  References

*   **Ayala, Kenneth J.** - *The 8051 Microcontroller*
*   **Nicolosi, Denys E. C.** - *Microcontrolador 8051 Detalhado*

---

##  How to Run
1.  Open the `.simu` file in **SimulIDE**.
2.  Load the compiled `.hex` or `.bin` (Assembly) into both 8051 MCUs.
3.  Power on the simulation and use the switches to toggle communication modes.
