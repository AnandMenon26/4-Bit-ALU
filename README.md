# 4-Bit ALU in Verilog

4-bit ALU implemented in Verilog with arithmetic, logic, flag generation, and functional verification.

## Overview

This project implements a 4-bit Arithmetic Logic Unit (ALU) using Verilog.

The ALU supports:
- Addition
- Subtraction
- AND
- OR
- XOR
- Complement
- Increment
- Decrement

The design also generates the following status flags:
- Carry
- Borrow
- Zero
- Signed overflow

## ALU Operations

| `op` | Operation |
|------|-----------|
| `000` | Addition |
| `001` | Subtraction |
| `010` | AND |
| `011` | OR |
| `100` | XOR |
| `101` | Complement |
| `110` | Increment |
| `111` | Decrement |

## Files

- `alu.v` - ALU design
- `alu_tb.v` - Verilog testbench used for functional verification
- `waveforms/` - GTKWave waveform results

## Verification

The testbench includes:
- General functional tests for all eight operations
- Boundary-condition tests
- Zero-result testing
- Signed overflow tests
- Carry and borrow verification

A total of **17 directed tests** were executed.

```text
Total Tests: 17
Passed Tests: 17
Failed: 0
