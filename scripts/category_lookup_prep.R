library(tidyverse)

# load in clean dataset to look at 
dat_raw <- readRDS("data/supply_and_demand_data.rds")
dat <- dat_raw %>%
  mutate(use_type = tolower(use_type))

# categories
use <- dat %>%
  filter(grepl("demand", category))
supply <- dat %>%
  filter(grepl("supply", category))  
losses <- dat %>%
  filter(category == "losses")  

# Use type lookup table --------------------------------------------------
# uwmp ####
uwmp_use <- use %>%
  filter(report_name == "UWMP", category == "demand") %>%
  distinct(use_type)
uwmp_use_total <- use %>%
  filter(report_name == "UWMP", category == "demand total") %>%
  distinct(use_type)

# wlr ####
wlr_use <- use %>%
  filter(report_name == "WLR", category == "demand") %>%
  distinct(use_type)
wlr_use_total <- use %>%
  filter(report_name == "WLR", category == "demand total") %>%
  distinct(use_type)

# cr ####
cr_use <- use %>%
  filter(report_name == "CR", category == "demand") %>%
  distinct(use_type)
cr_use_total <- use %>%
  filter(report_name == "CR", category == "demand total") %>%
  distinct(use_type)

# ear ####
ear_use <- use %>%
  filter(report_name == "EAR", category == "demand") %>%
  distinct(use_type)
ear_use_total <- use %>%
  filter(report_name == "EAR", category == "demand total") %>%
  distinct(use_type)

# types ####
# use this table for initial reference and comparison
combined_use <- uwmp_use %>%
  mutate(UWMP = use_type) %>%
  bind_rows(wlr_use %>%
              mutate(UWMP = NA,
                     WLR = use_type)) %>%
  mutate(CR = case_when(use_type %in% c("multi-family", "single family") ~ "final percent residential use",
                        use_type == "agricultural irrigation" ~ "reported final commercial agricultural water",
                        use_type %in% c("commercial", "industrial", "institutional/governmental") ~ "reported final commercial, industrial, and institutional water",
                        use_type == "other non-potable" ~ "reported recycled water",
                        use_type == "losses" ~ "reported non-revenue water"),
         EAR = case_when(use_type == "single family" ~ "annualsf",
                         use_type == "multi-family" ~ "annualmf",
                         use_type == "commercial" ~ "annualci",
                         use_type == "industrial" ~ "annuali",
                         use_type == "landscape" ~ "annualli",
                         use_type == "other" ~ "annualo",
                         use_type == "agricultural irrigation" ~ "annuala",
                         use_type == "sales/transfers/exchanges to other agencies" ~ "annualop"))
# type lists ####
# used the categories i created on the combined data dictionary to condense the use type categories
agricultural_irrigation <- c("agricultural irrigation", "reported final commercial agricultural water", "annuala")
billed <- c("ac_bill_meter_vol_af", "ac_bill_unmeter_vol_af")
cii <- c("commercial", "industrial", "institutional/governmental", "reported final commercial, industrial, and institutional water", "annualci", "annuali")
groundwater_recharge <- c("groundwater recharge")
landscape <- c("landscape", "annualli")
losses <- c("losses")
residential <- c("multi-family", "single family", "final percent residential use")
sales_transfers_exchanges <- c("sales/transfers/exchanges to other agencies", "annualop")
saline_water_intrusion_barrier <- c("saline water intrusion barrier")
# surface_water_augmentation <- c() # I thought the UWMP reports this but don't see it in the data
unbilled <- c("ac_unbill_meter_vol_af", "ac_unbill_unmeter_vol_af")
wetlands_wildlife_habitat <- c("wetlands or wildlife habitat")
other <- c("other", "other potable", "other non-potable", "annualo")

# use_type, use_term, report table #####
use_type_table <- combined_use %>%
  mutate(use_type = case_when(UWMP %in% agricultural_irrigation ~ "agricultural irrigation",
                              WLR %in% billed ~ "billed",
                              UWMP %in% cii ~ "commerical industrial institutional",
                              UWMP %in% groundwater_recharge ~ "groundwater recharge",
                              UWMP %in% landscape ~ "landscape",
                              UWMP %in% losses ~ "losses",
                              UWMP %in% residential ~ "residential",
                              UWMP %in% sales_transfers_exchanges ~ "sales transfers exchanges to other agencies",
                              UWMP %in% saline_water_intrusion_barrier ~ "saline water intrusion barrier",
                              WLR %in% unbilled ~ "unbilled",
                              UWMP %in% wetlands_wildlife_habitat ~ "wetlands or wildlife habitat",
                              UWMP %in% other ~ "other")) %>%
  pivot_longer(cols = UWMP:EAR, names_to = "report", values_to = "use_term")

saveRDS(use_type_table, "data/use_type_lookup.rds")


# Supply types ------------------------------------------------------------

# uwmp ####
uwmp_supply <- supply %>%
  filter(report_name == "UWMP", category == "supply") %>%
  distinct(use_type)
uwmp_supply_total <- supply %>%
  filter(report_name == "UWMP", category == "supply total") %>%
  distinct(use_type)

# wlr ####
wlr_supply <- supply %>%
  filter(report_name == "WLR", category == "supply") %>%
  distinct(use_type)
wlr_supply_total <- supply %>%
  filter(report_name == "WLR", category == "supply total") %>%
  distinct(use_type)

# cr ####
cr_supply <- supply %>%
  filter(report_name == "CR", category == "supply") %>%
  distinct(use_type)
cr_supply_total <- supply %>%
  filter(report_name == "CR", category == "supply total") %>%
  distinct(use_type)

# ear ####
ear_supply <- supply %>%
  filter(report_name == "EAR", category == "supply") %>%
  distinct(use_type)
ear_supply_total <- supply %>%
  filter(report_name == "EAR", category == "supply total") %>%
  distinct(use_type)

# types ####
# use this table for initial reference and comparison
combined_supply <- uwmp_use %>%
  mutate(UWMP = use_type) %>%
  bind_rows(wlr_use %>%
              mutate(UWMP = NA,
                     WLR = use_type)) %>%
  mutate(CR = case_when(use_type %in% c("multi-family", "single family") ~ "final percent residential use",
                        use_type == "agricultural irrigation" ~ "reported final commercial agricultural water",
                        use_type %in% c("commercial", "industrial", "institutional/governmental") ~ "reported final commercial, industrial, and institutional water",
                        use_type == "other non-potable" ~ "reported recycled water",
                        use_type == "losses" ~ "reported non-revenue water"),
         EAR = case_when(use_type == "single family" ~ "annualsf",
                         use_type == "multi-family" ~ "annualmf",
                         use_type == "commercial" ~ "annualci",
                         use_type == "industrial" ~ "annuali",
                         use_type == "landscape" ~ "annualli",
                         use_type == "other" ~ "annualo",
                         use_type == "agricultural irrigation" ~ "annuala",
                         use_type == "sales/transfers/exchanges to other agencies" ~ "annualop"))

# Losses ------------------------------------------------------------------
uwmp_losses <- losses %>%
  filter(report_name == "UWMP") %>%
  distinct(use_type)
wlr_losses <- losses %>%
  filter(report_name == "WLR") %>%
  distinct(use_type)
cr_losses <- losses %>%
  filter(report_name == "CR") %>%
  distinct(use_type)
ear_losses <- losses %>%
  filter(report_name == "EAR") %>%
  distinct(use_type)