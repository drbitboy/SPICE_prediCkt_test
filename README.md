# Test of NAIF/SPICE utility prediCkt

## Create synthetic NAIF/SPICE C-kernel (CK) file

* CK will contain attitude (pointing) of Deep Impact Flyby (DIF) Spacecraft frem
* For 8h, approximater 6h before and 2h after, DIF Closest Approach to comet 9P/Tempel 1
* -X axis of DIF frame will point toward comet
* -Z axis of DIF frame will be as close as possible to DIF velocity vector


## Usage

    make [clean] [default|plot]

## Manifest
* ck_specs - Input to prediCkt utility
* Makefile - Commands to perform various tasks via [make] utility
* mk.tm - SPICE meta-kernel
* error_plot.py - Script to plot results (Python; matplotlib)
* README.md - this file

## Other files produced by Makerile

* out.bc - C-Kernel product
* dif_sclkscet_00121_science.tsc - SPICE kernel from NAIF
* di_finalenc_nav_v1.bsp - "
* naif0012.tls - "
* prediCkt - prediCkt utility binary from NAIF
* prediCkt.log - output log from prediCkt
