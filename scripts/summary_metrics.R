library(tidyverse)


# Summary metrics across reports
supply_and_demand_data <- read_rds("data/supply_and_demand_data.rds")

table(supply_and_demand_data$supplier_id)


agency_ids <- supply_and_demand_data %>% 
  group_by(supplier_id) %>% 
  summarise(num_reports = n_distinct(report_name)) %>% 
  filter(num_reports > 1) %>% 
  pull(supplier_id)

all_demand_metrics <- tibble()
delta_metrics <- tibble()

agency_ids <- "CA4510014"

get_demand_tables <- function(agency_ids){
  supply_and_demand_data <- supply_and_demand_data %>% filter(supplier_id == agency_ids)   
    
  # UWMP 
  uwmp_demand_table <- supply_and_demand_data %>% filter(report_name == "UWMP", category == "demand" | category == "demand total" & 
                                                             use_type == "recycled water demand")
  uwmp_total_demand <- sum(supply_and_demand_data %>% filter(report_name == "UWMP", category == "demand") %>% pull(volume_af), na.rm = T) # Summing together categories describes above
  
  uwmp_recycled_water <- sum(supply_and_demand_data %>% filter(report_name == "UWMP", 
                                                               category == "demand total", 
                                                               use_type == "recycled water demand") %>% 
                               pull(volume_af), na.rm = T)
  
  uwmp_metric <- uwmp_total_demand + uwmp_recycled_water
  uwmp_metric
    
  # Conservation Report 
  cr_supply_2020 <- supply_and_demand_data %>% 
    filter(report_name == "CR", year == 2020, category == "supply total") %>% 
    select(-use_type, -category) %>%
    rename("supply_total" = volume_af)
  
  cr_demand_table <- supply_and_demand_data %>% 
    filter(report_name == "CR", year == 2020, category == "demand") %>% 
    left_join(cr_supply_2020) %>%
    mutate(volume_af = ifelse(use_type == "final percent residential use", (volume_af / 100) * supply_total, volume_af),
           use_type = ifelse(use_type == "final percent residential use", "final residential use", use_type)) %>%
    select(-supply_total) %>% 
    group_by(use_type) %>%
    summarise(volume_af = sum(volume_af, na.rm = T)) %>%
    ungroup() %>%
    mutate(report_name = "CR", 
           supplier_id = agency_ids,
           year = 2020, 
           category = "demand")
  
  
  residential_demand <- sum(supply_and_demand_data %>% 
                              filter(report_name == "CR", year == 2020, 
                                     category == "supply total") %>% 
                              pull(volume_af) * 
                              (supply_and_demand_data %>% 
                                 filter(report_name == "CR", year == 2020, 
                                        category == "demand", use_type == "final percent residential use") %>% 
                                 pull(volume_af))/100, na.rm = T) 
  
  commercial_agriculture_demand <- sum(supply_and_demand_data %>% filter(report_name == "CR", year == 2020, 
                                                                         category == "demand", 
                                                                         use_type == "reported final commercial agricultural water") %>% pull(volume_af), na.rm = T)
  
  commercial_industrial_institutional_demand <- sum(supply_and_demand_data %>% filter(report_name == "CR", year == 2020, 
                                                                                      category == "demand", 
                                                                                      use_type == "reported final commercial, industrial, and institutional water") %>% pull(volume_af), na.rm = T)
  
  recycled_demand <- sum(supply_and_demand_data %>% filter(report_name == "CR", year == 2020, 
                                                           category == "demand", 
                                                           use_type == "reported recycled water") %>% pull(volume_af), na.rm = T)
  
  non_revenue_demand <- sum(supply_and_demand_data %>% filter(report_name == "CR", year == 2020, 
                                                              category == "demand", 
                                                              use_type == "reported non-revenue water") %>% pull(volume_af), na.rm = T)
  
  # Water Loss 
  wlr_demand_table <- supply_and_demand_data %>% filter(report_name == "WLR", year == 2020, category == "demand" | 
                                                          category == "losses" & use_type == "wl_water_losses_vol_af" |
                                                          category == "supply"& use_type == "ws_exported_vol_af")
  
  wlr_authorized_consumption <- ifelse(nrow(wlr_demand_table) == 0, NA, supply_and_demand_data %>% filter(report_name == "WLR", year == 2020, category == "demand total") %>% pull(volume_af))
  
  wlr_losses <- ifelse(nrow(wlr_demand_table) == 0, NA, supply_and_demand_data %>% filter(report_name == "WLR", year == 2020, 
                                                  category == "losses", use_type == "wl_water_losses_vol_af") %>% pull(volume_af))
  
   
  
  wlr_exports <- ifelse(nrow(wlr_demand_table) == 0, NA, supply_and_demand_data %>% filter(report_name == "WLR", year == 2020, 
                                                   category == "supply", use_type == "ws_exported_vol_af") %>% pull(volume_af))
  
  wlr_metric <- wlr_authorized_consumption + wlr_losses + wlr_exports
  
  
  
  # Units are in AF
  cr_metric <-  sum(residential_demand, commercial_agriculture_demand, commercial_industrial_institutional_demand, recycled_demand, non_revenue_demand, na.rm = T)
  
  
  # EAR Demand 
  ear_demand_table <- supply_and_demand_data %>% 
    filter(report_name == "EAR", year == 2020, category == "demand", use_type != "Total") %>% 
    group_by(use_type) %>%
    summarise(volume_af = sum(volume_af, na.rm = T)) %>%
    ungroup() %>%
    mutate(report_name = "EAR", 
           supplier_name = "NAPA, CITY OF",
           year = 2020, 
           category = "demand")
  
  ear_metric <-  ifelse(nrow(ear_demand_table == 0), NA, supply_and_demand_data %>% filter(report_name == "EAR", 
                                                                                          year == 2020, 
                                                                                          category == "demand total", 
                                                                                          use_type == "annualtotal") %>% 
                               pull(volume_af))
  
  
  demand_by_report <- tibble(
    "Agency" = rep(agency_ids, 4),
    "Report" = c("Urban Water Management Plan", "Water Loss Report", "Conservation Report", "Electronic Annual Report"),
    "Volume AF" = as.numeric(c(uwmp_metric, wlr_metric, cr_metric, ear_metric)),
    "Metric" = rep("Annual Total Demand", 4))
  demand_by_report
  print(agency_ids)
  all_demand_metrics <- bind_rows(all_demand_metrics, demand_by_report)
  
  total_water_demand_table <- 
    tibble("agency" = rep(c(agency_ids), 6),
           "reports_compared" = c("UWMP & WLR", "UWMP & CR", "UWMP & EAR", 
                                  "WLR & CR", "WLR & EAR", "CR & EAR"),
           "report_a" =  c("UWMP", "UWMP", "UWMP", "WLR", "WLR", "CR"),
           "report_b" =  c("WLR", "CR", "EAR", "CR", "EAR", "EAR"),
           "report_a_metric" = c(uwmp_metric, uwmp_metric, uwmp_metric,
                                 wlr_metric, wlr_metric, cr_metric), 
           "report_b_metric" = c(wlr_metric, cr_metric, ear_metric, 
                                 cr_metric, ear_metric, ear_metric),)
  
  total_water_demand_af_deltas <- total_water_demand_table %>% 
    mutate(delta = abs(report_a_metric - report_b_metric), 
           percent_delta = abs((report_a_metric / report_b_metric - 1) * 100))
  
  delta_metrics <-  bind_rows(total_water_demand_af_deltas, delta_metrics)
  
  return(delta_metrics)
}

tables <- purrr::map_df(agency_ids, get_demand_tables)

delta_demands <- purrr::map_df(agency_ids, get_demand_tables)

mean_delta_by_report_combinations <- delta_demands %>% 
  group_by(reports_compared) %>% 
  summarise(mean_delta = mean(delta, na.rm = T),
            mean_percent_delta = mean(percent_delta, na.rm = T))
  