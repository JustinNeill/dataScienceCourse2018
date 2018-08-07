library(sf)
library(readr)
# read 1994 Metro TAZ shape file
taz_sf <- st_read("data/taz1260.shp", crs=2913)


portland94_df <- read_csv("data/portland94_geocode.raw.zip", col_names=c("uid", "X", "Y", "case_id", 
                                                                         "freq", "rtz", "sid", 
                                                                         "totemp94", "retemp94"))

portland94_df <- portland94_df %>% 
  filter(X!=0, Y!=0) %>% 
  sample_n(500)

portland94_sf <- st_as_sf(portland94_df, coords = c("X", "Y"), crs = 2913)

portland94_sf <- st_join(portland94_sf, taz_sf)
head(portland94_sf)

ggplot() +
  geom_sf(data = taz_sf, aes(alpha=0.9)) +
  geom_sf(data = portland94_sf)
