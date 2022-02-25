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

![](santa_fe_supply_analysis_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

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
  mutate(delta = abs(report_a_metric - report_b_metric), 
         percent_delta = abs((report_a_metric / report_b_metric - 1) * 100))

write_rds(total_water_supply_af_deltas, "../data/santa_fe_total_water_supply_af_deltas.rds")
```

### Delta Table

The table below shows the delta between the reports

``` r
clean_na = function(x){
  x %>%
    round(2) %>%
    as.character() %>%
    replace_na('-') %>%
    return()
}

delta_matrix <- total_water_supply_af_deltas %>% 
  select("Reports" = report_a, report_b, delta) %>%
  pivot_wider(names_from = "report_b", values_from = "delta")  %>%
  mutate_if(is.numeric, clean_na)


formattable(delta_matrix, list(area(col = 2:4) ~ color_tile("transparent", "pink")))
```

<table class="table table-condensed">
<thead>
<tr>
<th style="text-align:right;">
Reports
</th>
<th style="text-align:right;">
WLR
</th>
<th style="text-align:right;">
CR
</th>
<th style="text-align:right;">
EAR
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
UWMP
</td>
<td style="text-align:right;">
<span
style="display: block; padding: 0 4px; border-radius: 4px; background-color: #fff4f6">492.15</span>
</td>
<td style="text-align:right;">
<span
style="display: block; padding: 0 4px; border-radius: 4px; background-color: #ffffff">344.5
</span>
</td>
<td style="text-align:right;">
<span
style="display: block; padding: 0 4px; border-radius: 4px; background-color: #ffe2e7">742.89
</span>
</td>
</tr>
<tr>
<td style="text-align:right;">
WLR
</td>
<td style="text-align:right;">
<span style="display: block; padding: 0 4px; border-radius: 4px">-
</span>
</td>
<td style="text-align:right;">
<span
style="display: block; padding: 0 4px; border-radius: 4px; background-color: #ffdce2">836.65</span>
</td>
<td style="text-align:right;">
<span
style="display: block; padding: 0 4px; border-radius: 4px; background-color: #ffc0cb">1235.04</span>
</td>
</tr>
<tr>
<td style="text-align:right;">
CR
</td>
<td style="text-align:right;">
<span style="display: block; padding: 0 4px; border-radius: 4px">-
</span>
</td>
<td style="text-align:right;">
<span style="display: block; padding: 0 4px; border-radius: 4px">-
</span>
</td>
<td style="text-align:right;">
<span
style="display: block; padding: 0 4px; border-radius: 4px; background-color: #fffbfb">398.39
</span>
</td>
</tr>
</tbody>
</table>

### % Delta Table

The table below shows the percent delta between the reports

``` r
percent_delta_matrix <- total_water_supply_af_deltas %>% 
  select("Reports" = report_a, report_b, percent_delta) %>%
  pivot_wider(names_from = "report_b", values_from = "percent_delta") %>%
  mutate_if(is.numeric, clean_na)

formattable(percent_delta_matrix, list(area(col = 2:4) ~ color_tile("transparent", "pink")))
```

<table class="table table-condensed">
<thead>
<tr>
<th style="text-align:right;">
Reports
</th>
<th style="text-align:right;">
WLR
</th>
<th style="text-align:right;">
CR
</th>
<th style="text-align:right;">
EAR
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
UWMP
</td>
<td style="text-align:right;">
<span
style="display: block; padding: 0 4px; border-radius: 4px; background-color: #fff0f3">5.56</span>
</td>
<td style="text-align:right;">
<span
style="display: block; padding: 0 4px; border-radius: 4px; background-color: #ffffff">3.56</span>
</td>
<td style="text-align:right;">
<span
style="display: block; padding: 0 4px; border-radius: 4px; background-color: #ffe3e8">7.37
</span>
</td>
</tr>
<tr>
<td style="text-align:right;">
WLR
</td>
<td style="text-align:right;">
<span style="display: block; padding: 0 4px; border-radius: 4px">-
</span>
</td>
<td style="text-align:right;">
<span
style="display: block; padding: 0 4px; border-radius: 4px; background-color: #ffdae0">8.64</span>
</td>
<td style="text-align:right;">
<span
style="display: block; padding: 0 4px; border-radius: 4px; background-color: #ffc0cb">12.25</span>
</td>
</tr>
<tr>
<td style="text-align:right;">
CR
</td>
<td style="text-align:right;">
<span style="display: block; padding: 0 4px; border-radius: 4px">-
</span>
</td>
<td style="text-align:right;">
<span style="display: block; padding: 0 4px; border-radius: 4px">-
</span>
</td>
<td style="text-align:right;">
<span
style="display: block; padding: 0 4px; border-radius: 4px; background-color: #fffcfc">3.95
</span>
</td>
</tr>
</tbody>
</table>

## Investigating Differences

The largest difference is between the eAR and the Water Loss Report.

TODO Why…?
