mk.tm:  SPICE Meta-kernel

- Used by https://github.com/drbitboy/SPICE_prediCkt_test

1) Kernels used by prediCkt and by error_plot.py

\begindata
  KERNELS_TO_LOAD = (
    'di_finalenc_nav_v1.bsp'
    'dif_sclkscet_00121_science.tsc'
    'naif0012.tls'
  )
\begintext

2) Define DIF_SPACECRAFT frame; extracted from
    https://naif.jpl.nasa.gov/pub/naif/DEEPIMPACT/kernels/fk/di_v18.tf

\begindata
  FRAME_DIF_SPACECRAFT     = -140000
  FRAME_-140000_NAME       = 'DIF_SPACECRAFT'
  FRAME_-140000_CLASS      = 3
  FRAME_-140000_CLASS_ID   = -140000
  FRAME_-140000_CENTER     = -140
  CK_-140000_SCLK          = -140
  CK_-140000_SPK           = -140
\begintext
