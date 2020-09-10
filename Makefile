########################################################################
### Makefile for https://github.com/drbitboy/SPICE_prediCkt_test
########################################################################

default: out.bc

########################################################################
### Generate product C-Kernel (CK) using prediCkt utility
### Cf. https://naif.jpl.nasa.gov/pub/naif/utilities/PC_Linux_64bit/prediCkt.ug
### N.B. tolerance of 3e-3 degrees will be too tight and warning
###      messages will be present in prediCkt.log:  the prediCkt utility
###      reached its lower limit on interval length when trying to meet
###      meet the specified tolerance in between interval endpoints
########################################################################

out.bc: di_finalenc_nav_v1.bsp dif_sclkscet_00121_science.tsc naif0012.tls prediCkt
	$(RM) out.bc
	./prediCkt -furnish mk.tm -spec ck_specs -ck out.bc -tol 3e-3 -sclk dif_sclkscet_00121_science.tsc 1>prediCkt.log

########################################################################
### Make plot
### - Demonstrates the tolerance vs. interval issue described above
########################################################################

plot: out.bc
	python error_plot.py --k=mk.tm

########################################################################
### Download prediCkt utility and Deep Impact kernels as needed
### - For prediCkt, try Mac Intel OS X 64-bit first,
###   then try Linux Intel 64-bit if that does not work
###   - For more alternatives (e.g. PC_Cygwin_32bit), see
###       https://naif.jpl.nasa.gov/naif/utilities.html
########################################################################

prediCkt:
	wget -q http://naif.jpl.nasa.gov/pub/naif/utilities/MacIntel_OSX_64bit/$@
	chmod a+x $@
	./$@ -help 1>/dev/null 2>&1 || ( $(RM) -v $@ ; wget -q http://naif.jpl.nasa.gov/pub/naif/utilities/PC_Linux_64bit/$@ )
	chmod a+x $@

di_finalenc_nav_v1.bsp:
	wget -q https://naif.jpl.nasa.gov/pub/naif/DEEPIMPACT/kernels/spk/$@

dif_sclkscet_00121_science.tsc:
	wget -q https://naif.jpl.nasa.gov/pub/naif/DEEPIMPACT/kernels/sclk/$@

naif0012.tls:
	wget -q https://naif.jpl.nasa.gov/pub/naif/DEEPIMPACT/kernels/lsk/$@

########################################################################
### Remove downloaded files, product CK, and prediCkt log file
########################################################################

clean:
	$(RM) -v di_finalenc_nav_v1.bsp dif_sclkscet_00121_science.tsc naif0012.tls out.bc prediCkt prediCkt.log
