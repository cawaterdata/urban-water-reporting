Template Analysis Urban Water Managment
================
Erin Cain
2/1/2022

## Sante Fe Irrigation District

## What Reports are we looking at?

``` r
report_1 <- "Urban Water Managment Plan"
report_2 <- "Water Loss Report"
report_3 <- "Conservation Report"
report_4 <- "Electronic Annual Report"
```

## What Metric are we comparing between the reports?

``` r
metric <- "Volume Water Supplied in Acre Feet"
```

## What data are we using?

Tables Names:

-   Report 1: [Urban Water Managment
    Plan](https://wuedata.water.ca.gov/uwmp_export_2020.asp)
-   Report 2: [Urban Water Managment
    Plan](https://wuedata.water.ca.gov/awwa_export)
-   Report 3: [Conservation
    Report](https://www.waterboards.ca.gov/water_issues/programs/conservation_portal/conservation_reporting.html)
-   Report 4: [Electronic Annual
    Report](https://www.waterboards.ca.gov/drinking_water/certlic/drinkingwater/eardata.html)

What agency are we focused on?

``` r
agency_of_interest <- "Sante Fe Irrigarion District"
```

Load in data:

``` r
data_report_1 <- readxl::read_excel("../data-raw/uwmp_table_2_2_r_conv_to_af.xlsx") %>% 
  filter(WATER_SUPPLIER_NAME == "Santa Fe Irrigation District")
  
data_report_2 <- readxl::read_excel("../data-raw/water_audit_data_conv_to_af.xlsx") %>% 
  filter(REPORTING_YEAR == 2020, WATER_SUPPLIER_NAME == "Santa Fe Irrigation District") 


data_report_3 <- readxl::read_excel("../data-raw/conservation-report-uw-supplier-data120721.xlsx") %>% 
  mutate(year = lubridate::year(`Reporting Month`)) %>%
  filter(year == 2020, `Supplier Name` == "Santa Fe Irrigation District")


data_report_4 <-  read.delim("../data-raw/EAR_ResultSet_2020RY.txt")

data_report_4 <- data_report_4 %>%
  filter(WSSurveyID == 428915) %>%
  filter(SurveyName == "2020 EAR", SectionID %in% c("06 Supply-Delivery", "01 Intro")) 
```

### How is our chosen metric described in the report data?

``` r
volume_supplied_report_1 <- "VOLUME_OF_WATER_SUPPLIED_AF"
volume_supplied_report_2 <- "WS_WATER_SUPPLIED_VOL_AF"
volume_supplied_report_3 <- "REPORTED FINAL Total Potable Water Production"
volume_supplied_report_4 <- "WPAnnualTotal"
```

### Metrics

#### Urban Water Managment Plan

``` r
metric_report_1 <- data_report_1 %>% pull(volume_supplied_report_1)
metric_report_1
```

    ## [1] 9343

#### Water Loss Report

``` r
metric_report_2 <-  data_report_2 %>% pull(volume_supplied_report_2)
metric_report_2 
```

    ## [1] 8850.85

#### Conservation Report

``` r
#Check Units
data_report_3 %>% pull(`Water Production Units`) 
```

    ##  [1] "AF" "AF" "AF" "AF" "AF" "AF" "AF" "AF" "AF" "AF" "AF" "AF"

``` r
# Units are in AF
metric_report_3 <-  sum(data_report_3 %>% pull(volume_supplied_report_3))
metric_report_3 
```

    ## [1] 9687.5

#### eAR

``` r
# Check Units 
data_report_4 %>% filter(QuestionName == "WPUnitsofMeasure") %>% pull(QuestionResults)
```

    ## [1] "AF"

``` r
# Units are in AF
metric_report_4 <-  as.numeric(data_report_4 %>% filter(QuestionName == "WPAnnualTotal") %>% pull(QuestionResults))
metric_report_4 
```

    ## [1] 10085.89

### Delta of Metrics Across Reports

``` r
total_water_supply_table <- 
  tibble("agency" = rep(c("Santa Fe Irrigation District"), 6),
         "reports_compared" = c("UWMP & WLR", "UWMP & CR", "UWMP & EAR", "WLR & CR", "WLR & EAR", "CR & EAR"),
         "report_a" =  c("UWMP", "UWMP", "UWMP", "WLR", "WLR", "CR"),
         "report_b" =  c("WLR", "CR", "EAR", "CR", "EAR", "EAR"),
         "report_a_metric" = c(metric_report_1, metric_report_1, metric_report_1, metric_report_2, metric_report_2, metric_report_3), 
         "report_b_metric" = c(metric_report_2, metric_report_3, metric_report_4, metric_report_3, metric_report_4, metric_report_4),)

total_water_supply_af_deltas <- total_water_supply_table %>% 
  mutate(delta = report_a_metric - report_b_metric, percent_delta = (report_a_metric / report_b_metric - 1) * 100)

write_rds(total_water_supply_af_deltas, "../data/total_water_supply_af_deltas.rds")
knitr::kable(total_water_supply_af_deltas)
```

| agency                       | reports\_compared | report\_a | report\_b | report\_a\_metric | report\_b\_metric |    delta | percent\_delta |
|:-----------------------------|:------------------|:----------|:----------|------------------:|------------------:|---------:|---------------:|
| Santa Fe Irrigation District | UWMP & WLR        | UWMP      | WLR       |           9343.00 |           8850.85 |   492.15 |       5.560483 |
| Santa Fe Irrigation District | UWMP & CR         | UWMP      | CR        |           9343.00 |           9687.50 |  -344.50 |      -3.556129 |
| Santa Fe Irrigation District | UWMP & EAR        | UWMP      | EAR       |           9343.00 |          10085.89 |  -742.89 |      -7.365636 |
| Santa Fe Irrigation District | WLR & CR          | WLR       | CR        |           8850.85 |           9687.50 |  -836.65 |      -8.636387 |
| Santa Fe Irrigation District | WLR & EAR         | WLR       | EAR       |           8850.85 |          10085.89 | -1235.04 |     -12.245226 |
| Santa Fe Irrigation District | CR & EAR          | CR        | EAR       |           9687.50 |          10085.89 |  -398.39 |      -3.949974 |

#### UWMP and WLR

The *difference* in the Volume Water Supplied in Acre Feet between the
Urban Water Managment Plan and Water Loss Report is: 492.15 Acre Feet.

The *percent difference* is: 5.5604829 %.

#### UWMP and Conservation Report

The *difference* in the Volume Water Supplied in Acre Feet between the
Urban Water Managment Plan and Conservation Report is: -344.5 Acre Feet.

The *percent difference* is: -3.556129 %.

#### UWMP and eAR

The *difference* in the Volume Water Supplied in Acre Feet between the
Urban Water Managment Plan and Electronic Annual Report is: -742.89 Acre
Feet.

The *percent difference* is: -7.3656365 %.

#### WLR and Conservation Report

The *difference* in the Volume Water Supplied in Acre Feet between the
Water Loss Report and Conservation Report is: -836.65 Acre Feet.

The *percent difference* is: -8.6363871 %.

#### WLR and eAR

The *difference* in the Volume Water Supplied in Acre Feet between the
Water Loss Report and Electronic Annual Report is: -1235.04 Acre Feet.

The *percent difference* is: -12.2452258 %.

#### Conservation Report and eAR

The *difference* in the Volume Water Supplied in Acre Feet between the
Conservation Report and Electronic Annual Report is: -398.39 Acre Feet.

The *percent difference* is: -3.9499737 %.

### Summarizing Metric Across Reports

``` r
supply_by_report <- tibble("Report" = c(report_1, report_2, report_3, report_4),
                           "Annual AF Supply" = as.numeric(c(metric_report_1, metric_report_2, 
                                               metric_report_3, metric_report_4)))
```

``` r
library(ggplot2)
ggplot(supply_by_report, aes(y = Report, x = `Annual AF Supply`, fill = Report)) +
  geom_col() + 
  labs(x = "Reported Annual AF Supply", y = "", 
       title = "Reported Annual Water Supply Across Reporting Requirements") +
  theme_minimal() +
  theme(legend.position="none", text = element_text(size=18)) + 
  scale_fill_manual(values = wesanderson::wes_palette("Royal2"))
```

![](santa_fe_analysis_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

## Investigating Differences

The largest difference is between the eAR and the Water Loss Report.

TODO Why…?
