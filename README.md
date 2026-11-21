## Here's my vhdl entity codebase.
Who would've considered? 
## 🚀 Prerequisites & Installation

Before getting started, you need to install **GHDL** (the open-source VHDL compiler/simulator) and **GTKWave** (the waveform viewer).

## Linux 
- ### Ubuntu / Debian:
```bash
sudo apt update
sudo apt install ghdl gtkwave
```
- ### Arch
 > **You need to install [aur](https://aur.archlinux.org/) first.**
```bash
sudo pacman -Syu
yay -S ghdl
sudo pacman -S gtkwave
```

###### Using mac or windows? kys.


## 🧩 VS Code Extensions

To get syntax highlighting, real-time diagnostics, and auto-completion inside VS Code, Search for and install the following recommended extensions:

    VHDL (by mshr-h) – Provides language server support, syntax checking, and code navigation (VHDLS).

    VHDL Formatter (Optional) – Keeps your code clean and consistently styled.

📁 Project Structure

Organize your source files cleanly separating design entities from testbenches:

```bash
your_vhdl_project/
├── src/
│   ├── halfadder.vhd      # Design under test (DUT)
│   └── halfadder_tb.vhd   # Testbench
├── simulation/            # Auto-generated build artifacts & VCD files
├── simu.sh                # Automated simulation script
└── README.md
```


## ⚙️ How to Run the Simulator

This repository comes with an automated bash script (simu.sh) that handles compilation, elaboration, execution, and waveform generation with a single command.
1. Make the script executable (first time only)
```bash
chmod +x simu.sh
```
2. Run your simulation

Pass your entity file and testbench file using the --enti and --tb flags:
```bash
./simu.sh --enti src/adders/halfadder/halfadder.vhd --tb src/adders/halfadder/halfadder_tb.vhd
```
The script will:

1. Create a simulation/ work directory.

1. Analyze both VHDL files using GHDL (ghdl -a).

1. Elaborate the testbench entity (ghdl -e).

1. Run the simulation and generate a .vcd waveform file (ghdl -r).

1. Prompt you to automatically open GTKWave to inspect your signals.