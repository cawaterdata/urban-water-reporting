library(tidyverse)

responses_raw <- read_csv("data-raw/reporting_hours_responses.csv")
# TODO
# need to reach out to respondents to ask about UWMP hours (were these divided by year or reported for the 5 year cycle)

responses_clean <- responses_raw |> 
  # assume all are being reported annually
  mutate(ear_staff_hours = case_when(ear_staff_hours == "50 hours per year" ~ 50,
                                     ear_staff_hours == "45 hours" ~ 45,
                                     ear_staff_hours == "450 hours per year" ~ 450,
                                     ear_staff_hours == "84 hours annually" ~ 84,
                                     ear_staff_hours == "80 per year" ~ 80,
                                     T ~ as.numeric(ear_staff_hours)),
         awsda_staff_hours = case_when(awsda_staff_hours == "8 hours per year" ~ 8,
                                       awsda_staff_hours == "40 hours" ~ 40,
                                       awsda_staff_hours == "55 hours per year" ~ 55,
                                       awsda_staff_hours == "10 per year" ~ 10, 
                                       T ~ as.numeric(awsda_staff_hours)),
         wla_staff_hours = case_when(wla_staff_hours == "n/a" | wla_staff_hours == "none, as it's a retail requirement" ~ NA_real_,
                                     wla_staff_hours == "35 hours" ~ 35,
                                     wla_staff_hours == "24 hours annually" ~ 24,
                                     wla_staff_hours == "80 per year" ~ 80,
                                     T ~ as.numeric(wla_staff_hours)),
         uwmp_staff_hours = case_when(uwmp_staff_hours == "500 hours per cycle" ~ 500,
                                      uwmp_staff_hours == "average 400 hrs per year (done every 5 years)" ~ 2000,
                                      uwmp_staff_hours == ">1000 hours (for each UWMP cycle)" ~ 1000,
                                      uwmp_staff_hours == "600" ~ 3000, # in comments said divided by 5 to reflect annual, I converted to per cycle
                                      uwmp_staff_hours == "400 per plan" ~ 400,
                                      T ~ as.numeric(uwmp_staff_hours)),
         uwmp_staff_annual_hours = uwmp_staff_hours/5,
         dctro_staff_hours = case_when(dctro_staff_hours == "n/a" ~ NA_real_,
                                       dctro_staff_hours == "60?" ~ 60,
                                       dctro_staff_hours == "50 hours per year" ~ 50,
                                       dctro_staff_hours == "15 hours per month" ~ 180,
                                       dctro_staff_hours == "8 hours monthly" ~ 96,
                                       dctro_staff_hours == "40 per year" ~ 40,
                                       T ~ as.numeric(dctro_staff_hours)),
         wuo_staff_hours = case_when(wuo_staff_hours == "n/a" | wuo_staff_hours == "Reported as part of UWMP and AWSDA" | wuo_staff_hours == "none, as it's a retail requirement" ~ NA_real_,
                                     wuo_staff_hours == "80 hours annually" ~ 80,
                                     wuo_staff_hours == "8 for the DWR Interim Report" ~ 8,
                                     T ~ as.numeric(wuo_staff_hours)),
         ear_contractor_hours = case_when(ear_contractor_hours == "n/a" ~ NA_real_,
                                          ear_contractor_hours == "0 hours" ~ 0,
                                          T ~ as.numeric(ear_contractor_hours)),
         awsda_contractor_hours = case_when(awsda_contractor_hours == "$18,000" ~ 120, #assume $150/hour
                                            awsda_contractor_hours == "0 hours" ~ 0,
                                            T ~ as.numeric(awsda_contractor_hours)),
         wla_contractor_hours = case_when(wla_contractor_hours == "$8,000" ~ 53,
                                          wla_contractor_hours == "$3,242" ~ 22,
                                          wla_contractor_hours == "0 hours" ~ 0,
                                          wla_contractor_hours == "10 hours for meetings, additional costs and time for validation" ~ 12, # add 2 hours for the "additional"
                                          wla_contractor_hours == "$2,500" ~ 17,
                                          T ~ as.numeric(wla_contractor_hours)),
         uwmp_contractor_hours = case_when(uwmp_contractor_hours == "500 hours" ~ 500,
                                           uwmp_contractor_hours == "TBD" ~ NA_real_,
                                           uwmp_contractor_hours == "$135,051" ~ 900,
                                           uwmp_contractor_hours == "estimating about 1000 hours for 2025 UWMP consultant support" ~ 1000,
                                           uwmp_contractor_hours == "$200,000" ~ 1333,
                                           uwmp_contractor_hours == "$20,000" ~ 133,
                                           uwmp_contractor_hours == "774" ~ 3800, # in comments said divided by 5 to reflect annual, I converted to per cycle
                                           T ~ as.numeric(uwmp_contractor_hours)),
         uwmp_contractor_annual_hours = uwmp_contractor_hours/5,
         dctro_contractor_hours = case_when(dctro_contractor_hours == "TBD" | dctro_contractor_hours == "n/a" ~ NA_real_,
                                            dctro_contractor_hours == "0 hours" ~ 0,
                                            T ~ as.numeric(dctro_contractor_hours)),
         wuo_contractor_hours = case_when(wuo_contractor_hours == "$440" ~ 3,
                                          wuo_contractor_hours == "n/a" | wuo_contractor_hours == "No comments." ~ NA_real_,
                                          wuo_contractor_hours == "40 hours" ~ 40,
                                          T ~ as.numeric(wuo_contractor_hours)))

write_csv(responses_clean, "data/reporting_hours_clean.csv")



         