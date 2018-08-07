library(sf)
library(tidycensus)
library(ggplot2)
library(mapview)
library(dplyr)

census_api_key("d0f2c72125347784000fc66f92464810874f0508", install=TRUE) 
portland_tract_medhhinc <- get_acs(geography = "tract", 
                                   year = 2016, # 2012-2016
                                   variables = "B19013_001",  # Median Household Income in the Past 12 Months
                                   state = "OR", 
                                   county = c("Washington County"),
                                   #county = c("Multnomah County", "Washington County", "Clackamas County"),
                                   geometry = TRUE)

ggplot(portland_tract_medhhinc) + 
  geom_sf(aes(fill = estimate)) +
  coord_sf(datum = NA) + theme_minimal()

mapview(portland_tract_medhhinc %>% select(estimate), 
        col.regions = sf.colors(10), alpha = 0.1)
