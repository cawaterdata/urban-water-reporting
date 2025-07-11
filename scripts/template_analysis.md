Template Analysis Urban Water Reporting
================
Erin Cain
2/1/2022

## Template Analysis for Urban Water Reporting

Template for streamlining analysis of urban water data reported. Fill
out each section of the template below to define the reports, metric,
and agency to compare across. The purpose of this analysis is to find
the difference and percent difference of metrics reported to multiple
reports.

## What Reports are we looking at?

``` r
report_1 <- "Urban Water Managment Plan"
report_2 <- "Water Loss Report"
```

## What Metric are we comparing between the reports?

``` r
metric <- "Volume Water Supplied in Acre Feet"
```

## What data are we using?

Tables Names:

-   Report 1: (source)
-   Report 2: (source)

What agency are we focused on? To pick this we looked across both
reports and looked for an agency that participates in both.

``` r
agency_of_interest <- "Sante Fe Irrigarion District"
```

Load in data:

``` r
data_report_1 <- readxl::read_excel("../data-raw/uwmp_table_2_2_r_conv_to_af.xlsx") %>% 
  filter(WATER_SUPPLIER_NAME == "Santa Fe Irrigation District")
data_report_1
```

    ## # A tibble: 1 x 10
    ##   ORG_ID WATER_SUPPLIER_NA~ WORKSHEET_NAME      REVIEWED_BY_DWR REQUIREMENTS_AD~
    ##    <dbl> <chr>              <chr>               <chr>           <chr>           
    ## 1   2214 Santa Fe Irrigati~ Table 2-1 Retail O~ No              N/A             
    ## # ... with 5 more variables: WP_WUEDATA_PLAN_ID <dbl>,
    ## #   PUBLIC_WATER_SYSTEM_NUMBER <chr>, PUBLIC_WATER_SYSTEM_NAME <chr>,
    ## #   NUMBER_MUNICIPAL_CONNECTIONS <dbl>, VOLUME_OF_WATER_SUPPLIED_AF <dbl>

``` r
data_report_2 <- readxl::read_excel("../data-raw/water_audit_data_conv_to_af.xlsx") %>% 
  filter(REPORTING_YEAR == 2020, WATER_SUPPLIER_NAME == "Santa Fe Irrigation District")
data_report_2
```

    ## # A tibble: 1 x 128
    ##   DWR_ORGANIZATION_ID WATER_SUPPLIER_NAME SUBMITTED_DATE      WUEDATA_PLAN_REPO~
    ##                 <dbl> <chr>               <dttm>                           <dbl>
    ## 1                2214 Santa Fe Irrigatio~ 2020-12-07 15:55:57               2019
    ## # ... with 124 more variables: CONTACT_NAME <chr>, CONTACT_EMAIL_ADDRESS <chr>,
    ## #   CONTACT_PHONE <chr>, CONTACT_PHONE_EXT <chr>, SUPPLIER_NAME <chr>,
    ## #   CITY_TOWN_MUNICIPALITY <chr>, STATE_PROVINCE <chr>, COUNTRY <chr>,
    ## #   REPORTING_YEAR <dbl>, REPORTING_YEAR_TYPE <chr>,
    ## #   REPORTING_START_DATE <dttm>, REPORTING_END_DATE <dttm>,
    ## #   AUDIT_PREPARATION_DATE <dttm>, VOLUME_REPORTING_UNITS <chr>,
    ## #   PWS_ID_OR_OTHER_ID <chr>, WS_OWN_SOURCES_VOL_COMMENT <chr>, ...

### How is our chosen metric described in the report data?

``` r
volume_supplied_report_1 <- "VOLUME_OF_WATER_SUPPLIED_AF"
volume_supplied_report_2 <- "WS_WATER_SUPPLIED_VOL_AF"
```

``` r
metric_report_1 <- data_report_1 %>% pull(volume_supplied_report_1)
metric_report_1
```

    ## [1] 9343

``` r
metric_report_2 <-  data_report_2 %>% pull(volume_supplied_report_2)
metric_report_2 
```

    ## [1] 8850.85

``` r
delta_water_supplied <- metric_report_1 - metric_report_2
delta_water_supplied
```

    ## [1] 492.15

``` r
delta_water_supplied_percent <- (metric_report_1 / metric_report_2 - 1) * 100
```

The *difference* in the Volume Water Supplied in Acre Feet between the
Urban Water Managment Plan and Water Loss Report is: 492.15 Acre Feet.

The *percent difference* is: 5.5604829 %.

## If % differnce is significant (define what significant is), why is it different?
