#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

ENTITY_FILE=""
TB_FILE=""

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --enti) ENTITY_FILE="$2"; shift ;;
        --tb) TB_FILE="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Validate that both arguments were provided
if [ -z "$ENTITY_FILE" ] || [ -z "$TB_FILE" ]; then
    echo "Error: Both --enti and --tb arguments are required."
    echo "Usage: ./simu.sh --enti [entity_file.vhd] --tb [testbench_file.vhd]"
    exit 1
fi

# Check if files exist
if [ ! -f "$ENTITY_FILE" ]; then
    echo "Error: Entity file '$ENTITY_FILE' not found!"
    exit 1
fi

if [ ! -f "$TB_FILE" ]; then
    echo "Error: Testbench file '$TB_FILE' not found!"
    exit 1
fi

# Create simulation work directory
mkdir -p simulation

# Function to automatically extract the entity name from the VHDL file
extract_entity_name() {
    local file="$1"
    local ent=$(grep -i -E '^[[:space:]]*entity[[:space:]]+[a-zA-Z0-9_]+[[:space:]]+is' "$file" | head -n 1 | awk '{print $2}')
    if [ -z "$ent" ]; then
        basename "$file" .vhd
    else
        echo "$ent"
    fi
}

TB_ENTITY_NAME=$(extract_entity_name "$TB_FILE")

echo "=========================================="
echo " [1/4] Analyzing VHDL files..."
echo " Entity file:    $ENTITY_FILE"
echo " Testbench file: $TB_FILE"
echo " Top Entity:     $TB_ENTITY_NAME"
echo "=========================================="

# Analyze
ghdl -a --ieee=synopsys --workdir=simulation "$ENTITY_FILE" "$TB_FILE"

echo " [2/4] Elaborating design..."
# Elaborate
ghdl -e --ieee=synopsys --workdir=simulation "$TB_ENTITY_NAME"

echo " [3/4] Running simulation..."
# Run Simulation
ghdl -r --ieee=synopsys --workdir=simulation "$TB_ENTITY_NAME" --vcd="simulation/${TB_ENTITY_NAME}.vcd"

echo "=========================================="
echo " Success! Waveform saved to simulation/${TB_ENTITY_NAME}.vcd"
echo "=========================================="

# Prompt to open GTKWave
read -p "Would you like to open GTKWave now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    gtkwave "simulation/${TB_ENTITY_NAME}.vcd" &
fi