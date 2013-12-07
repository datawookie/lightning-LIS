library(h5r)
library(reshape2)

HRFC = H5DataFrame("data/LISOTD_HRFC_V2.2.h5")$hrfc
#
hrfc = melt(HRFC, varnames = c("lat", "lon"), value.name = "density")

NLAT <- nrow(HRFC)
NLON <- ncol(HRFC)
#
dlat = 180 / NLAT
dlon = 360 / NLON
#
lats <- seq(-90, along = 1:NLAT, by = dlat) + dlat / 2
lons <- seq(-180, along = 1:NLON, by = dlon) + dlon / 2

hrfc$lon  = lons[hrfc$lon]
hrfc$lat  = lats[hrfc$lat]