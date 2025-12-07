# 🎵 FPGA-Based Microprogrammed Audio Synthesizer

> **Final Project - Perancangan Sistem Digital (Digital System Design)**

![Status](https://img.shields.io/badge/Status-Completed-success?style=flat-square)
![Language](https://img.shields.io/badge/Language-VHDL-blue?style=flat-square)
![Platform](https://img.shields.io/badge/Hardware-FPGA-orange?style=flat-square)

## 📖 Project Overview

This project implements a **Microprogrammed Music Synthesizer** on an FPGA. Unlike simple music players that rely on hardcoded counters, this system operates like a specialized **CPU**. 

The system reads a "Musical Score" encoded as binary instructions (`Opcode` + `Operand`), providing flexibility in song flow control (Looping, Jumps, Waits) without modifying the hardware logic.

### Key Features
* **Microinstruction Architecture:** Songs are stored as a sequence of instructions (Play, Rest, Jump/Loop).
* **Custom Wave Generation:** Precise sound wave generation using VHDL Behavioral logic.
* **Modular Design:** Uses Structural Programming to separate Controller, Datapath, and ROM.
* **Hardware Accelerator:** Offloads real-time note timing generation from the main processing logic.

---

## 🏗️ Architecture

The design follows a **Structural** approach, connecting three main components:

1.  **Control Unit (FSM):** Handles the Fetch-Decode-Execute cycle.
2.  **Datapath:** Contains the Frequency Divider and Audio Mixer.
3.  **ROM:** Stores the micro-instructions (the song data).
---

## 🛠️ Modules & Implementation

This project applies various VHDL coding styles and Digital System concepts:

| Concept | Implementation Module | Description |
| :--- | :--- | :--- |
| **Microprogramming** | `music_rom.vhdl` | The core feature; encodes music into micro-instructions. |
| **FSM (Finite State Machine)** | `control_unit.vhdl` | Controls player states (`Idle`, `Fetch`, `Decode`, `Execute`). |
| **Behavioral Style** | `tone_generator.vhdl` | Main logic for frequency division to produce tones. |
| **Dataflow Style** | `audio_mixer.vhdl` | Logic to combine signals (extensible for polyphonic sound). |
| **Structural Style** | `top_level.vhdl` | Connects Controller, Datapath, and ROM. |
| **Functions & Packages** | `music_pkg.vhdl` | Calculates clock divider values automatically from frequencies. |
| **Testbench** | `tb_music_player.vhdl` | Verifies signal timing and state transitions. |

---

## 🚀 How to Run

### Prerequisites
* **Software:** Intel Quartus Prime, and ModelSim.
* **Hardware:** FPGA Board (Not implemented yet, cause dont have a hardware).
* **Peripherals:** Speaker or Piezo Buzzer connected to GPIO Output (cause dont have FPGA, so cant realize that).

### 1. Simulation (ModelSim)
1.  Open the project in **ModelSim**.
2.  Compile all `.vhdl` files.
3.  Load `tb_music_player`.
4.  Run simulation.
5.  Observe the `audio_out` wave to verify frequency generation.

### 2. Hardware Synthesis
1.  Open Quartus:
    * `clk` -> System Clock (e.g., 50MHz)
    * `rst` -> Push Button
    * `audio_out` -> GPIO Pin
2.  Compile the project ("Start Analysis & Synthesis") (only can get this step).
3.  Program the FPGA board.
4.  Connect the speaker to the assigned GPIO and GND.

---

## 👥 Contributors

| NIM | Name | Role | Contribution |
| :--- | :--- | :--- | :--- |
| **2406423963** | **Tomas Warren Wuisang** | Sound Engineer | `tone_generator`, `audio_mixer` |
| **2406438290** | **Irgy Rabbani Sakti** | Architect | `instruction_decoder` (FSM), Control Logic |
| **2406413445** | **Syifa Aulia Azhim** | Librarian | `music_pkg` (Functions), `music_rom` |
| **2406359600** | **Steven** | Integrator | `top_level` (Structural), `testbench` |

---

### 📜 License
This project is created for educational purposes as part of the Digital System Design course.
