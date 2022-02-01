Template Analysis Urban Water Managment
================
Erin Cain
2/1/2022

## Template Analysis for Urban Water Managment

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

Source:

Tables Names: - Report 1: - Report 2:

What agency are we focused on? To pick this we looked across both
reports and looked for an agency that participates in both.

``` r
agency_of_interest <- "Healdsburg  City Of"
```

Load in data:

``` r
data_report_1 <- readxl::read_excel("data-raw/uwmp_table_2_2_r_conv_to_af.xlsx") %>% 
  filter(WATER_SUPPLIER_NAME == "Healdsburg  City Of") %>%
  glimpse()
```

    ## Rows: 1
    ## Columns: 10
    ## $ ORG_ID                       <dbl> 1144
    ## $ WATER_SUPPLIER_NAME          <chr> "Healdsburg  City Of"
    ## $ WORKSHEET_NAME               <chr> "Table 2-1 Retail Only: Public Water Syst~
    ## $ REVIEWED_BY_DWR              <chr> "No"
    ## $ REQUIREMENTS_ADDRESSED       <chr> "N/A"
    ## $ WP_WUEDATA_PLAN_ID           <dbl> 6619
    ## $ PUBLIC_WATER_SYSTEM_NUMBER   <chr> "CA4910005"
    ## $ PUBLIC_WATER_SYSTEM_NAME     <chr> "City of Healdsburg"
    ## $ NUMBER_MUNICIPAL_CONNECTIONS <dbl> 4352
    ## $ VOLUME_OF_WATER_SUPPLIED_AF  <dbl> 2037.742

``` r
data_report_2 <- readxl::read_excel("data-raw/water_audit_data_conv_to_af.xlsx") %>% 
  filter(REPORTING_YEAR == 2020, WATER_SUPPLIER_NAME == "Healdsburg  City Of") %>% 
  glimpse()
```

    ## Rows: 1
    ## Columns: 128
    ## $ DWR_ORGANIZATION_ID            <dbl> 1144
    ## $ WATER_SUPPLIER_NAME            <chr> "Healdsburg  City Of"
    ## $ SUBMITTED_DATE                 <dttm> 2021-08-11 14:19:54
    ## $ WUEDATA_PLAN_REPORT_YEAR       <dbl> 2020
    ## $ CONTACT_NAME                   <chr> "Patrick Fuss"
    ## $ CONTACT_EMAIL_ADDRESS          <chr> "pfuss@ci.healdsburg.ca.us"
    ## $ CONTACT_PHONE                  <chr> "707-217-3218"
    ## $ CONTACT_PHONE_EXT              <chr> NA
    ## $ SUPPLIER_NAME                  <chr> "City of Healdsburg"
    ## $ CITY_TOWN_MUNICIPALITY         <chr> "Healdsburg"
    ## $ STATE_PROVINCE                 <chr> "California (CA)"
    ## $ COUNTRY                        <chr> "USA"
    ## $ REPORTING_YEAR                 <dbl> 2020
    ## $ REPORTING_YEAR_TYPE            <chr> "Calendar Year"
    ## $ REPORTING_START_DATE           <dttm> 2020-01-01
    ## $ REPORTING_END_DATE             <dttm> 2020-12-31
    ## $ AUDIT_PREPARATION_DATE         <dttm> 2021-04-06
    ## $ VOLUME_REPORTING_UNITS         <chr> "Million gallons (US)"
    ## $ PWS_ID_OR_OTHER_ID             <chr> "CA4910005"
    ## $ WS_OWN_SOURCES_VOL_COMMENT     <chr> "5"
    ## $ WS_OWN_SOURCES_VOL             <dbl> 661.46
    ## $ WS_OWN_SOURCES_VOL_AF          <dbl> 2029.947
    ## $ WS_OWN_SOURCES_ERR_COMMENT     <chr> "3"
    ## $ WS_OWN_SOURCES_ERR_ADJ_TYPE    <dbl> 1
    ## $ WS_OWN_SOURCES_ERR_PERCENT     <dbl> NA
    ## $ WS_OWN_SOURCES_ERR_VOL         <dbl> NA
    ## $ WS_OWN_SOURCES_ERR_VOL_AF      <dbl> NA
    ## $ WS_IMPORTED_VOL_COMMENT        <chr> "n/a"
    ## $ WS_IMPORTED_VOL                <dbl> NA
    ## $ WS_IMPORTED_VOL_AF             <dbl> NA
    ## $ WS_IMPORTED_ERR_COMMENT        <chr> NA
    ## $ WS_IMPORTED_ERR_ADJ_TYPE       <dbl> 1
    ## $ WS_IMPORTED_ERR_PERCENT        <dbl> NA
    ## $ WS_IMPORTED_ERR_VOL            <dbl> NA
    ## $ WS_IMPORTED_ERR_VOL_AF         <dbl> NA
    ## $ WS_EXPORTED_VOL_COMMENT        <chr> "n/a"
    ## $ WS_EXPORTED_VOL                <dbl> NA
    ## $ WS_EXPORTED_VOL_AF             <dbl> NA
    ## $ WS_EXPORTED_ERR_COMMENT        <chr> NA
    ## $ WS_EXPORTED_ERR_ADJ_TYPE       <dbl> 1
    ## $ WS_EXPORTED_ERR_PERCENT        <dbl> NA
    ## $ WS_EXPORTED_ERR_VOL            <dbl> NA
    ## $ WS_EXPORTED_ERR_VOL_AF         <dbl> NA
    ## $ WS_WATER_SUPPLIED_VOL          <dbl> 661.46
    ## $ WS_WATER_SUPPLIED_VOL_AF       <dbl> 2029.947
    ## $ AC_BILL_METER_VOL_COMMENT      <chr> "5"
    ## $ AC_BILL_METER_VOL              <dbl> 628.04
    ## $ AC_BILL_METER_VOL_AF           <dbl> 1927.384
    ## $ AC_BILL_UNMETER_VOL_COMMENT    <chr> "n/a"
    ## $ AC_BILL_UNMETER_VOL            <dbl> NA
    ## $ AC_BILL_UNMETER_VOL_AF         <dbl> NA
    ## $ AC_UNBILL_METER_VOL_COMMENT    <chr> "9"
    ## $ AC_UNBILL_METER_VOL            <dbl> 0.03
    ## $ AC_UNBILL_METER_VOL_AF         <dbl> 0.09206664
    ## $ AC_UNBILL_UNMETER_VOL_COMMENT  <dbl> 5
    ## $ AC_UNBILL_UNMETER_VOL          <dbl> 1.65365
    ## $ AC_UNBILL_UNMETER_VOL_AF       <dbl> 5.074866
    ## $ AC_UNBILL_UNMETER_ERR_ADJ_TYPE <dbl> 2
    ## $ AC_UNBILL_UNMETER_ERR_PERCENT  <dbl> 0.0125
    ## $ AC_UNBILL_UNMETER_ERR_VOL      <dbl> 1.65365
    ## $ AC_UNBILL_UNMETER_ERR_VOL_AF   <dbl> 5.074866
    ## $ AC_AUTH_CONSUMPTION_VOL        <dbl> 629.7237
    ## $ AC_AUTH_CONSUMPTION_VOL_AF     <dbl> 1932.551
    ## $ WL_UNAUTH_CONS_VOL_COMMENT     <dbl> NA
    ## $ WL_UNAUTH_CONS_VOL             <dbl> 1.65365
    ## $ WL_UNAUTH_CONS_VOL_AF          <dbl> 5.074866
    ## $ WL_UNAUTH_CONS_ERR_ADJ_TYPE    <dbl> 1
    ## $ WL_UNAUTH_CONS_ERR_PERCENT     <dbl> 0.0025
    ## $ WL_UNAUTH_CONS_ERR_VOL         <dbl> NA
    ## $ WL_UNAUTH_CONS_ERR_VOL_AF      <dbl> NA
    ## $ WL_CUST_MTR_INACC_VOL_COMMENT  <dbl> 4
    ## $ WL_CUST_MTR_INACC_VOL          <dbl> 6.344141
    ## $ WL_CUST_MTR_INACC_VOL_AF       <dbl> 19.46946
    ## $ WL_CUST_MTR_INACC_ERR_ADJ_TYPE <dbl> 1
    ## $ WL_CUST_MTR_INACC_ERR_PERCENT  <dbl> 0.01
    ## $ WL_CUST_MTR_INACC_ERR_VOL      <dbl> NA
    ## $ WL_CUST_MTR_INACC_ERR_VOL_AF   <dbl> NA
    ## $ WL_SYS_DATA_ERR_VOL_COMMENT    <dbl> NA
    ## $ WL_SYS_DATA_ERR_VOL            <dbl> 1.5701
    ## $ WL_SYS_DATA_ERR_VOL_AF         <dbl> 4.818461
    ## $ WL_SYS_DATA_ERR_ERR_ADJ_TYPE   <dbl> 1
    ## $ WL_SYS_DATA_ERR_ERR_PERCENT    <dbl> 0.0025
    ## $ WL_SYS_DATA_ERR_ERR_VOL        <dbl> NA
    ## $ WL_SYS_DATA_ERR_ERR_VOL_AF     <dbl> NA
    ## $ WL_APPARENT_LOSSES_VOL         <dbl> 9.567891
    ## $ WL_APPARENT_LOSSES_VOL_AF      <dbl> 29.36279
    ## $ WL_REAL_LOSSES_VOL             <dbl> 22.16846
    ## $ WL_REAL_LOSSES_VOL_AF          <dbl> 68.03251
    ## $ WL_WATER_LOSSES_VOL            <dbl> 31.73635
    ## $ WL_WATER_LOSSES_VOL_AF         <dbl> 97.3953
    ## $ NRW_NON_REVENUE_WATER_VOL      <dbl> 33.42
    ## $ NRW_NON_REVENUE_WATER_VOL_AF   <dbl> 102.5622
    ## $ SD_LENGTH_MAINS_COMMENT        <dbl> 7
    ## $ SD_LENGTH_MAINS_MILES          <dbl> 69
    ## $ SD_NUM_SERVICE_CONN_COMMENT    <dbl> 7
    ## $ SD_NUM_SERVICE_CONN            <dbl> 4538
    ## $ SD_SERVICE_CON_DENSITY         <dbl> 65.76812
    ## $ SD_CUST_MTR_CURB_PROP_COMMENT  <dbl> NA
    ## $ SD_CUST_MTR_CURB_PROP_YES_NO   <chr> "Yes"
    ## $ SD_AVG_OPER_PRESSURE_COMMENT   <dbl> 5
    ## $ SD_AVG_OPER_PRESSURE_PSI       <dbl> 44
    ## $ CD_TOTAL_ANNUAL_COST_COMMENT   <dbl> 10
    ## $ CD_TOTAL_ANNUAL_COST           <dbl> 5893133
    ## $ CD_CUST_RET_UNIT_COST_COMMENT  <dbl> 10
    ## $ CD_CUST_RET_UNIT_COST          <dbl> 5.51
    ## $ CD_CUST_RET_UNIT_COST_UNITS    <chr> "$/100 cubic feet (ccf)"
    ## $ CD_VARIABLE_PROD_COST_COMMENT  <dbl> 5
    ## $ CD_VARIABLE_PROD_COST          <dbl> 472.67
    ## $ WATER_AUDIT_VALIDITY_SCORE     <chr> "61"
    ## $ PRIORITY_AREA_1                <chr> "1: Volume from own sources"
    ## $ PRIORITY_AREA_2                <lgl> NA
    ## $ PRIORITY_AREA_3                <lgl> NA
    ## $ SA_APPARENT_LOSSES_VOL         <dbl> 9.567891
    ## $ SA_REAL_LOSSES_VOL             <dbl> 22.16846
    ## $ SA_WATER_LOSSES_VOL            <dbl> 31.73635
    ## $ SA_UNAVOID_ANN_REAL_LOSSES_VOL <dbl> 16.92708
    ## $ SA_APPARENT_LOSSES_ANN_COST    <dbl> 70475.16
    ## $ SA_REAL_LOSSES_ANN_COST        <dbl> 10478.37
    ## $ SA_ANNUAL_COST_VALUED_AT       <chr> "Variable Production Cost"
    ## $ PI_FI_NON_REV_PERCENT_BY_VOL   <dbl> 0.0505246
    ## $ PI_FI_NON_REV_PERCENT_BY_COST  <dbl> 0.01387197
    ## $ PI_OE_APPARENT_LOSSES_GCD      <dbl> 5.776422
    ## $ PI_OE_REAL_LOSSES_GCD          <chr> "13.3837600209245"
    ## $ PI_OE_REAL_LOSSES_GMD          <chr> "N/A"
    ## $ PI_OE_REAL_LOSSES_GCD_PSI      <chr> "0.30417636411192001"
    ## $ PI_CURRENT_ANN_REAL_LOSSES_VOL <dbl> 22.16846
    ## $ PI_INFRASTRUCT_LEAKAGE_INDEX   <dbl> 1.309645
    ## $ WS_UNITS_SHORT                 <chr> "MG/Yr"

### How is our chosen metric described in the report data?

``` r
volume_supplied_report_1 <- "VOLUME_OF_WATER_SUPPLIED_AF"
volume_supplied_report_2 <- "WS_WATER_SUPPLIED_VOL_AF"
```

``` r
metric_report_1 <- data_report_1 %>% pull(volume_supplied_report_1)
metric_report_2 <-  data_report_2 %>% pull(volume_supplied_report_2)

delta_water_supplied <- metric_report_1 - metric_report_2
delta_water_supplied_percent <- (metric_report_1 / metric_report_2 - 1) * 100
```

The *difference* in the Volume Water Supplied in Acre Feet between the
Urban Water Managment Plan and Water Loss Report is: 7.7949751.

The *percent difference* is: 0.383999 %.
