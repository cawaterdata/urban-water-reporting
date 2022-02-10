Report Combinations and Metrics Reported
================
Erin Cain
2/1/2022

## Reports

There are 5 different reports that must be compared with each other.
There are 10 total comparisons that must be done for each metric. Each
comparison is shown below:

|                           | UWMP | Conservation | eAR | Water Loss | Supply & Demand\* | Water Use Objective\* |
|---------------------------|------|--------------|-----|------------|-------------------|-----------------------|
| **UWMP**                  | \-   | 1            | 2   | 3          | \*                | \*                    |
| **Conservation**          | \-   | \-           | 4   | 5          | \*                | \*                    |
| **eAR**                   | \-   | \-           | \-  | 6          | \*                | \*                    |
| **Water Loss**            | \-   | \-           | \-  | \-         | \*                | \*                    |
| **Supply & Demand**\*     | \-   | \-           | \-  | \-         | \-                | \*                    |
| **Water Use Objective**\* | \-   | \-           | \-  | \-         | \-                | \-                    |

\*No data reported yet for Supply & Demand assessment or Water Use
Objective.

## Metrics

### Water Supply Metrics Reported

#### Conservation Report Supply

``` r
# Conservation Report Metrics
readr::read_rds("../data/conservation_supply_fields.rds")
```

    ## [1] "REPORTED PRELIMINARY Total Potable Water Production"
    ## [2] "REPORTED FINAL Total Potable Water Production"

The only supply metric required by the conservation report is
`Total Potable Water Production`.

#### UWMP Supply

``` r
# Some of UWMP Metrics (many more tables we could pull from) - some reports give metrics for each month but others just have annual values.*
readr::read_rds("../data/UWMP_supply_fields.rds")[10]
```

    ## [1] "VOLUME_OF_WATER_SUPPLIED_AF"

There may be additional supply metrics reported by the UWMP in different
tables. (TODO investigate this.)

#### WLR Supply

``` r
# Water Loss Report Metrics
readr::read_rds("../data/WLR_supply_fields.rds")
```

    ##  [1] "WS_OWN_SOURCES_VOL_COMMENT"  "WS_OWN_SOURCES_VOL"         
    ##  [3] "WS_OWN_SOURCES_VOL_AF"       "WS_OWN_SOURCES_ERR_COMMENT" 
    ##  [5] "WS_OWN_SOURCES_ERR_ADJ_TYPE" "WS_OWN_SOURCES_ERR_PERCENT" 
    ##  [7] "WS_OWN_SOURCES_ERR_VOL"      "WS_OWN_SOURCES_ERR_VOL_AF"  
    ##  [9] "WS_IMPORTED_VOL_COMMENT"     "WS_IMPORTED_VOL"            
    ## [11] "WS_IMPORTED_VOL_AF"          "WS_IMPORTED_ERR_COMMENT"    
    ## [13] "WS_IMPORTED_ERR_ADJ_TYPE"    "WS_IMPORTED_ERR_PERCENT"    
    ## [15] "WS_IMPORTED_ERR_VOL"         "WS_IMPORTED_ERR_VOL_AF"     
    ## [17] "WS_EXPORTED_VOL_COMMENT"     "WS_EXPORTED_VOL"            
    ## [19] "WS_EXPORTED_VOL_AF"          "WS_EXPORTED_ERR_COMMENT"    
    ## [21] "WS_EXPORTED_ERR_ADJ_TYPE"    "WS_EXPORTED_ERR_PERCENT"    
    ## [23] "WS_EXPORTED_ERR_VOL"         "WS_EXPORTED_ERR_VOL_AF"     
    ## [25] "WS_WATER_SUPPLIED_VOL"       "WS_WATER_SUPPLIED_VOL_AF"   
    ## [27] "WS_UNITS_SHORT"

The Water Loss Report Splits Supply into 3 categories:

-   Own Sources
-   Imported
-   Exported

#### EAR Supply

``` r
# EAR 
readr::read_rds("../data/EAR_supply_fields.rds")
```

    ##   [1] "WPReportedElsewhere" "WPReportNames"       "WPReportEntity"     
    ##   [4] "WPUnitsofMeasure"    "WPVolumeType"        "WPNoGW"             
    ##   [7] "WPJanGW"             "WPFebGW"             "WPMarGW"            
    ##  [10] "WPAprGW"             "WPMayGW"             "WPJunGW"            
    ##  [13] "WPJulGW"             "WPAugGW"             "WPSepGW"            
    ##  [16] "WPOctGW"             "WPNovGW"             "WPDecGW"            
    ##  [19] "WPAnnualGW"          "WPPTGW"              "WPNoSW"             
    ##  [22] "WPJanSW"             "WPFebSW"             "WPMarSW"            
    ##  [25] "WPAprSW"             "WPMaySW"             "WPJunSW"            
    ##  [28] "WPJulSW"             "WPAugSW"             "WPSepSW"            
    ##  [31] "WPOctSW"             "WPNovSW"             "WPDecSW"            
    ##  [34] "WPAnnualSW"          "WPNoPurchased"       "WPJanPurchased"     
    ##  [37] "WPFebPurchased"      "WPMarPurchased"      "WPAprPurchased"     
    ##  [40] "WPMayPurchased"      "WPJunPurchased"      "WPJulPurchased"     
    ##  [43] "WPAugPurchased"      "WPSepPurchased"      "WPOctPurchased"     
    ##  [46] "WPNovPurchased"      "WPDecPurchased"      "WPAnnualPurchased"  
    ##  [49] "WPJanTotal"          "WPFebTotal"          "WPMarTotal"         
    ##  [52] "WPAprTotal"          "WPMayTotal"          "WPJunTotal"         
    ##  [55] "WPJulTotal"          "WPAugTotal"          "WPSepTotal"         
    ##  [58] "WPOctTotal"          "WPNovTotal"          "WPDecTotal"         
    ##  [61] "WPAnnualTotal"       "WPNoSold"            "WPJanSold"          
    ##  [64] "WPFebSold"           "WPMarSold"           "WPAprSold"          
    ##  [67] "WPMaySold"           "WPJunSold"           "WPJulSold"          
    ##  [70] "WPAugSold"           "WPSepSold"           "WPOctSold"          
    ##  [73] "WPNovSold"           "WPDecSold"           "WPAnnualSold"       
    ##  [76] "WPNoNonPotable"      "WPJanNonPotable"     "WPFebNonPotable"    
    ##  [79] "WPMarNonPotable"     "WPAprNonPotable"     "WPMayNonPotable"    
    ##  [82] "WPJunNonPotable"     "WPJulNonPotable"     "WPAugNonPotable"    
    ##  [85] "WPSepNonPotable"     "WPOctNonPotable"     "WPNovNonPotable"    
    ##  [88] "WPDecNonPotable"     "WPAnnualNonPotable"  "WPNoRecycled"       
    ##  [91] "WPJanRecycled"       "WPFebRecycled"       "WPMarRecycled"      
    ##  [94] "WPAprRecycled"       "WPMayRecycled"       "WPJunRecycled"      
    ##  [97] "WPJulRecycled"       "WPAugRecycled"       "WPSepRecycled"      
    ## [100] "WPOctRecycled"       "WPNovRecycled"       "WPDecRecycled"      
    ## [103] "WPAnnualRecycled"    "WPMaxDayDate"        "WPMaxDayGW"         
    ## [106] "WPMaxDaySW"          "WPMaxDayPurchased"   "WPMaxDayTotal"      
    ## [109] "WPMaxDaySold"        "WPRecycledGrid"      "WPComments"

Supply metrics in the EAR report fall into the following categories:

-   Ground Water
-   Surface Water
-   Purchased
-   Sold
-   Recycled
-   Potable
-   Non Potable
-   Total

#### Shared Supply Metrics

Total Water Supplied appears to be reported under different names across
the 4 reports:

-   **Conservation Report:**
    `"REPORTED FINAL Total Potable Water Production"`(units: see
    `"Water Production Units"`) We will need to sum the monthly data to
    find annual value.
-   **UWMP:** `"VOLUME_OF_WATER_SUPPLIED_AF"` (units: Acre Feet)
    Annually but looks like some agencies also provided monthly in
    report  
-   **WLR:** `"WS_WATER_SUPPLIED_VOL_AF"` (units: Acre Feet) Annually
    only
-   **EAR** `"WPAnnualTotal"` (units: see `"WPUnitsofMeasure"`) Monthly
    and annually

Some reports have additional breakdowns of supply metrics and we may be
able to compare the supply from imported sources, supply from ground
water, supply from surface water, supply from recycled water, supply of
non potable water, and exported water.

### Water Demand Metrics Reported

#### Conservation Report Demand

``` r
# Conservation Report Metrics
readr::read_rds("../data/conservation_demand_fields.rds")
```

    ## [1] "PRELIMINARY Percent Residential Use"                                 
    ## [2] "FINAL Percent Residential Use"                                       
    ## [3] "REPORTED PRELIMINARY Commercial Agricultural Water"                  
    ## [4] "REPORTED FINAL Commercial Agricultural Water"                        
    ## [5] "REPORTED PRELIMINARY Commercial, Industrial, and Institutional Water"
    ## [6] "REPORTED FINAL Commercial, Industrial, and Institutional Water"      
    ## [7] "REPORTED Recycled Water"                                             
    ## [8] "REPORTED Non-Revenue Water"

Demand in the Conservation Report is split up by type:

-   Commercial Agricultural Water
-   Commercial, Industrial, and Institutional Water
-   Recycled Water
-   Non-Revenue Water
-   % Residential (Can calculate volume residential by
    `Total Potable Water Production` \* `Percent Residential Use`)

#### UWMP Demand

``` r
# Some of UWMP Metrics (many more tables we could pull from) - some reports give metrics for each month but others just have annual values.*
readr::read_rds("../data/UWMP_demand_fields.rds")[6:12]
```

    ## [1] "WATER_DEMAND_TYPE"           "WATER_DEMAND_VOLUME_2020_AF"
    ## [3] "WATER_DEMAND_VOLUME_2025_AF" "WATER_DEMAND_VOLUME_2030_AF"
    ## [5] "WATER_DEMAND_VOLUME_2035_AF" "WATER_DEMAND_VOLUME_2040_AF"
    ## [7] "WATER_DEMAND_VOLUME_2045_AF"

UWMP gives the total water demand and the forcasted demand for the
following demand types:

``` r
# Demand types:
readr::read_rds("../data/UWMP_demand_types.rds")
```

    ## [1] "Potable and Raw Water" "Recycled Water Demand"

#### Water Loss Report Demand

``` r
# Water Loss Report Metrics
readr::read_rds("../data/WLR_demand_fields.rds")
```

    ##  [1] "AC_BILL_METER_VOL_COMMENT"      "AC_BILL_METER_VOL"             
    ##  [3] "AC_BILL_METER_VOL_AF"           "AC_BILL_UNMETER_VOL_COMMENT"   
    ##  [5] "AC_BILL_UNMETER_VOL"            "AC_BILL_UNMETER_VOL_AF"        
    ##  [7] "AC_UNBILL_METER_VOL_COMMENT"    "AC_UNBILL_METER_VOL"           
    ##  [9] "AC_UNBILL_METER_VOL_AF"         "AC_UNBILL_UNMETER_VOL_COMMENT" 
    ## [11] "AC_UNBILL_UNMETER_VOL"          "AC_UNBILL_UNMETER_VOL_AF"      
    ## [13] "AC_UNBILL_UNMETER_ERR_ADJ_TYPE" "AC_UNBILL_UNMETER_ERR_PERCENT" 
    ## [15] "AC_UNBILL_UNMETER_ERR_VOL"      "AC_UNBILL_UNMETER_ERR_VOL_AF"  
    ## [17] "AC_AUTH_CONSUMPTION_VOL"        "AC_AUTH_CONSUMPTION_VOL_AF"

The Water Loss Report Splits Demand into 4 categories:

-   Billed metered
-   Billed unmetered
-   Unbilled metered
-   Unbilled unmetered

The total demand is recorded in `AC_AUTH_CONSUMPTION_VOL_AF` Authorized
consumption is defined as: the volume of water taken by registered
customers, the water supplier, and others who are implicitly or
explicitly authorized to do so. Authorized consumption may be billed or
unbilled, metered or unmetered.

#### EAR Demand

``` r
# EAR 
readr::read_rds("../data/EAR_demand_fields.rds")
```

    ##   [1] "WDNoWaterDelivery"                 "WDUnitofMeasure"                  
    ##   [3] "WDNoSF"                            "WDNoMF"                           
    ##   [5] "WDNoCI"                            "WDNoI"                            
    ##   [7] "WDNoLI"                            "WDNoO"                            
    ##   [9] "WDNoA"                             "WDJanSF"                          
    ##  [11] "WDFebSF"                           "WDMarSF"                          
    ##  [13] "WDAprSF"                           "WDMaySF"                          
    ##  [15] "WDJunSF"                           "WDJulSF"                          
    ##  [17] "WDAugSF"                           "WDSepSF"                          
    ##  [19] "WDOctSF"                           "WDNovSF"                          
    ##  [21] "WDDecSF"                           "WDPercentRecycledSF"              
    ##  [23] "WDAnnualSF"                        "WDJanMF"                          
    ##  [25] "WDFebMF"                           "WDMarMF"                          
    ##  [27] "WDAprMF"                           "WDMayMF"                          
    ##  [29] "WDJunMF"                           "WDJulMF"                          
    ##  [31] "WDAugMF"                           "WDSepMF"                          
    ##  [33] "WDOctMF"                           "WDNovMF"                          
    ##  [35] "WDDecMF"                           "WDPercentRecycledMF"              
    ##  [37] "WDAnnualMF"                        "WDJanCI"                          
    ##  [39] "WDFebCI"                           "WDMarCI"                          
    ##  [41] "WDAprCI"                           "WDMayCI"                          
    ##  [43] "WDJunCI"                           "WDJulCI"                          
    ##  [45] "WDAugCI"                           "WDSepCI"                          
    ##  [47] "WDOctCI"                           "WDNovCI"                          
    ##  [49] "WDDecCI"                           "WDPercentRecycledCI"              
    ##  [51] "WDAnnualCI"                        "WDJanI"                           
    ##  [53] "WDFebI"                            "WDMarI"                           
    ##  [55] "WDAprI"                            "WDMayI"                           
    ##  [57] "WDJunI"                            "WDJulI"                           
    ##  [59] "WDAugI"                            "WDSepI"                           
    ##  [61] "WDOctI"                            "WDNovI"                           
    ##  [63] "WDDecI"                            "WDPercentRecycledI"               
    ##  [65] "WDAnnualI"                         "WDJanLI"                          
    ##  [67] "WDFebLI"                           "WDMarLI"                          
    ##  [69] "WDAprLI"                           "WDMayLI"                          
    ##  [71] "WDJunLI"                           "WDJulLI"                          
    ##  [73] "WDAugLI"                           "WDSepLI"                          
    ##  [75] "WDOctLI"                           "WDNovLI"                          
    ##  [77] "WDDecLI"                           "WDPercentRecycledLI"              
    ##  [79] "WDAnnualLI"                        "WDJanO"                           
    ##  [81] "WDFebO"                            "WDMarO"                           
    ##  [83] "WDAprO"                            "WDMayO"                           
    ##  [85] "WDJunO"                            "WDJulO"                           
    ##  [87] "WDAugO"                            "WDSepO"                           
    ##  [89] "WDOctO"                            "WDNovO"                           
    ##  [91] "WDDecO"                            "WDPercentRecycledO"               
    ##  [93] "WDAnnualO"                         "WDJanTotal"                       
    ##  [95] "WDFebTotal"                        "WDMarTotal"                       
    ##  [97] "WDAprTotal"                        "WDMayTotal"                       
    ##  [99] "WDJunTotal"                        "WDJulTotal"                       
    ## [101] "WDAugTotal"                        "WDSepTotal"                       
    ## [103] "WDOctTotal"                        "WDNovTotal"                       
    ## [105] "WDDecTotal"                        "WDAnnualTotal"                    
    ## [107] "WDJanA"                            "WDFebA"                           
    ## [109] "WDMarA"                            "WDAprA"                           
    ## [111] "WDMayA"                            "WDJunA"                           
    ## [113] "WDJulA"                            "WDAugA"                           
    ## [115] "WDSepA"                            "WDOctA"                           
    ## [117] "WDNovA"                            "WDDecA"                           
    ## [119] "WDPercentRecycledA"                "WDAnnualA"                        
    ## [121] "WDJanOP"                           "WDFebOP"                          
    ## [123] "WDMarOP"                           "WDAprOP"                          
    ## [125] "WDMayOP"                           "WDJunOP"                          
    ## [127] "WDJulOP"                           "WDAugOP"                          
    ## [129] "WDSepOP"                           "WDOctOP"                          
    ## [131] "WDNovOP"                           "WDDecOP"                          
    ## [133] "WDPercentRecycledOP"               "WDAnnualOP"                       
    ## [135] "WDCommercialIncludesResidential"   "WDIndustrialIincludesResidential" 
    ## [137] "WDLandscapeIncludesResidential"    "WDDedicatedIrrigationMeters"      
    ## [139] "WDCIIIrrigationUnit"               "WDCIIIrrigationVolume"            
    ## [141] "WDCIIIrrigationVolumeNotCollected" "WDCIIIrrigationComments"          
    ## [143] "WDParklandsOrTrees"                "WDPercentParklands"               
    ## [145] "WDPercentTrees"                    "WDPercentNotCollected"            
    ## [147] "WDComments"

Demand metrics in the EAR report fall into the following categories:

-   Multi-Family
-   Single Family
-   Commercial Industrial
-   Industrial
-   Landscape Irrigation
-   Agriculture
-   Percent Recycled
-   Other
-   Total

#### Shared Demand Metrics

Total Water Demand is reported in 3? of the 4 reports and can be
calculated from other demand measures:

-   **Conservation Report:** Need to sum up to get total
-   **UWMP:** `"WATER_DEMAND_VOLUME_2020_AF"` In some cases may need to
    sum up the two demand types to get total demand. (units: Acre Feet)
-   **WLR:** `"AC_AUTH_CONSUMPTION_VOL_AF"?` (units: Acre Feet)
-   **EAR:** `"WDAnnualTotal"` (Units listed in `WDUnitofMeasure`
    column)

### Other Fields

There are other fields reported that are not directly related to supply
and demand. Some of those fields are listed below. The list below does
not cover all other additional fields reported.

``` r
# Conservation Report Metrics
readr::read_rds("../data/conservation_calculated_fields.rds")
```

    ## [1] "CALCULATED Total Potable Water Production Gallons (Ag Excluded)"     
    ## [2] "CALCULATED Total Potable Water Production Gallons 2013 (Ag Excluded)"
    ## [3] "CALCULATED Commercial Agricultural Water Gallons"                    
    ## [4] "CALCULATED Commercial Agricultural Water Gallons 2013"               
    ## [5] "CALCULATED R-GPCD"                                                   
    ## [6] "Qualification"

``` r
readr::read_rds("../data/conservation_background_fields.rds")
```

    ##  [1] "Supplier Name"                           
    ##  [2] "Public Water System ID"                  
    ##  [3] "Reporting Month"                         
    ##  [4] "County"                                  
    ##  [5] "Hydrologic Region"                       
    ##  [6] "Climate Zone"                            
    ##  [7] "Total Population Served"                 
    ##  [8] "Reference 2014 Population"               
    ##  [9] "County Under Drought Declaration"        
    ## [10] "Water Shortage Contingency Stage Invoked"
    ## [11] "Water Shortage Level Indicator"          
    ## [12] "Water Production Units"

``` r
# Water Loss Report Metrics
readr::read_rds("../data/WLR_other_fields.rds")
```

    ##  [1] "DWR_ORGANIZATION_ID"            "WATER_SUPPLIER_NAME"           
    ##  [3] "SUBMITTED_DATE"                 "WUEDATA_PLAN_REPORT_YEAR"      
    ##  [5] "CONTACT_NAME"                   "CONTACT_EMAIL_ADDRESS"         
    ##  [7] "CONTACT_PHONE"                  "CONTACT_PHONE_EXT"             
    ##  [9] "SUPPLIER_NAME"                  "CITY_TOWN_MUNICIPALITY"        
    ## [11] "STATE_PROVINCE"                 "COUNTRY"                       
    ## [13] "REPORTING_YEAR"                 "REPORTING_YEAR_TYPE"           
    ## [15] "REPORTING_START_DATE"           "REPORTING_END_DATE"            
    ## [17] "AUDIT_PREPARATION_DATE"         "VOLUME_REPORTING_UNITS"        
    ## [19] "PWS_ID_OR_OTHER_ID"             "WL_UNAUTH_CONS_VOL_COMMENT"    
    ## [21] "WL_UNAUTH_CONS_VOL"             "WL_UNAUTH_CONS_VOL_AF"         
    ## [23] "WL_UNAUTH_CONS_ERR_ADJ_TYPE"    "WL_UNAUTH_CONS_ERR_PERCENT"    
    ## [25] "WL_UNAUTH_CONS_ERR_VOL"         "WL_UNAUTH_CONS_ERR_VOL_AF"     
    ## [27] "WL_CUST_MTR_INACC_VOL_COMMENT"  "WL_CUST_MTR_INACC_VOL"         
    ## [29] "WL_CUST_MTR_INACC_VOL_AF"       "WL_CUST_MTR_INACC_ERR_ADJ_TYPE"
    ## [31] "WL_CUST_MTR_INACC_ERR_PERCENT"  "WL_CUST_MTR_INACC_ERR_VOL"     
    ## [33] "WL_CUST_MTR_INACC_ERR_VOL_AF"   "WL_SYS_DATA_ERR_VOL_COMMENT"   
    ## [35] "WL_SYS_DATA_ERR_VOL"            "WL_SYS_DATA_ERR_VOL_AF"        
    ## [37] "WL_SYS_DATA_ERR_ERR_ADJ_TYPE"   "WL_SYS_DATA_ERR_ERR_PERCENT"   
    ## [39] "WL_SYS_DATA_ERR_ERR_VOL"        "WL_SYS_DATA_ERR_ERR_VOL_AF"    
    ## [41] "WL_APPARENT_LOSSES_VOL"         "WL_APPARENT_LOSSES_VOL_AF"     
    ## [43] "WL_REAL_LOSSES_VOL"             "WL_REAL_LOSSES_VOL_AF"         
    ## [45] "WL_WATER_LOSSES_VOL"            "WL_WATER_LOSSES_VOL_AF"        
    ## [47] "NRW_NON_REVENUE_WATER_VOL"      "NRW_NON_REVENUE_WATER_VOL_AF"  
    ## [49] "SD_LENGTH_MAINS_COMMENT"        "SD_LENGTH_MAINS_MILES"         
    ## [51] "SD_NUM_SERVICE_CONN_COMMENT"    "SD_NUM_SERVICE_CONN"           
    ## [53] "SD_SERVICE_CON_DENSITY"         "SD_CUST_MTR_CURB_PROP_COMMENT" 
    ## [55] "SD_CUST_MTR_CURB_PROP_YES_NO"   "SD_AVG_OPER_PRESSURE_COMMENT"  
    ## [57] "SD_AVG_OPER_PRESSURE_PSI"       "CD_TOTAL_ANNUAL_COST_COMMENT"  
    ## [59] "CD_TOTAL_ANNUAL_COST"           "CD_CUST_RET_UNIT_COST_COMMENT" 
    ## [61] "CD_CUST_RET_UNIT_COST"          "CD_CUST_RET_UNIT_COST_UNITS"   
    ## [63] "CD_VARIABLE_PROD_COST_COMMENT"  "CD_VARIABLE_PROD_COST"         
    ## [65] "WATER_AUDIT_VALIDITY_SCORE"     "PRIORITY_AREA_1"               
    ## [67] "PRIORITY_AREA_2"                "PRIORITY_AREA_3"               
    ## [69] "SA_APPARENT_LOSSES_VOL"         "SA_REAL_LOSSES_VOL"            
    ## [71] "SA_WATER_LOSSES_VOL"            "SA_UNAVOID_ANN_REAL_LOSSES_VOL"
    ## [73] "SA_APPARENT_LOSSES_ANN_COST"    "SA_REAL_LOSSES_ANN_COST"       
    ## [75] "SA_ANNUAL_COST_VALUED_AT"       "PI_FI_NON_REV_PERCENT_BY_VOL"  
    ## [77] "PI_FI_NON_REV_PERCENT_BY_COST"  "PI_OE_APPARENT_LOSSES_GCD"     
    ## [79] "PI_OE_REAL_LOSSES_GCD"          "PI_OE_REAL_LOSSES_GMD"         
    ## [81] "PI_OE_REAL_LOSSES_GCD_PSI"      "PI_CURRENT_ANN_REAL_LOSSES_VOL"
    ## [83] "PI_INFRASTRUCT_LEAKAGE_INDEX"
