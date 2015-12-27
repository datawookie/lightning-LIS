library(ggplot2)
library(maps)

ggplot(hrfc, aes(x = lon, y = lat)) +
  geom_raster(aes(fill = log10(density))) +
  # scale_fill_gradient(low = "white", high = "red", na.value = "white", limits = c(0, 3)) +
  scale_fill_distiller(palette = "Set1", na.value = "white") +
  geom_path(data = map_data("world"), aes(x = long, y = lat, group = group)) +
  coord_cartesian(ylim = c(-80, 90)) +
  theme_classic()