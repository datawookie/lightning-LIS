library(hdf5)

hdf5load("data/LISOTD_LRTS_V2.2.h5", verbosity = 1)

# ------------------------------------------------------------------------------

NLAT <- dim(lrts)[1]
NLON <- dim(lrts)[2]
NDAY <- dim(lrts)[3]
STARTDATE <- as.Date("1995-01-01")
READYDATE <- as.Date("1995-06-01")

dlat = 180 / NLAT
dlon = 360 / NLON

# centres of zonal/meridianal strips
#
lats <- seq(-90, along = 1:NLAT, by = dlat) + dlat/2
lons <- seq(-180, along = 1:NLON, by = dlon) + dlon/2

day.seq <- seq(STARTDATE, along = seq(NDAY), by = "day")

# sort out empty months at start and end ---------------------------------------

day.sum <- c()

for (n in seq(NDAY)) {
  day.sum <- c(day.sum, sum(lrts[,,n]))
}

# day.sum[day.sum < 0.1] <- 0
day.sum <- zapsmall(day.sum, digits = 2)

# there is an initial gradual increase in daily counts: take only from first
# peak
#
# nday.first <- which(diff(day.sum) < 0)[1]

# mail from Dennis Boccippio on 13 November 2009:
#
# I haven't worked with the LIS project since 2005, so I can't give an
# authoritative answer.    I suspect the documentation may have a typo - I
# vaguely recall that for convenience, the monthly dataset was started on 1/1/95
# (not 1/1/05), with the first couple of months being empty until the April
# launch date.
#
# The data were of low quality for approximately the first month after first
# light (Apr-May) ... if I recall, this was due to the fact that the instrument
# was run for about a month with lower noise threshold settings until we
# established the right filtering and calibration.    I think a safe window would
# be to start with data from June.   However, I think the LRTS product also
# included some centered moving average time filtering, so even June might have
# a little early low qual data embedded.
#
# -> so we will start on 01/06/95
#
nday.first <- which(day.seq == READYDATE)

# there are zeros at end too
#
nday.last <- which(day.sum[nday.first:length(day.sum)] == 0)[1] + nday.first - 2

# trim data --------------------------------------------------------------------

rm(day.sum)

day.seq = day.seq[nday.first:nday.last]
day.seq.posix <- as.POSIXlt(day.seq)

lrts = list(data = lrts[,,nday.first:nday.last], day.seq = as.POSIXlt(day.seq), dlat = dlat, dlon = dlon, lats = lats, lons = lons)

NDAY <- dim(lrts)[3]

# ------------------------------------------------------------------------------

hdf5load("data/LISOTD_HRFC_V2.2.h5", verbosity = 1)

hdf5load("data/LISOTD_HRMC_V2.2.h5", verbosity = 1)

hdf5load("data/LISOTD_HRAC_V2.2.h5", verbosity = 1)

# ------------------------------------------------------------------------------

# UNITS: lrts - flashes / km^2 / day
#
save(hrfc, lrts, hrmc, hrac, file = "lis-gridded.Rdata")
