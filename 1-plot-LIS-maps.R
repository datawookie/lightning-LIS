library(ggmap)

if (!exists("USA")) {
  USA = get_map(location = "united states", zoom = 4, color = "bw")
}

ggmap(USA) +
  geom_raster(data = hrfc, aes(x = lon, y = lat, fill = density))
  
  stat_density2d(data = hrfc,
                 aes(x = lon, y = lat, fill = ..level.., alpha = ..level..),
                 size = 1, bins = 4,
                 geom = 'polygon')
  
  geom_point(data = hrfc, aes(x = lon, y = lat))