library(readr)

# read in data objects

# Water demand
napa_d <- read_rds(file = "data/napa_total_water_demand_af_deltas.rds") %>% 
  mutate(metric = "Total Water Demand") %>% glimpse()

santa_fe_d <- read_rds(file = "data/santa_fe_total_water_demand_af_deltas.rds") %>% 
  mutate(metric = "Total Water Demand") %>% glimpse()

# Water Supply 
napa_s <- read_rds(file = "data/napa_total_water_supply_af_deltas.rds") %>% 
  mutate(metric = "Total Water Supply") %>% glimpse()

santa_fe_s <- read_rds(file = "data/santa_fe_total_water_supply_af_deltas.rds") %>% 
  mutate(metric = "Total Water Supply") %>% glimpse()

urban_water_reporting_data <- bind_rows(napa_d, santa_fe_d, napa_s, santa_fe_s) %>% glimpse()

write_rds(urban_water_reporting_data, "data/urban_water_reporting_data.rds")
