library(ggplot2)
library(maps)

ggplot(hrfc, aes(x = lon, y = lat)) +
  geom_raster(aes(fill = log10(density))) +
  # scale_fill_gradient(low = "white", high = "red", na.value = "white", limits = c(0, 3)) +
  scale_fill_distiller(palette = "Set1", na.value = "white") +
  geom_path(data = map_data("world"), aes(x = long, y = lat, group = group)) +
  coord_cartesian(ylim = c(-80, 90)) +
  theme_classic()

# ---------------------------------------------------------------------------------------------------------------------

library(plotly)
library(maps)

# Other type: heatmap
# Other colorscale: Greys, Greens
# colors = viridis(256)
# color = brewer.pal(n_palette, "Palette_Name")
# color = colorRampPalette(brewer.pal(11,"Spectral"))(100)

world.map <- data.frame(map(plot = FALSE)[c("x", "y")])

p <- plot_ly(data = subset(lrfc, !is.na(density)), x = lon, y = lat, z = density, type = "contour",
        zmin = 0, zmax = 70,
        zauto = FALSE,
        connectgaps = FALSE,
        contours = list(
          coloring = "heatmap",
          start = 20
        ),
        colorscale = "Blues",
        reversescale = TRUE,
        colorbar = list(title = "Flash Density")) %>%
  add_trace(data = world.map, x = x, y = y,
            type = "scatter",
            hoverinfo = "none",
            line = list(
              color = "rgb(0, 0, 0)",
              width = 1
            )) %>%
  layout(title = "LIS/OTD Low Resolution Full Climatology",
         xaxis = list(
           gridcolor = "rgb(255, 255, 255)",
           zerolinecolor = "rgb(255, 255, 255)",
           title = NA,
           tickvals = seq(-180, 180, 60)
         ),
         yaxis = list(
           gridcolor = "rgb(255, 255, 255)",
           title = NA,
           tickvals = seq(-90, 90, 30)
         )
  )

plotly_POST(p, filename="Exegetic Blog/lis-otd-lrfc")

# ---------------------------------------------------------------------------------------------------------------------

png("lis-otd-flash-density.png", width = 800, height = 600)
ggplot(lrfc, aes(x = lon, y = lat)) +
  geom_path(data = world.map, aes(x = x, y = y), lwd = 0.35) +
  geom_raster(aes(fill = density), interpolate = TRUE, alpha = 0.85) +
  geom_contour(aes(z = density), binwidth = 10, lwd = 0.5, alpha = 0.85) +
  scale_fill_distiller("Flash\nDensity", palette = "Greens", na.value = "white", direction = 1, limits = c(0, 75), breaks = seq(0, 70, 10)) +
  scale_x_continuous("", limits = c(-180, 180), breaks = seq(-180, 180, 60), expand = c(0, 0)) +
  scale_y_continuous("", limits = c(-90, 90), breaks = seq(-90, 90, 30), expand = c(0, 0)) +
  ggtitle("LIS/OTD Low Resolution Full Climatology") +
  theme_classic()
dev.off()