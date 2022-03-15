library(tidyverse)

supplier_id_lookup <- readxl::read_excel("data-raw/uwmp_table_2_2_r_conv_to_af.xlsx") %>% 
  transmute("supplier_name" = WATER_SUPPLIER_NAME,
            "supplier_id" = PUBLIC_WATER_SYSTEM_NUMBER) %>% 
  glimpse()


uwmp_demand <- readr::read_csv("data-raw/uwmp_retail_actual_demand_with_categories.csv") %>% 
  left_join(supplier_id_lookup, by = c("WATER_SUPPLIER_NAME" = "supplier_name")) %>%
  transmute("report_name" = "UWMP",
            "supplier_id" = supplier_id,
            "supplier_name" = WATER_SUPPLIER_NAME,
            "year" = 2020, 
            "month" = NA,
            "category" = "demand",
            "use_type" = tolower(USE_TYPE),
            "volume_af" = VOLUME_AF) %>%
  glimpse()


uwmp_demand_2 <- readr::read_csv("data-raw/uwmp_retail_total_demand.csv") %>% 
  left_join(supplier_id_lookup, by = c("WATER_SUPPLIER_NAME" = "supplier_name")) %>%
  transmute("report_name" = "UWMP",
            "supplier_id" = supplier_id,
            "supplier_name" = WATER_SUPPLIER_NAME,
            "year" = 2020, 
            "month" = NA,
            "category" = "demand total",
            "use_type" = tolower(WATER_DEMAND_TYPE),
            "volume_af" = WATER_DEMAND_VOLUME_2020) %>%
  glimpse()

uwmp_supply <- readxl::read_excel("data-raw/uwmp_table_6_8_r_conv_to_af.xlsx") %>% 
  left_join(supplier_id_lookup, by = c("WATER_SUPPLIER_NAME" = "supplier_name")) %>%
  transmute("report_name" = "UWMP",
            "supplier_id" = supplier_id, 
            "supplier_name" = WATER_SUPPLIER_NAME,
            "year" = 2020, 
            "month" = NA,
            "category" = "supply",
            "use_type" = tolower(WATER_SUPPLY),
            "volume_af" = ACTUAL_VOLUME_AF) %>% 
  glimpse()
#unique(uwmp_supply$use_type)
# Columns: Water supplier Name, Year, Report name, Supply or demand, use type, volume AF
uwmp_data <- bind_rows(uwmp_demand, uwmp_demand_2, uwmp_supply)

# WLR --------------------------------------------------------------------------
# Supply 
supply_fields <- read_rds("data/WLR_supply_fields.rds")
supply_fields <- supply_fields[!stringr::str_detect(supply_fields, "COMMENT")]
supply_fields <- supply_fields[!stringr::str_detect(supply_fields, "UNITS")]
supply_fields <- supply_fields[stringr::str_detect(supply_fields, "_AF")]
supply_fields <- supply_fields[!stringr::str_detect(supply_fields, "_ERR_")]

wlr_supply <- readxl::read_excel("data-raw/water_audit_data_conv_to_af.xlsx") %>% 
  select(WATER_SUPPLIER_NAME, PWS_ID_OR_OTHER_ID, REPORTING_YEAR, VOLUME_REPORTING_UNITS, supply_fields) %>% 
  pivot_longer(cols = supply_fields, names_to = "use_type", values_to = "volume") %>% 
  transmute("report_name" = "WLR",
            "supplier_id" = PWS_ID_OR_OTHER_ID, 
            "supplier_name" = WATER_SUPPLIER_NAME,
            "year" = REPORTING_YEAR, 
            "month" = NA,
            "category" = ifelse(use_type == "WS_WATER_SUPPLIED_VOL_AF", "supply total", "supply"),
            "use_type" = tolower(use_type),
            "volume_af" = volume) %>%
  glimpse()

# Demand
demand_fields <- read_rds("data/WLR_demand_fields.rds")
demand_fields <- demand_fields[!stringr::str_detect(demand_fields, "COMMENT")]
demand_fields <- demand_fields[stringr::str_detect(demand_fields, "_AF")]
demand_fields <- demand_fields[!stringr::str_detect(demand_fields, "_ERR_")]

wlr_demand <- readxl::read_excel("data-raw/water_audit_data_conv_to_af.xlsx") %>% 
  select(WATER_SUPPLIER_NAME, PWS_ID_OR_OTHER_ID, REPORTING_YEAR, VOLUME_REPORTING_UNITS, demand_fields) %>% 
  pivot_longer(cols = demand_fields, names_to = "use_type", values_to = "volume") %>% 
  transmute("report_name" = "WLR",
            "supplier_id" = PWS_ID_OR_OTHER_ID, 
            "supplier_name" = WATER_SUPPLIER_NAME,
            "year" = REPORTING_YEAR, 
            "month" = NA,
            "category" = ifelse(use_type == "AC_AUTH_CONSUMPTION_VOL_AF", "demand total", "demand"),
            "use_type" = tolower(use_type),
            "volume_af" = volume) %>%
  glimpse()
  
# other
other_fields <- read_rds("data/WLR_other_fields.rds")
other_fields <- other_fields[stringr::str_detect(other_fields, "^WL")]
other_fields <- other_fields[!stringr::str_detect(other_fields, "COMMENT")]
other_fields <- other_fields[stringr::str_detect(other_fields, "AF")]
other_fields <- other_fields[!stringr::str_detect(other_fields, "ERR")]

wlr_losses <- readxl::read_excel("data-raw/water_audit_data_conv_to_af.xlsx") %>% 
  select(WATER_SUPPLIER_NAME, PWS_ID_OR_OTHER_ID, REPORTING_YEAR, VOLUME_REPORTING_UNITS, other_fields) %>% 
  pivot_longer(cols = other_fields, names_to = "use_type", values_to = "volume") %>%
  transmute("report_name" = "WLR",
            "supplier_id" = PWS_ID_OR_OTHER_ID, 
            "supplier_name" = WATER_SUPPLIER_NAME,
            "year" = REPORTING_YEAR, 
            "month" = NA,
            "category" = "losses",
            "use_type" = tolower(use_type),
            "volume_af" = volume) %>%
  glimpse()
  
wlr_data <- bind_rows(wlr_demand, wlr_supply, wlr_losses)

### Conservation Report --------------------------------------------------------
# Scale volume units
scale_from_MG_to_AF <- 3.06888
scale_from_CCF_to_AF <- 1/43560
scale_from_G_to_AF <- 1/325851
  
conservation_report_data <- readxl::read_excel("data-raw/conservation-report-uw-supplier-data120721.xlsx") %>% 
  select("supplier_name" = `Supplier Name`, "supplier_id" = `Public Water System ID`, reporting_date = `Reporting Month`, units = `Water Production Units`, 
         `REPORTED PRELIMINARY Total Potable Water Production`:`REPORTED Non-Revenue Water`) %>%
  mutate(`REPORTED FINAL Total Potable Water Production` = ifelse(is.na(`REPORTED FINAL Total Potable Water Production`), 
                                                                  `REPORTED PRELIMINARY Total Potable Water Production`, 
                                                                  `REPORTED FINAL Total Potable Water Production`),
         `FINAL Percent Residential Use` = ifelse(is.na(`FINAL Percent Residential Use`), 
                                                  `PRELIMINARY Percent Residential Use`, 
                                                  `FINAL Percent Residential Use`),
         `REPORTED FINAL Commercial Agricultural Water` = ifelse(is.na(`REPORTED FINAL Commercial Agricultural Water`), 
                                                                       `REPORTED PRELIMINARY Commercial Agricultural Water`, 
                                                                       `REPORTED FINAL Commercial Agricultural Water`),
         `REPORTED FINAL Commercial, Industrial, and Institutional Water` = ifelse(is.na(`REPORTED FINAL Commercial, Industrial, and Institutional Water`), 
                                                                                         `REPORTED PRELIMINARY Commercial, Industrial, and Institutional Water`, 
                                                                                         `REPORTED FINAL Commercial, Industrial, and Institutional Water`)) %>%
  select(-`REPORTED PRELIMINARY Commercial, Industrial, and Institutional Water`, 
         -`REPORTED PRELIMINARY Commercial Agricultural Water`,
         -`PRELIMINARY Percent Residential Use`,
         -`REPORTED PRELIMINARY Total Potable Water Production`) %>%
  pivot_longer(cols = `REPORTED FINAL Total Potable Water Production`:`REPORTED Non-Revenue Water`, 
               names_to = "use_type", values_to = "volume") %>% 
  transmute("report_name" = "CR",
            "supplier_id" = supplier_id,
            "supplier_name" = supplier_name,
            "year" = lubridate::year(reporting_date), 
            "month" = lubridate::month(reporting_date),
            "category" = ifelse(use_type == "REPORTED PRELIMINARY Total Potable Water Production" |
                                use_type ==  "REPORTED FINAL Total Potable Water Production", "supply total", "demand"),
            "use_type" = tolower(use_type),
            "volume_af" = case_when(
              units == "MG" ~ volume * scale_from_MG_to_AF,
              units == "G" ~ volume * scale_from_G_to_AF,
              units == "CCF" ~ volume * scale_from_CCF_to_AF,
              units == "AF" ~ volume
            )) %>% glimpse()
  
  


# EAR --------------------------------------------------------------------------

data_report_4 <-  read.delim("data-raw/EAR_ResultSet_2020RY.txt") 

agency_name_lookup <- data_report_4 %>%
  filter(QuestionName == "PWSName") %>% 
  select(WSSurveyID, "supplier_name" = QuestionResults)

agency_id_lookup <- data_report_4 %>%
  filter(QuestionName == "PWSName") %>% 
  select(WSSurveyID, "supplier_id" = QuestionResults)

units_lookup <- data_report_4 %>%
  filter(QuestionName == "WPUnitsofMeasure") %>% 
  select(WSSurveyID, "units" = QuestionResults)

ear_supply_fields <- read_rds("data/EAR_supply_fields.rds")
ear_demand_fields <- read_rds("data/EAR_demand_fields.rds")

unique(data_report_4 %>% 
  filter(SurveyName == "2020 EAR", SectionID %in% c("06 Supply-Delivery", "01 Intro"), QuestionName == "WPUnitsofMeasure") %>% pull(QuestionResults))

# Supply 
ear_supply_data <- data_report_4 %>% 
  filter(SurveyName == "2020 EAR", SectionID %in% c("06 Supply-Delivery", "01 Intro")) %>%
  left_join(agency_name_lookup) %>%
  left_join(agency_id_lookup) %>%
  left_join(units_lookup) %>%
  filter(QuestionName %in% ear_supply_fields) %>%
  mutate(have_month = substr(QuestionName, 3, 5),
         month = ifelse(have_month %in% month.abb, match(have_month, month.abb), NA),
         QuestionName = ifelse(have_month %in% month.abb, substr(QuestionName, 6, length(QuestionName)), 
                               substr(QuestionName, 3, length(QuestionName))),
         volume = as.numeric(QuestionResults)) %>% 
  filter(!is.na(volume)) %>% 
  transmute("report_name" = "EAR",
            "supplier_name" = supplier_name,
            "year" = 2020, 
            "month" = month,
            "category" = ifelse(is.na(month), "supply total", "supply"),
            "use_type" = tolower(QuestionName),
            "volume_af" = case_when(
              units == "MG" ~ volume * scale_from_MG_to_AF,
              units == "G" ~ volume * scale_from_G_to_AF,
              units == "CCF" ~ volume * scale_from_CCF_to_AF,
              units == "AF" ~ volume
            )) %>%
  glimpse()


# Demand 
ear_demand_data <- data_report_4 %>% 
  filter(SurveyName == "2020 EAR", SectionID %in% c("06 Supply-Delivery", "01 Intro")) %>%
  left_join(agency_name_lookup) %>%
  left_join(agency_id_lookup) %>%
  left_join(units_lookup) %>%
  filter(QuestionName %in% ear_demand_fields) %>%
  mutate(have_month = substr(QuestionName, 3, 5),
         month = ifelse(have_month %in% month.abb, match(have_month, month.abb), NA),
         QuestionName = ifelse(have_month %in% month.abb, substr(QuestionName, 6, length(QuestionName)), 
                               substr(QuestionName, 3, length(QuestionName))),
         volume = as.numeric(QuestionResults)) %>% 
  filter(!is.na(volume)) %>% 
  transmute("report_name" = "EAR",
            "supplier_name" = supplier_name,
            "year" = 2020, 
            "month" = month,
            "category" = ifelse(is.na(month), "demand total", "demand"),
            "use_type" = tolower(QuestionName),
            "volume_af" = case_when(
              units == "MG" ~ volume * scale_from_MG_to_AF,
              units == "G" ~ volume * scale_from_G_to_AF,
              units == "CCF" ~ volume * scale_from_CCF_to_AF,
              units == "AF" ~ volume
            )) %>%
  glimpse()

ear_data <- bind_rows(ear_demand_data, ear_supply_data)

# Combine data for all reports -------------------------------------------------
supply_and_demand_data <- bind_rows(uwmp_data, wlr_data, conservation_report_data, ear_data)

write_rds(supply_and_demand_data, "data/supply_and_demand_data.rds")

