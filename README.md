# 💾  Dual Port RAM using SystemVerilog

![Language](https://img.shields.io/badge/Language-SystemVerilog-blue)
![RTL Design](https://img.shields.io/badge/RTL-Design-green)
![EDA Playground](https://img.shields.io/badge/Simulator-EDA%20Playground-success)
![Verification](https://img.shields.io/badge/Verification-Testbench-orange)
![Project Status](https://img.shields.io/badge/Status-Completed-brightgreen)
![License](https://img.shields.io/badge/License-MIT-yellow)

## 📖 Definition

A **Dual Port Random Access Memory** is a memory architecture that provides **two fully independent ports**, allowing both ports to perform **simultaneous read and write operations**. Unlike a Simple Dual Port RAM, where one port is dedicated to reading and the other to writing, a True Dual Port RAM enables each port to independently read from or write to memory, improving flexibility and throughput.

This project implements a **synthesizable True Dual Port RAM** using **SystemVerilog** with a modular RTL design approach. The design is functionally verified through simulation using a dedicated SystemVerilog testbench.

---

## 🎯 Project Objective

The objective of this project is to design and verify a **Dual Port RAM** capable of supporting independent and simultaneous read/write operations on two ports. The project demonstrates memory architecture design, sequential RTL implementation, module integration, and functional verification using SystemVerilog.

---

## 📚 Repository Contents

- RTL Source Code
- SystemVerilog Testbench
- Screenshots
- Project Documentation

---

## ⚙️ Functionality

The Dual Port RAM consists of two fully independent ports (**Port A** and **Port B**). Each port can simultaneously perform read or write operations without interfering with the other.

### Features

- Independent Port A and Port B
- Simultaneous Read and Write Operations
- Separate Address, Data, and Control Signals
- Synchronous Memory Operation
- Synthesizable RTL Design
- Modular and Reusable Architecture
- Functional Verification using Testbench

---

## 🏛️ Architecture

The design consists of a shared memory array accessed through two completely independent ports. Each port has its own address bus, data bus, write enable signal, and clock, allowing concurrent memory operations.

```text
                     +-------------------------------------------+
                     |           TRUE DUAL PORT RAM              |
                     |                                           |
 Port A Address ---->|                                           |<---- Port B Address
 Port A Data In ---->|                                           |<---- Port B Data In
 Port A Write En --->|                                           |<---- Port B Write En
 Port A Clock ------>|             Memory Array                  |<---- Port B Clock
                     |                                           |
 Port A Data Out <---|                                           |----> Port B Data Out
                     +-------------------------------------------+
```

---
# 🧪 Verification Architecture

The DUT is verified using a custom layered SystemVerilog testbench.

```text
                        +----------------------+
                        |        Test          |
                        +----------+-----------+
                                   |
                        +----------v-----------+
                        |     Environment      |
                        +----------+-----------+
                                   |
        ----------------------------------------------------------
        |              |             |            |               |
        v              v             v            v               v
   Generator       Driver(BFM)    Monitor   Reference Model   Scoreboard
        |              |             |            |               |
        ---------------------- Interface -------------------------
                                   |
                                   v
                                 DUT
# 🔄 Verification Flow

1. Generator creates random memory transactions.
2. Driver converts transactions into DUT signals.
3. Interface connects the verification environment to the DUT.
4. DUT executes memory operations.
5. Monitor captures DUT activity.
6. Reference Model predicts expected behavior.
7. Scoreboard compares expected and actual outputs.
8. Final verification report is generated.

---

# 📚 Verification Components

## Generator

- Generates randomized memory transactions.
- Sends transactions to the driver.

---

## Driver (BFM)

- Receives transactions from the generator.
- Drives signals onto the DUT interface.

---

## Monitor

- Observes DUT interface signals.
- Captures actual DUT outputs.
- Sends collected transactions to the scoreboard.

---

## Reference Model

- Predicts expected RAM behavior.
- Generates expected read data.

---

## Scoreboard

- Compares DUT output with Reference Model output.
- Reports PASS or FAIL.
- Maintains verification statistics.

---

## Environment

Integrates:

- Generator
- Driver
- Monitor
- Reference Model
- Scoreboard

---

## Interface

Provides communication between

- Testbench
- Driver
- DUT
- Monitor

using virtual interfaces.

---

## Test

Starts the verification environment.

Controls simulation execution.

---

## Top Module

Instantiates

- DUT
- Interface
- Testbench

and starts simulation.

---

## 🔄 Design Flow

1. Design the shared memory array.
2. Implement independent read/write logic for Port A.
3. Implement independent read/write logic for Port B.
4. Integrate both ports into a single RTL module.
5. Develop a SystemVerilog testbench.
6. Simulate the design using **EDA Playground**.
7. Analyze waveforms using **EPWave**.
8. Verify correct simultaneous memory operations.

---

## 📥 Inputs

| Signal | Description |
|---------|-------------|
| clk_a | Clock for Port A |
| clk_b | Clock for Port B |
| we_a | Write Enable for Port A |
| we_b | Write Enable for Port B |
| addr_a | Address for Port A |
| addr_b | Address for Port B |
| data_in_a | Input Data for Port A |
| data_in_b | Input Data for Port B |

---

## 📤 Outputs

| Signal | Description |
|---------|-------------|
| data_out_a | Output Data from Port A |
| data_out_b | Output Data from Port B |

---

## 🧪 Testbench Methodology

The SystemVerilog testbench verifies the functionality of the True Dual Port RAM by:

- Writing data through Port A
- Writing data through Port B
- Reading data independently from both ports
- Verifying simultaneous read/write operations
- Comparing expected and actual outputs
- Displaying simulation status
- Observing memory behavior using EPWave

---

## 📊 Verification Summary

| Parameter | Value |
|-----------|-------|
| Memory Type | True Dual Port RAM |
| RTL Language | SystemVerilog |
| Ports | 2 |
| Memory Access | Simultaneous Read/Write |
| Verification | SystemVerilog Testbench |
| Simulation Platform | EDA Playground |
| Waveform Viewer | EPWave |

---

## 💻 Tools Used

- SystemVerilog
- EDA Playground

---

## 🛠️ Key Technologies

- SystemVerilog
- RTL Design
- Functional Verification
- Layered Testbench
- Object-Oriented Programming (OOP)
- Transaction-Level Verification
- Interface
- Mailbox Communication
- Events
- Randomization
- Scoreboard
- Reference Model
- EDA Playground

---

## ✅ Advantages

- Supports simultaneous read and write operations
- Independent access through both memory ports
- High memory throughput
- Reduced memory access bottlenecks
- Modular and reusable RTL implementation
- Synthesizable hardware design
- Suitable for FPGA and ASIC implementation

---

## ❌ Limitations

- Does not include Error Correction Code (ECC)
- No byte-enable functionality
- No memory initialization through reset
- Memory collision handling depends on implementation
- Limited to configured memory depth and data width

---

## 🚀 Applications

- CPU Register Files
- Processor Cache Memory
- FPGA Block RAM
- Multi-Core Processor Systems
- Digital Signal Processing (DSP)
- Communication Systems
- Embedded Systems
- High-Speed Data Buffers
- ASIC Memory Subsystems

---

## 💡 Challenges Faced

- Designing simultaneous access logic
- Handling independent memory ports
- Preventing unintended memory conflicts
- Developing reusable RTL architecture
- Verifying concurrent memory operations
- Debugging waveform behavior

---

## 📈 Future Scope

This project can be extended by implementing:

- Parameterized Memory Depth
- Parameterized Data Width
- Dual Clock Architecture
- Error Correction Code (ECC)
- Byte Enable Support
- Burst Read/Write Operations
- AXI Interface
- APB Interface
- Wishbone Interface
- Memory Collision Detection

---

## 🎓 Learning Outcomes

Through this project, I gained practical experience in:
- SystemVerilog Programming
- RTL Design
- Memory Architecture
- Layered Verification Methodology
- Transaction-Level Verification
- Object-Oriented Programming
- Randomization
- Mailbox Communication
- Interfaces
- Functional Verification
- Scoreboard-Based Checking
- Reference Model Development
- Waveform Debugging
- EDA Playground Simulation


---

## 📌 Key Takeaways

- Designed a synthesizable **True Dual Port RAM** using SystemVerilog.
- Implemented simultaneous independent memory access through two ports.
- Applied modular RTL design principles.
- Verified functionality using a dedicated SystemVerilog testbench.
- Strengthened understanding of memory architecture and sequential digital design.
- Gained hands-on experience with simulation and functional verification.

---

## 🌟 Project Highlights

- ✔️ SystemVerilog RTL Implementation
- ✔️ True Dual Port Memory Architecture
- ✔️ Independent Read/Write Ports
- ✔️ Synthesizable Design
- ✔️ Modular Hardware Architecture
- ✔️ Functional Verification
- ✔️ Simulation using EDA Playground
- ✔️ Waveform Analysis using EPWave

---

## 🙌 Acknowledgements

This project was developed as part of my learning journey in **Digital Design**, **RTL Design**, and **SystemVerilog**. It strengthened my understanding of memory architecture, sequential logic design, and functional verification using industry-relevant RTL design practices.

---

## 👩‍💻 Author

**Saakshi**

Electronics and Communication Engineering (ECE)

**Areas of Interest:** Digital Design • RTL Design • SystemVerilog • VLSI • ASIC Design • Functional Verification

**GitHub:** https://github.com/SiliconSprintX

**LinkedIn:** www.linkedin.com/in/saakshi-l

---

## 📄 License

This project is licensed under the **MIT License**. See the **LICENSE** file for more details.

---
⭐ **If you found this project useful, consider giving the repository a Star!**
