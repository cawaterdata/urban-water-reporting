Template Analysis
================
Erin Cain
1/31/2022

## Explore UWMP Data:

-   Table 4-3 Wholesale: Total Water Demands (Converted to Acre-Feet)
-   Table 2-1 Retail Only: Public Water Systems (Converted to Acre-Feet)

\*Many other tables that may be useful to look at

``` r
UWMP_demand <- readxl::read_excel("../data-raw/uwmp_table_4_3_w_view_conv_to_af.xlsx") %>% 
  filter(WATER_SUPPLIER_NAME == "Healdsburg  City Of") %>%
  glimpse()
```

    ## Rows: 1
    ## Columns: 12
    ## $ ORG_ID                      <dbl> 1144
    ## $ WATER_SUPPLIER_NAME         <chr> "Healdsburg  City Of"
    ## $ WORKSHEET_NAME              <chr> "Table 4-3 Wholesale: Total Water Demands"
    ## $ REVIEWED_BY_DWR             <chr> "No"
    ## $ REQUIREMENTS_ADDRESSED      <chr> "N/A"
    ## $ WATER_DEMAND_TYPE           <chr> "Potable and Raw Water"
    ## $ WATER_DEMAND_VOLUME_2020_AF <dbl> 64.44664
    ## $ WATER_DEMAND_VOLUME_2025_AF <dbl> 64.44664
    ## $ WATER_DEMAND_VOLUME_2030_AF <dbl> 64.44664
    ## $ WATER_DEMAND_VOLUME_2035_AF <dbl> 64.44664
    ## $ WATER_DEMAND_VOLUME_2040_AF <dbl> 64.44664
    ## $ WATER_DEMAND_VOLUME_2045_AF <dbl> 64.44664

``` r
UWMP_supply <- readxl::read_excel("../data-raw/uwmp_table_2_2_r_conv_to_af.xlsx") %>% 
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
unique(UWMP_supply$WATER_SUPPLIER_NAME)
```

    ## [1] "Healdsburg  City Of"

``` r
cols_UWMP_supply <- colnames(UWMP_supply)
cols_UWMP_demand <- colnames(UWMP_demand)
UWMP_fields <- unique(append(cols_UWMP_demand, cols_UWMP_supply))

# write_rds(UWMP_fields, "../data/UWMP_fields.rds")
```

## Explore Water Loss Report Data (Converted to Acre-Feet)

``` r
WLR <- readxl::read_excel("../data-raw/water_audit_data_conv_to_af.xlsx") %>% 
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

``` r
unique(WLR$WATER_SUPPLIER_NAME)
```

    ## [1] "Healdsburg  City Of"

``` r
WLR_fields <- colnames(WLR)
# write_rds(WLR_fields, "../data/WLR_fields.rds")
```

``` r
report_1 <- "Urban Water Managment Plan"
report_2 <- "Water Loss Report"
metric <- "Volume Water Supplied in Acre Feet"
volumne_water_supplied_UWMP <- UWMP_supply$VOLUME_OF_WATER_SUPPLIED_AF
volume_water_supplied_WLR <-  WLR$WS_WATER_SUPPLIED_VOL_AF

delta_water_supplied <- volumne_water_supplied_UWMP - volume_water_supplied_WLR
delta_water_supplied_percent <- volumne_water_supplied_UWMP / (volume_water_supplied_WLR - 1)
```

The difference in the Volume Water Supplied in Acre Feet between the
Urban Water Managment Plan and Water Loss Report is: 7.7949751. The %
difference is: 1.0043347

## Explore Conservation Report Data

``` r
conservation_report <- readxl::read_excel("../data-raw/conservation-report-uw-supplier-data120721.xlsx") %>% 
  glimpse
```

    ## Rows: 35,057
    ## Columns: 28
    ## $ `Supplier Name`                                                        <chr> ~
    ## $ `Public Water System ID`                                               <chr> ~
    ## $ `Reporting Month`                                                      <dttm> ~
    ## $ County                                                                 <chr> ~
    ## $ `Hydrologic Region`                                                    <chr> ~
    ## $ `Climate Zone`                                                         <dbl> ~
    ## $ `Total Population Served`                                              <dbl> ~
    ## $ `Reference 2014 Population`                                            <dbl> ~
    ## $ `County Under Drought Declaration`                                     <chr> ~
    ## $ `Water Shortage Contingency Stage Invoked`                             <chr> ~
    ## $ `Water Shortage Level Indicator`                                       <chr> ~
    ## $ `Water Production Units`                                               <chr> ~
    ## $ `REPORTED PRELIMINARY Total Potable Water Production`                  <dbl> ~
    ## $ `REPORTED FINAL Total Potable Water Production`                        <dbl> ~
    ## $ `PRELIMINARY Percent Residential Use`                                  <dbl> ~
    ## $ `FINAL Percent Residential Use`                                        <dbl> ~
    ## $ `REPORTED PRELIMINARY Commercial Agricultural Water`                   <dbl> ~
    ## $ `REPORTED FINAL Commercial Agricultural Water`                         <dbl> ~
    ## $ `REPORTED PRELIMINARY Commercial, Industrial, and Institutional Water` <dbl> ~
    ## $ `REPORTED FINAL Commercial, Industrial, and Institutional Water`       <dbl> ~
    ## $ `REPORTED Recycled Water`                                              <dbl> ~
    ## $ `REPORTED Non-Revenue Water`                                           <dbl> ~
    ## $ `CALCULATED Total Potable Water Production Gallons (Ag Excluded)`      <dbl> ~
    ## $ `CALCULATED Total Potable Water Production Gallons 2013 (Ag Excluded)` <dbl> ~
    ## $ `CALCULATED Commercial Agricultural Water Gallons`                     <dbl> ~
    ## $ `CALCULATED Commercial Agricultural Water Gallons 2013`                <dbl> ~
    ## $ `CALCULATED R-GPCD`                                                    <dbl> ~
    ## $ Qualification                                                          <chr> ~

``` r
conservation_report_fields <- colnames(conservation_report)
# write_rds(conservation_report_fields, "../data/conservation_report_fields.rds")
```

## Explore EAR Report Data

``` r
EAR_report <- read.delim("../data-raw/EAR_ResultSet_2020RY.txt") %>% 
  glimpse
```

    ## Rows: 3,386,727
    ## Columns: 9
    ## $ ï..WSID                   <chr> "CA0103040", "CA0103040", "CA0103040", "CA01~
    ## $ SurveyName                <chr> "2020 EAR", "2020 EAR", "2020 EAR", "2020 EA~
    ## $ WSSurveyID                <chr> "429644", "429644", "429644", "429644", "429~
    ## $ QuestionID                <chr> "28101", "28102", "28103", "28104", "28097",~
    ## $ SectionID                 <chr> "01 Intro", "01 Intro", "01 Intro", "01 Intr~
    ## $ Order                     <chr> "1.05", "1.1", "1.15", "1.2", "1.25", "1.3",~
    ## $ QuestionName              <chr> "PwsID", "PWSName", "WaterSystemClassificati~
    ## $ QuestionResults           <chr> "CA0103040", "NORRIS CANYON PROPERTY OWNERS ~
    ## $ OldShortName_QuestionText <chr> "Water System No", "Water System Name", "Wat~

``` r
filtered_EAR_report <- EAR_report %>% 
  filter(SurveyName == "2020 EAR", SectionID %in% c("06 Supply-Delivery")) %>% 
  mutate(QuestionType = substr(QuestionName, start = 1, stop = 2),
         month = stringr::str_extract(QuestionName, month.abb),
         # length = length(QuestionName),
         category = ifelse(is.na(month), 
                           substr(QuestionName, start = 3, stop = length(QuestionName)), 
                           substr(QuestionName, start = 6, stop = length(QuestionName)))) %>% glimpse()
```

    ## Warning in stri_extract_first_regex(string, pattern, opts_regex =
    ## opts(pattern)): longer object length is not a multiple of shorter object length

    ## Rows: 963,519
    ## Columns: 12
    ## $ ï..WSID                   <chr> "CA0103040", "CA0103040", "CA0103040", "CA01~
    ## $ SurveyName                <chr> "2020 EAR", "2020 EAR", "2020 EAR", "2020 EA~
    ## $ WSSurveyID                <chr> "429644", "429644", "429644", "429644", "429~
    ## $ QuestionID                <chr> "28580", "28593", "28594", "28581", "28582",~
    ## $ SectionID                 <chr> "06 Supply-Delivery", "06 Supply-Delivery", ~
    ## $ Order                     <chr> "6.001", "6.002", "6.003", "6.004", "6.005",~
    ## $ QuestionName              <chr> "WPReportedElsewhere", "WPReportNames", "WPR~
    ## $ QuestionResults           <chr> "No", "", "", "G", "M", "", "2600", "2960", ~
    ## $ OldShortName_QuestionText <chr> "Are any questions in this section reported ~
    ## $ QuestionType              <chr> "WP", "WP", "WP", "WP", "WP", "WP", "WP", "W~
    ## $ month                     <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
    ## $ category                  <chr> "ReportedElsewhere", "ReportNames", "ReportE~

``` r
unique(filtered_EAR_report$month)
```

    ##  [1] NA    "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov"
    ## [13] "Dec"

``` r
# Lots of fields here, not sure how to best select metrics of interest 

EAR_fields <- unique(filtered_EAR_report$QuestionName)
EAR_fields
```

    ##   [1] "WPReportedElsewhere"               "WPReportNames"                    
    ##   [3] "WPReportEntity"                    "WPUnitsofMeasure"                 
    ##   [5] "WPVolumeType"                      "WPNoGW"                           
    ##   [7] "WPJanGW"                           "WPFebGW"                          
    ##   [9] "WPMarGW"                           "WPAprGW"                          
    ##  [11] "WPMayGW"                           "WPJunGW"                          
    ##  [13] "WPJulGW"                           "WPAugGW"                          
    ##  [15] "WPSepGW"                           "WPOctGW"                          
    ##  [17] "WPNovGW"                           "WPDecGW"                          
    ##  [19] "WPAnnualGW"                        "WPPTGW"                           
    ##  [21] "WPNoSW"                            "WPJanSW"                          
    ##  [23] "WPFebSW"                           "WPMarSW"                          
    ##  [25] "WPAprSW"                           "WPMaySW"                          
    ##  [27] "WPJunSW"                           "WPJulSW"                          
    ##  [29] "WPAugSW"                           "WPSepSW"                          
    ##  [31] "WPOctSW"                           "WPNovSW"                          
    ##  [33] "WPDecSW"                           "WPAnnualSW"                       
    ##  [35] "WPNoPurchased"                     "WPJanPurchased"                   
    ##  [37] "WPFebPurchased"                    "WPMarPurchased"                   
    ##  [39] "WPAprPurchased"                    "WPMayPurchased"                   
    ##  [41] "WPJunPurchased"                    "WPJulPurchased"                   
    ##  [43] "WPAugPurchased"                    "WPSepPurchased"                   
    ##  [45] "WPOctPurchased"                    "WPNovPurchased"                   
    ##  [47] "WPDecPurchased"                    "WPAnnualPurchased"                
    ##  [49] "WPJanTotal"                        "WPFebTotal"                       
    ##  [51] "WPMarTotal"                        "WPAprTotal"                       
    ##  [53] "WPMayTotal"                        "WPJunTotal"                       
    ##  [55] "WPJulTotal"                        "WPAugTotal"                       
    ##  [57] "WPSepTotal"                        "WPOctTotal"                       
    ##  [59] "WPNovTotal"                        "WPDecTotal"                       
    ##  [61] "WPAnnualTotal"                     "WPNoSold"                         
    ##  [63] "WPJanSold"                         "WPFebSold"                        
    ##  [65] "WPMarSold"                         "WPAprSold"                        
    ##  [67] "WPMaySold"                         "WPJunSold"                        
    ##  [69] "WPJulSold"                         "WPAugSold"                        
    ##  [71] "WPSepSold"                         "WPOctSold"                        
    ##  [73] "WPNovSold"                         "WPDecSold"                        
    ##  [75] "WPAnnualSold"                      "WPNoNonPotable"                   
    ##  [77] "WPJanNonPotable"                   "WPFebNonPotable"                  
    ##  [79] "WPMarNonPotable"                   "WPAprNonPotable"                  
    ##  [81] "WPMayNonPotable"                   "WPJunNonPotable"                  
    ##  [83] "WPJulNonPotable"                   "WPAugNonPotable"                  
    ##  [85] "WPSepNonPotable"                   "WPOctNonPotable"                  
    ##  [87] "WPNovNonPotable"                   "WPDecNonPotable"                  
    ##  [89] "WPAnnualNonPotable"                "WPNoRecycled"                     
    ##  [91] "WPJanRecycled"                     "WPFebRecycled"                    
    ##  [93] "WPMarRecycled"                     "WPAprRecycled"                    
    ##  [95] "WPMayRecycled"                     "WPJunRecycled"                    
    ##  [97] "WPJulRecycled"                     "WPAugRecycled"                    
    ##  [99] "WPSepRecycled"                     "WPOctRecycled"                    
    ## [101] "WPNovRecycled"                     "WPDecRecycled"                    
    ## [103] "WPAnnualRecycled"                  "WPMaxDayDate"                     
    ## [105] "WPMaxDayGW"                        "WPMaxDaySW"                       
    ## [107] "WPMaxDayPurchased"                 "WPMaxDayTotal"                    
    ## [109] "WPMaxDaySold"                      "WPRecycledGrid"                   
    ## [111] "WPComments"                        "WDNoWaterDelivery"                
    ## [113] "WDUnitofMeasure"                   "WDNoSF"                           
    ## [115] "WDNoMF"                            "WDNoCI"                           
    ## [117] "WDNoI"                             "WDNoLI"                           
    ## [119] "WDNoO"                             "WDNoA"                            
    ## [121] "WDJanSF"                           "WDFebSF"                          
    ## [123] "WDMarSF"                           "WDAprSF"                          
    ## [125] "WDMaySF"                           "WDJunSF"                          
    ## [127] "WDJulSF"                           "WDAugSF"                          
    ## [129] "WDSepSF"                           "WDOctSF"                          
    ## [131] "WDNovSF"                           "WDDecSF"                          
    ## [133] "WDPercentRecycledSF"               "WDAnnualSF"                       
    ## [135] "WDJanMF"                           "WDFebMF"                          
    ## [137] "WDMarMF"                           "WDAprMF"                          
    ## [139] "WDMayMF"                           "WDJunMF"                          
    ## [141] "WDJulMF"                           "WDAugMF"                          
    ## [143] "WDSepMF"                           "WDOctMF"                          
    ## [145] "WDNovMF"                           "WDDecMF"                          
    ## [147] "WDPercentRecycledMF"               "WDAnnualMF"                       
    ## [149] "WDJanCI"                           "WDFebCI"                          
    ## [151] "WDMarCI"                           "WDAprCI"                          
    ## [153] "WDMayCI"                           "WDJunCI"                          
    ## [155] "WDJulCI"                           "WDAugCI"                          
    ## [157] "WDSepCI"                           "WDOctCI"                          
    ## [159] "WDNovCI"                           "WDDecCI"                          
    ## [161] "WDPercentRecycledCI"               "WDAnnualCI"                       
    ## [163] "WDJanI"                            "WDFebI"                           
    ## [165] "WDMarI"                            "WDAprI"                           
    ## [167] "WDMayI"                            "WDJunI"                           
    ## [169] "WDJulI"                            "WDAugI"                           
    ## [171] "WDSepI"                            "WDOctI"                           
    ## [173] "WDNovI"                            "WDDecI"                           
    ## [175] "WDPercentRecycledI"                "WDAnnualI"                        
    ## [177] "WDJanLI"                           "WDFebLI"                          
    ## [179] "WDMarLI"                           "WDAprLI"                          
    ## [181] "WDMayLI"                           "WDJunLI"                          
    ## [183] "WDJulLI"                           "WDAugLI"                          
    ## [185] "WDSepLI"                           "WDOctLI"                          
    ## [187] "WDNovLI"                           "WDDecLI"                          
    ## [189] "WDPercentRecycledLI"               "WDAnnualLI"                       
    ## [191] "WDJanO"                            "WDFebO"                           
    ## [193] "WDMarO"                            "WDAprO"                           
    ## [195] "WDMayO"                            "WDJunO"                           
    ## [197] "WDJulO"                            "WDAugO"                           
    ## [199] "WDSepO"                            "WDOctO"                           
    ## [201] "WDNovO"                            "WDDecO"                           
    ## [203] "WDPercentRecycledO"                "WDAnnualO"                        
    ## [205] "WDJanTotal"                        "WDFebTotal"                       
    ## [207] "WDMarTotal"                        "WDAprTotal"                       
    ## [209] "WDMayTotal"                        "WDJunTotal"                       
    ## [211] "WDJulTotal"                        "WDAugTotal"                       
    ## [213] "WDSepTotal"                        "WDOctTotal"                       
    ## [215] "WDNovTotal"                        "WDDecTotal"                       
    ## [217] "WDAnnualTotal"                     "WDJanA"                           
    ## [219] "WDFebA"                            "WDMarA"                           
    ## [221] "WDAprA"                            "WDMayA"                           
    ## [223] "WDJunA"                            "WDJulA"                           
    ## [225] "WDAugA"                            "WDSepA"                           
    ## [227] "WDOctA"                            "WDNovA"                           
    ## [229] "WDDecA"                            "WDPercentRecycledA"               
    ## [231] "WDAnnualA"                         "WDJanOP"                          
    ## [233] "WDFebOP"                           "WDMarOP"                          
    ## [235] "WDAprOP"                           "WDMayOP"                          
    ## [237] "WDJunOP"                           "WDJulOP"                          
    ## [239] "WDAugOP"                           "WDSepOP"                          
    ## [241] "WDOctOP"                           "WDNovOP"                          
    ## [243] "WDDecOP"                           "WDPercentRecycledOP"              
    ## [245] "WDAnnualOP"                        "WDCommercialIncludesResidential"  
    ## [247] "WDIndustrialIincludesResidential"  "WDLandscapeIncludesResidential"   
    ## [249] "WDDedicatedIrrigationMeters"       "WDCIIIrrigationUnit"              
    ## [251] "WDCIIIrrigationVolume"             "WDCIIIrrigationVolumeNotCollected"
    ## [253] "WDCIIIrrigationComments"           "WDParklandsOrTrees"               
    ## [255] "WDPercentParklands"                "WDPercentTrees"                   
    ## [257] "WDPercentNotCollected"             "WDComments"

``` r
metrics_of_interest <- c("WPAnnualTotal", "WDAnnualTotal")
```
