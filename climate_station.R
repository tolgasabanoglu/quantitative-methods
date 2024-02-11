# Load necessary libraries
library("gstat")
library("mapview")
library("sf")
library("sp")
library("ggplot2")

# Load precipitation dataset
nieder <- read_sf('~/Downloads/data 2/nieder_1981-2010_aktStandort.csv')

# Filter data for Brandenburg
nieder <- nieder[nieder$state == 'Brandenburg',]

# Set the coordinate reference system to WGS-84
proj <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"
nieder <- st_as_sf(nieder, coords=c('x','y'), crs=proj)

# Plot the original dataset
plot(st_geometry(nieder))
nieder_geo <- st_transform(nieder, "EPSG:3035")
mapview(nieder_geo)

# Create a map of annual precipitation using Inverse Distance Weighted Interpolation
bbox <- st_bbox(nieder_geo)

nieder_grid <- nieder_geo %>% 
                 st_bbox() %>%    
                 st_as_sfc() %>%  
                 st_make_grid(     
                  cellsize = c(500, 500), 
                  what = "centers") %>%
                 st_as_sf(crs=st_crs(nieder_geo))

nieder_sp <- as(nieder_geo, "Spatial")
nieder_grid_sp <- as(as(nieder_grid, "Spatial"), "SpatialPixels")

zn.idw <- idw(year ~ 1, locations=nieder_sp, newdata=nieder_grid_sp, idp = 2)

# Plot the Inverse Distance Weighted Interpolation results
plot(zn.idw["var1.pred"])
points(nieder_sp, col="white", cex=0.5)

# Create a map of annual precipitation using ordinary kriging with constant intercept
nieder_sp$year <- as.numeric(nieder_sp$year)
nieder.v <- variogram(log(year) ~ 1, nieder_sp)
nieder.vfit <- fit.variogram(nieder.v, vgm(1, "Sph", 800, 1))
lz.ok <- krige(log(year) ~ 1, nieder_sp, nieder_grid_sp, nieder.vfit)

# Plot the ordinary kriging results
plot(lz.ok['var1.pred'])
