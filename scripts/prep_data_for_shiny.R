library(readr)

# read in data objects

# Water demand
napa <- read_rds(file = "data/napa_total_water_demand_af_deltas.rds") %>% 
  select(report_a, report_b, delta) %>%
  pivot_wider(names_from = "report_b", values_from = "delta") %>%
  glimpse()

santa_fe <- read_rds(file = "data/santa_fe_total_water_demand_af_deltas.rds") %>% glimpse()

# Water Supply 
read_rds(file = "data/napa_total_water_supply_af_deltas.rds") %>% glimpse()

read_rds(file = "data/santa_fe_total_water_supply_af_deltas.rds") %>% glimpse()