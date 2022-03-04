library(readr)
library(tidyverse)
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



report_a_metrics <- urban_water_reporting_data %>% select(agency, "report" = report_a, "volume_af" = report_a_metric, metric)

report_b_metrics <- urban_water_reporting_data %>% select(agency, "report" = report_b, "volume_af" = report_b_metric, metric)

supply_and_demand_volume_af <- bind_rows(report_a_metrics, report_b_metrics) %>% unique()

write_rds(supply_and_demand_volume_af, "data/supply_and_demand_volume_af.rds")
