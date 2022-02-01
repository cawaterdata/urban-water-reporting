Report Combinations and Metric Options
================
Erin Cain
2/1/2022

## Reports

There are 5 different reports that must be compared with each other.
There are 10 total comparisons that must be done for each metric. Each
comparison is shown below:

| UWMP                      | Conservation | eAR | Water Loss | Supply & Demand | Water Use Objective |
|---------------------------|--------------|-----|------------|-----------------|---------------------|
| **Conservation**          | \-           | 1   | 2          | 3               | 4                   |
| **eAR**                   | \-           | \-  | 5          | 6               | 7                   |
| **Water Loss**            | \-           | \-  | \-         | 8               | 9                   |
| **Supply & Demand ?**     | \-           | \-  | \-         | \-              | 10                  |
| **Water Use Objective ?** | \-           | \-  | \-         | \-              | \-                  |

Can we do Supply & Demand or Water Use Objective. I think we will have
to hold off on these until there is data \#\# Metrics

``` r
# Conservation Report Metrics
readr::read_rds("data/conservation_report_fields.rds")
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
    ## [13] "REPORTED PRELIMINARY Total Potable Water Production"                 
    ## [14] "REPORTED FINAL Total Potable Water Production"                       
    ## [15] "PRELIMINARY Percent Residential Use"                                 
    ## [16] "FINAL Percent Residential Use"                                       
    ## [17] "REPORTED PRELIMINARY Commercial Agricultural Water"                  
    ## [18] "REPORTED FINAL Commercial Agricultural Water"                        
    ## [19] "REPORTED PRELIMINARY Commercial, Industrial, and Institutional Water"
    ## [20] "REPORTED FINAL Commercial, Industrial, and Institutional Water"      
    ## [21] "REPORTED Recycled Water"                                             
    ## [22] "REPORTED Non-Revenue Water"                                          
    ## [23] "CALCULATED Total Potable Water Production Gallons (Ag Excluded)"     
    ## [24] "CALCULATED Total Potable Water Production Gallons 2013 (Ag Excluded)"
    ## [25] "CALCULATED Commercial Agricultural Water Gallons"                    
    ## [26] "CALCULATED Commercial Agricultural Water Gallons 2013"               
    ## [27] "CALCULATED R-GPCD"                                                   
    ## [28] "Qualification"

``` r
# Some of UWMP Metrics (many more tables we could pull from)
readr::read_rds("data/UWMP_fields.rds")
```

    ##  [1] "ORG_ID"                       "WATER_SUPPLIER_NAME"         
    ##  [3] "WORKSHEET_NAME"               "REVIEWED_BY_DWR"             
    ##  [5] "REQUIREMENTS_ADDRESSED"       "WATER_DEMAND_TYPE"           
    ##  [7] "WATER_DEMAND_VOLUME_2020_AF"  "WATER_DEMAND_VOLUME_2025_AF" 
    ##  [9] "WATER_DEMAND_VOLUME_2030_AF"  "WATER_DEMAND_VOLUME_2035_AF" 
    ## [11] "WATER_DEMAND_VOLUME_2040_AF"  "WATER_DEMAND_VOLUME_2045_AF" 
    ## [13] "WP_WUEDATA_PLAN_ID"           "PUBLIC_WATER_SYSTEM_NUMBER"  
    ## [15] "PUBLIC_WATER_SYSTEM_NAME"     "NUMBER_MUNICIPAL_CONNECTIONS"
    ## [17] "VOLUME_OF_WATER_SUPPLIED_AF"

``` r
# Water Loss Report Metrics
readr::read_rds("data/WLR_fields.rds")
```

    ##   [1] "DWR_ORGANIZATION_ID"            "WATER_SUPPLIER_NAME"           
    ##   [3] "SUBMITTED_DATE"                 "WUEDATA_PLAN_REPORT_YEAR"      
    ##   [5] "CONTACT_NAME"                   "CONTACT_EMAIL_ADDRESS"         
    ##   [7] "CONTACT_PHONE"                  "CONTACT_PHONE_EXT"             
    ##   [9] "SUPPLIER_NAME"                  "CITY_TOWN_MUNICIPALITY"        
    ##  [11] "STATE_PROVINCE"                 "COUNTRY"                       
    ##  [13] "REPORTING_YEAR"                 "REPORTING_YEAR_TYPE"           
    ##  [15] "REPORTING_START_DATE"           "REPORTING_END_DATE"            
    ##  [17] "AUDIT_PREPARATION_DATE"         "VOLUME_REPORTING_UNITS"        
    ##  [19] "PWS_ID_OR_OTHER_ID"             "WS_OWN_SOURCES_VOL_COMMENT"    
    ##  [21] "WS_OWN_SOURCES_VOL"             "WS_OWN_SOURCES_VOL_AF"         
    ##  [23] "WS_OWN_SOURCES_ERR_COMMENT"     "WS_OWN_SOURCES_ERR_ADJ_TYPE"   
    ##  [25] "WS_OWN_SOURCES_ERR_PERCENT"     "WS_OWN_SOURCES_ERR_VOL"        
    ##  [27] "WS_OWN_SOURCES_ERR_VOL_AF"      "WS_IMPORTED_VOL_COMMENT"       
    ##  [29] "WS_IMPORTED_VOL"                "WS_IMPORTED_VOL_AF"            
    ##  [31] "WS_IMPORTED_ERR_COMMENT"        "WS_IMPORTED_ERR_ADJ_TYPE"      
    ##  [33] "WS_IMPORTED_ERR_PERCENT"        "WS_IMPORTED_ERR_VOL"           
    ##  [35] "WS_IMPORTED_ERR_VOL_AF"         "WS_EXPORTED_VOL_COMMENT"       
    ##  [37] "WS_EXPORTED_VOL"                "WS_EXPORTED_VOL_AF"            
    ##  [39] "WS_EXPORTED_ERR_COMMENT"        "WS_EXPORTED_ERR_ADJ_TYPE"      
    ##  [41] "WS_EXPORTED_ERR_PERCENT"        "WS_EXPORTED_ERR_VOL"           
    ##  [43] "WS_EXPORTED_ERR_VOL_AF"         "WS_WATER_SUPPLIED_VOL"         
    ##  [45] "WS_WATER_SUPPLIED_VOL_AF"       "AC_BILL_METER_VOL_COMMENT"     
    ##  [47] "AC_BILL_METER_VOL"              "AC_BILL_METER_VOL_AF"          
    ##  [49] "AC_BILL_UNMETER_VOL_COMMENT"    "AC_BILL_UNMETER_VOL"           
    ##  [51] "AC_BILL_UNMETER_VOL_AF"         "AC_UNBILL_METER_VOL_COMMENT"   
    ##  [53] "AC_UNBILL_METER_VOL"            "AC_UNBILL_METER_VOL_AF"        
    ##  [55] "AC_UNBILL_UNMETER_VOL_COMMENT"  "AC_UNBILL_UNMETER_VOL"         
    ##  [57] "AC_UNBILL_UNMETER_VOL_AF"       "AC_UNBILL_UNMETER_ERR_ADJ_TYPE"
    ##  [59] "AC_UNBILL_UNMETER_ERR_PERCENT"  "AC_UNBILL_UNMETER_ERR_VOL"     
    ##  [61] "AC_UNBILL_UNMETER_ERR_VOL_AF"   "AC_AUTH_CONSUMPTION_VOL"       
    ##  [63] "AC_AUTH_CONSUMPTION_VOL_AF"     "WL_UNAUTH_CONS_VOL_COMMENT"    
    ##  [65] "WL_UNAUTH_CONS_VOL"             "WL_UNAUTH_CONS_VOL_AF"         
    ##  [67] "WL_UNAUTH_CONS_ERR_ADJ_TYPE"    "WL_UNAUTH_CONS_ERR_PERCENT"    
    ##  [69] "WL_UNAUTH_CONS_ERR_VOL"         "WL_UNAUTH_CONS_ERR_VOL_AF"     
    ##  [71] "WL_CUST_MTR_INACC_VOL_COMMENT"  "WL_CUST_MTR_INACC_VOL"         
    ##  [73] "WL_CUST_MTR_INACC_VOL_AF"       "WL_CUST_MTR_INACC_ERR_ADJ_TYPE"
    ##  [75] "WL_CUST_MTR_INACC_ERR_PERCENT"  "WL_CUST_MTR_INACC_ERR_VOL"     
    ##  [77] "WL_CUST_MTR_INACC_ERR_VOL_AF"   "WL_SYS_DATA_ERR_VOL_COMMENT"   
    ##  [79] "WL_SYS_DATA_ERR_VOL"            "WL_SYS_DATA_ERR_VOL_AF"        
    ##  [81] "WL_SYS_DATA_ERR_ERR_ADJ_TYPE"   "WL_SYS_DATA_ERR_ERR_PERCENT"   
    ##  [83] "WL_SYS_DATA_ERR_ERR_VOL"        "WL_SYS_DATA_ERR_ERR_VOL_AF"    
    ##  [85] "WL_APPARENT_LOSSES_VOL"         "WL_APPARENT_LOSSES_VOL_AF"     
    ##  [87] "WL_REAL_LOSSES_VOL"             "WL_REAL_LOSSES_VOL_AF"         
    ##  [89] "WL_WATER_LOSSES_VOL"            "WL_WATER_LOSSES_VOL_AF"        
    ##  [91] "NRW_NON_REVENUE_WATER_VOL"      "NRW_NON_REVENUE_WATER_VOL_AF"  
    ##  [93] "SD_LENGTH_MAINS_COMMENT"        "SD_LENGTH_MAINS_MILES"         
    ##  [95] "SD_NUM_SERVICE_CONN_COMMENT"    "SD_NUM_SERVICE_CONN"           
    ##  [97] "SD_SERVICE_CON_DENSITY"         "SD_CUST_MTR_CURB_PROP_COMMENT" 
    ##  [99] "SD_CUST_MTR_CURB_PROP_YES_NO"   "SD_AVG_OPER_PRESSURE_COMMENT"  
    ## [101] "SD_AVG_OPER_PRESSURE_PSI"       "CD_TOTAL_ANNUAL_COST_COMMENT"  
    ## [103] "CD_TOTAL_ANNUAL_COST"           "CD_CUST_RET_UNIT_COST_COMMENT" 
    ## [105] "CD_CUST_RET_UNIT_COST"          "CD_CUST_RET_UNIT_COST_UNITS"   
    ## [107] "CD_VARIABLE_PROD_COST_COMMENT"  "CD_VARIABLE_PROD_COST"         
    ## [109] "WATER_AUDIT_VALIDITY_SCORE"     "PRIORITY_AREA_1"               
    ## [111] "PRIORITY_AREA_2"                "PRIORITY_AREA_3"               
    ## [113] "SA_APPARENT_LOSSES_VOL"         "SA_REAL_LOSSES_VOL"            
    ## [115] "SA_WATER_LOSSES_VOL"            "SA_UNAVOID_ANN_REAL_LOSSES_VOL"
    ## [117] "SA_APPARENT_LOSSES_ANN_COST"    "SA_REAL_LOSSES_ANN_COST"       
    ## [119] "SA_ANNUAL_COST_VALUED_AT"       "PI_FI_NON_REV_PERCENT_BY_VOL"  
    ## [121] "PI_FI_NON_REV_PERCENT_BY_COST"  "PI_OE_APPARENT_LOSSES_GCD"     
    ## [123] "PI_OE_REAL_LOSSES_GCD"          "PI_OE_REAL_LOSSES_GMD"         
    ## [125] "PI_OE_REAL_LOSSES_GCD_PSI"      "PI_CURRENT_ANN_REAL_LOSSES_VOL"
    ## [127] "PI_INFRASTRUCT_LEAKAGE_INDEX"   "WS_UNITS_SHORT"
