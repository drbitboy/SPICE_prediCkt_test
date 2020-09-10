# Test of NAIF/SPICE utility prediCkt

## Create synthetic NAIF/SPICE C-kernel (CK) file

* CK will contain attitude (pointing) of Deep Impact Flyby (DIF) Spacecraft frame
* For 8h, approximately 6h before and 2h after, DIF Closest Approach to comet 9P/Tempel 1
* -X axis of DIF frame will point toward comet
* -Z axis of DIF frame will be as close as possible to DIF velocity vector


## Usage

    make [clean] [default|plot]

## Interval vs. tolerance

The plots below show the error between the boresight (DIF frame -X) and the direction to 9P/Tempel 1, in orange,
as well as the roll error (how much the XZ plane of the DIF frame is different from the trajectory plane), in blue.
The latter error is zero.
For the former (boresight) error,
the tolerance of 3mdeg provided to the prediCkt utility was met except around closest approach CA,
when angular acceleration is largest, and the minimum interval hard-coded into prediCkt is around 1s,
which was too large for the Type 3 C-Kernel format's linear interpolation algorithm to keep the frame
attitude within the tolerance.

 ![](https://github.com/drbitboy/SPICE_prediCkt_test/raw/master/img/full_plot.png)

The second plot, below,  shows a window of the first plot around CA, where it can be seen that the
errors are greater some away from CA; this is likely when the angle between the S/C-Comet
vector and the S/C track is sixty degrees, when the angular acceleration is the greatest.

 ![](https://github.com/drbitboy/SPICE_prediCkt_test/raw/master/img/sub_plot.png)

## Manifest
* ck_specs - Input to prediCkt utility
* Makefile - Commands to perform various tasks via [make] utility
* mk.tm - SPICE meta-kernel
* error_plot.py - Script to plot results (Python; matplotlib)
* README.md - this file

## Other files produced or downloaded by Makefile

* out.bc - C-Kernel product
* dif_sclkscet_00121_science.tsc - SPICE kernel from NAIF
* di_finalenc_nav_v1.bsp - SPICE kernel from NAIF
* naif0012.tls - SPICE kernel from NAIF
* prediCkt - prediCkt utility binary from NAIF
* prediCkt.log - output log from prediCkt
