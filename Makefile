default: out.bc

out.bc: di_finalenc_nav_v1.bsp dif_sclkscet_00121_science.tsc naif0012.tls prediCkt
	$(RM) out.bc
	./prediCkt -furnish mk.tm -spec ck_specs -ck out.bc -tol 3e-3 -sclk dif_sclkscet_00121_science.tsc 1>prediCkt.log

plot: out.bc
	python error_plot.py --k=mk.tm

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

clean:
	$(RM) -v di_finalenc_nav_v1.bsp dif_sclkscet_00121_science.tsc naif0012.tls out.bc prediCkt prediCkt.log
