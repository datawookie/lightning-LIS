#!/bin/bash

# The data are available from http://thunder.msfc.nasa.gov/data/.

# HR = High Resolution (0.5 degree grid)
# LR = Low Resolution (2.5 degree grid)
# FC = Annualized Climatology (full year)
# SC = Seasonal Climatology (3-monthly)
# MC = Monthly Climatology
# AC = Annual Climatology (daily)
# DC = Diurnal Climatology (hourly)
# TS = Time Series (daily or monthly)

# HRAC (High Resolution Annual Climatology)  -  365 x 720 x 360
# HRFC (High Resolution Full Climatology)    -        720 x 360
# HRMC (High Resolution Monthly Climatology) -   12 x 720 x 360
# LRAC (Low Resolution Annual Climatology)   -  365 x 144 x  72 - flashes / km^2 / day
# LRDC (Low Resolution Diurnal Climatology)  -   24 x 144 x  72
# LRMTS (Low Resolution Monthly Time Series) -  144 x 144 x  72 - flashes / km^2 / day
# LRTS (Low Resolution Time Series)          - 3653 x 144 x  72 - flashes / km^2 / day

# Convert from HDF4 to HDF5.
#
h5fromh4 -d hrfc  LISOTD_HRFC_V2.2.hdf
h5fromh4 -d hrac  LISOTD_HRAC_V2.2.hdf
h5fromh4 -d lrdc  LISOTD_LRDC_V2.2.hdf
h5fromh4 -d lrmts LISOTD_LRMTS_V2.2.hdf
