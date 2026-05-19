# Fundamental Training of VLSI System Primitives

A personal training log of hands-on SystemVerilog builds covering the primitive
classes that underlie all digital hardware. Each session is a small, parameterized,
fully simulated RTL module with a self-checking testbench.

**Author:** Jeremiah Conway · Ph.D. — Secure Embedded Systems · Morgan State University CAP Center

## Purpose

These builds are the deliberate-practice scaffolding behind larger work on BASE v4.0
(post-quantum HSM) and related secure-embedded-systems research. The goal is moving
from *reading* SystemVerilog fluently to *writing* it reflexively, starting at
combinational primitives and climbing toward full datapath + control compositions.

## Toolchain

- **Simulator:** Verilator 5.048
- **Waveform viewer:** GTKWave
- **Editor:** VS Code / nano
- **Host:** Ubuntu 22.04 on Dell XPS 15 9500

Compile and run any session:

    cd sessionN
    verilator --binary --trace -j 0 <module>.sv tb_<module>.sv --top-module tb_<module>
    ./obj_dir/Vtb_<module>
    gtkwave wave_<module>.vcd &

## Sessions

| # | Primitive | Class | Key lesson |
|---|-----------|-------|------------|
| 1 | 2:1 mux | Combinational (1) | Combinational means no clock, no reset; `assign y = sel ? b : a;` |
| 2 | Parameterized N:1 mux | Combinational (1) | `parameter int N`, `$clog2(N)`, unpacked arrays, parameter override syntax |
| 3 | Parameterized decoder | Combinational (1) | A decoder is a shifter with a constant input; walking-1 output signature |
| 4 | Parameterized priority encoder | Combinational (1) | `always_comb` with default assignments at top; iteration direction = priority direction; `task` for reusable testbench checks |
| 5 | 8-bit adder with carry | Combinational (1) | Concatenation `{cout, sum}` on LHS forces 9-bit destination; explicit width with `{8'b0, cin}` for strict-lint compliance |
## Framework
| 6 | 8-bit magnitude comparator | Combinational (1) | Three 1-bit flags (eq/lt/gt) with trichotomy invariant; `==` `<` `>` synthesize to subtractor + carry inspection; equality is XNOR/AND only (no arithmetic) |
These primitives sit within a unifying five-class taxonomy of digital hardware:

1. **Combinational** — pure functions of inputs (mux, decoder, adder, comparator, shifter)
2. **Storage** — state across clock edges (flip-flop, register, FIFO, SRAM)
3. **Control** — sequencers and orchestrators (FSM, arbiter, timer)
4. **Interconnect** — moving data between blocks (bus, AXI, valid/ready)
5. **Physical/Analog** — interfacing with the physical world (PLL, reset, pad, TRNG, PUF)

All four sessions to date have been Class 1 (Combinational). Class 2 is next.

## Roadmap

- [x] Session 1 — 2:1 mux
- [x] Session 2 — Parameterized N:1 mux
- [x] Session 3 — Parameterized decoder
- [x] Session 4 — Parameterized priority encoder
- [x] Session 5 — 8-bit adder with carry (opens arithmetic family)
- [x] Session 6 — Comparator (equality + magnitude)
- [ ] Session 7 — Barrel shifter (mux tree, explicit)
- [ ] Session 8 — Mini-ALU (composes 5–7 — first Pattern A composition)
- [ ] Session 9+ — Class 2 storage primitives

## License

MIT — feel free to use these as reference for your own learning.
