# Documentation: Serial Communication Between Two 8051 Microcontrollers

## 1. Overview

This project implements full-duplex serial communication between two 8051 microcontrollers. The communication uses the built-in UART of the 8051, with TXD and RXD lines connected between the two devices. The serial mode is selected by two switches (Sw_1 and Sw_2), which are connected to port 0 pins of both microcontrollers. Both devices operate in the same mode at all times. Data entered via switches on port 2 of one microcontroller is transmitted to the other microcontroller and displayed on LEDs connected to its port 1. The system is bidirectional, allowing both microcontrollers to transmit and receive.

## 2. Hardware Configuration

### 2.1 Microcontroller

- Two 8051 microcontrollers (e.g., AT89S51, AT89C51, or compatible).
- Operating frequency: 11.0592 MHz crystal oscillator.

### 2.2 Serial Communication Pins

- P3.0 (RXD) – Receive data line.
- P3.1 (TXD) – Transmit data line.

Connection between the two 8051s:
- TXD of MCU1 connected to RXD of MCU2.
- TXD of MCU2 connected to RXD of MCU1.
- Common ground.

### 2.3 Mode Selection Switches

- Sw_1 connected to P0.0 of both microcontrollers.
- Sw_2 connected to P0.1 of both microcontrollers.
- Both switches are active low, pulling the pin to logic 0 when in default position.
- Logic levels:
  - Switch closed (default): logic 0.
  - Switch open: logic 1 (requires external pull-up resistor on P0).

The two switches together set the serial mode as per the SM0 and SM1 bits of the SCON register:

| Sw_2 (P0.1) | Sw_1 (P0.0) | SM0 | SM1 | Serial Mode | Description                      |
|-------------|-------------|-----|-----|-------------|----------------------------------|
| 0           | 0           | 0   | 0   | Mode 0      | Shift register, fixed baud rate |
| 0           | 1           | 0   | 1   | Mode 1      | 8-bit UART, variable baud rate  |
| 1           | 0           | 1   | 0   | Mode 2      | 9-bit UART, fixed baud rate     |
| 1           | 1           | 1   | 1   | Mode 3      | 9-bit UART, variable baud rate  |

Both microcontrollers read the same switch settings to configure their SCON registers identically.

### 2.4 Data Input and Output

- Data input: 8 DIP switches connected to Port 2 (P2.0–P2.7) of each microcontroller.
- Data output: 8 LEDs (with current-limiting resistors) connected to Port 1 (P1.0–P1.7) of each microcontroller.
- Data flow:
  - When MCU1 transmits, the byte set on its P2 switches appears on MCU1's TXD line, is received by MCU2's RXD, and is displayed on MCU2's P1 LEDs.
  - Simultaneously, MCU2 can transmit data from its P2 switches to be displayed on MCU1's P1 LEDs.

## 3. Baud Rate

For all modes with variable baud rate (Mode 1 and Mode 3), the baud rate is set to 9600 bps. The 8051 uses Timer 1 in auto-reload mode (8-bit) to generate the baud rate. Given the crystal frequency of 11.0592 MHz, the required reload value is calculated as:

Baud Rate = (2^SMOD / 32) * (Oscillator Frequency / (12 * (256 - TH1)))

Setting SMOD = 0 (default in PCON register) and solving for TH1:

9600 = (1 / 32) * (11.0592e6 / (12 * (256 - TH1)))

256 - TH1 = 11.0592e6 / (12 * 32 * 9600) = 11.0592e6 / (3,686,400) = 3

TH1 = 256 - 3 = 253 (0xFD).

Timer 1 is configured in mode 2 (8-bit auto-reload).

For Mode 0, baud rate is fixed at Oscillator Frequency / 12 = 921.6 kbps.  
For Mode 2, baud rate is fixed at (2^SMOD / 64) * Oscillator Frequency. With SMOD=0, baud rate = 172.8 kbps.

## 4. Software Configuration

### 4.1 Initialization Steps (both microcontrollers)

1. Read P0.0 and P0.1 to determine SM1 and SM0.
2. Set SCON bits SM0 and SM1 accordingly.
3. If Mode 0 or Mode 2:  
   - Disable Timer 1 for baud rate generation (not needed).
4. If Mode 1 or Mode 3:  
   - Set Timer 1 to mode 2 (8-bit auto-reload).  
   - Load TH1 = 0xFD.  
   - Clear TF1, start Timer 1 (TR1 = 1).  
   - Set SMOD = 0 in PCON register.
5. Set REN = 1 in SCON to enable reception.
6. Clear TI and RI flags.

### 4.2 Transmission Routine

- Wait for a change on Port 2 or transmit on request.
- Load the byte from P2 into SBUF.
- Wait for TI flag to be set.

### 4.3 Reception Routine (interrupt-driven or polling)

- Wait for RI flag to be set.
- Read received byte from SBUF.
- Output the byte to Port 1.
- Clear RI.

## 5. System Operation

1. Upon power-up or reset, both microcontrollers read the mode selection switches on P0.0 and P0.1.
2. Both configure SCON and Timer 1 identically.
3. Each microcontroller continuously monitors its Port 2 switches for changes.
4. When a change is detected, the byte is transmitted via the UART.
5. The receiving microcontroller accepts the byte and displays it on its Port 1 LEDs.
6. The system is full-duplex: transmission and reception can occur simultaneously.

## 6. Connection Diagram Description

- MCU1 P3.1 (TXD) -> MCU2 P3.0 (RXD)
- MCU1 P3.0 (RXD) <- MCU2 P3.1 (TXD)
- Common ground between both boards.
- Sw_1 and Sw_2: one terminal to ground, other terminal to P0.0 and P0.1 respectively, with pull-up resistors to Vcc.
- P2 switches: one terminal to ground, other terminal to P2.x, with pull-ups if needed.
- P1 LEDs: anode to Vcc via 330-ohm resistor, cathode to P1.x pin (active low output).
