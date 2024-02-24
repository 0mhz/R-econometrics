model <- lm(fico_range_low ~ delinq_2yrs + funded_amnt + annual_inc + dti + 
                +                 loan_status_current + loan_status_fully_paid + 
                +                 loan_status_charged_off + loan_status_ingrace + loan_status_late + term_numeric + emp_length_numeric + grade + MORTGAGE + OWN + RENT, data = ds)
summary(model)

# Call:
#   lm(formula = fico_range_low ~ delinq_2yrs + funded_amnt + annual_inc + 
#        dti + loan_status_current + loan_status_fully_paid + loan_status_charged_off + 
#        loan_status_ingrace + loan_status_late + term_numeric + emp_length_numeric + 
#        grade + MORTGAGE + OWN + RENT, data = ds)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -76.667 -17.837  -4.619  12.840 169.206 
# 
# Coefficients: (2 not defined because of singularities)
# Estimate Std. Error  t value Pr(>|t|)    
# (Intercept)              6.945e+02  3.733e-01 1860.325  < 2e-16 ***
#   delinq_2yrs             -4.609e+00  4.438e-02 -103.850  < 2e-16 ***
#   funded_amnt              4.058e-04  5.582e-06   72.688  < 2e-16 ***
#   annual_inc              -4.437e-06  6.000e-07   -7.396 1.41e-13 ***
#   dti                      7.683e-02  4.967e-03   15.466  < 2e-16 ***
#   loan_status_current      1.859e+00  3.112e-01    5.976 2.29e-09 ***
#   loan_status_fully_paid   5.388e+00  3.172e-01   16.987  < 2e-16 ***
#   loan_status_charged_off  1.175e+00  3.349e-01    3.507 0.000453 ***
#   loan_status_ingrace     -1.832e+00  5.082e-01   -3.605 0.000313 ***
#   loan_status_late                NA         NA       NA       NA    
# term_numeric             3.790e-01  4.437e-03   85.428  < 2e-16 ***
#   emp_length_numeric      -2.197e-03  1.175e-02   -0.187 0.851730    
# gradeB                  -2.502e+01  1.278e-01 -195.779  < 2e-16 ***
#   gradeC                  -3.491e+01  1.319e-01 -264.653  < 2e-16 ***
#   gradeD                  -4.025e+01  1.570e-01 -256.380  < 2e-16 ***
#   gradeE                  -4.458e+01  1.916e-01 -232.675  < 2e-16 ***
#   gradeF                  -4.769e+01  3.027e-01 -157.556  < 2e-16 ***
#   gradeG                  -4.917e+01  5.888e-01  -83.500  < 2e-16 ***
#   MORTGAGE                 3.330e+00  9.181e-02   36.271  < 2e-16 ***
#   OWN                      3.937e+00  1.449e-01   27.175  < 2e-16 ***
#   RENT                            NA         NA       NA       NA    
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 25.88 on 395475 degrees of freedom
# Multiple R-squared:  0.2545,	Adjusted R-squared:  0.2545 
# F-statistic:  7502 on 18 and 395475 DF,  p-value: < 2.2e-16
# 
# > cor_matrix <- round(cor(data_accepted_2015_sorted[, c("funded_amnt", "annual_inc", "dti", "delinq_2yrs", "fico_range_low", "emp_length_numeric", "loan_status_current", "loan_status_fully_paid", "loan_status_charged_off", "loan_status_late", "loan_status_ingrace", "MORTGAGE", "RENT", "OWN")]), 1)
# > ggcorrplot(cor_matrix, lab=T)
# > 
#   > model <- lm(fico_range_low ~ delinq_2yrs + funded_amnt + annual_inc + dti + 
#                   +                 loan_status_current + loan_status_fully_paid + 
#                   +                 loan_status_charged_off + loan_status_ingrace + loan_status_late + term_numeric + emp_length_numeric + grade + MORTGAGE + OWN + RENT + purpose, data = ds)
# Error in eval(predvars, data, env) : object 'purpose' not found
# > 
model <- lm(fico_range_low ~ delinq_2yrs + funded_amnt + annual_inc + dti +
                  +                 loan_status_current + loan_status_fully_paid +
                  +                 loan_status_charged_off + loan_status_ingrace + loan_status_late + term_numeric + emp_length_numeric + grade + MORTGAGE + OWN + RENT + purpose_modified, data = ds)
summary(model)
# 
# Call:
#   lm(formula = fico_range_low ~ delinq_2yrs + funded_amnt + annual_inc + 
#        dti + loan_status_current + loan_status_fully_paid + loan_status_charged_off + 
#        loan_status_ingrace + loan_status_late + term_numeric + emp_length_numeric + 
#        grade + MORTGAGE + OWN + RENT + purpose_modified, data = ds)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -76.817 -17.499  -4.309  12.930 163.704 
# 
# Coefficients: (2 not defined because of singularities)
# Estimate Std. Error  t value Pr(>|t|)    
# (Intercept)                              6.877e+02  3.756e-01 1831.183  < 2e-16 ***
#   delinq_2yrs                             -4.673e+00  4.377e-02 -106.753  < 2e-16 ***
#   funded_amnt                              4.994e-04  5.585e-06   89.421  < 2e-16 ***
#   annual_inc                              -8.244e-06  5.930e-07  -13.902  < 2e-16 ***
#   dti                                      1.314e-01  4.933e-03   26.631  < 2e-16 ***
#   loan_status_current                      1.727e+00  3.069e-01    5.628 1.82e-08 ***
#   loan_status_fully_paid                   5.178e+00  3.128e-01   16.556  < 2e-16 ***
#   loan_status_charged_off                  1.026e+00  3.302e-01    3.108 0.001884 ** 
#   loan_status_ingrace                     -1.655e+00  5.011e-01   -3.302 0.000962 ***
#   loan_status_late                                NA         NA       NA       NA    
# term_numeric                             4.147e-01  4.390e-03   94.470  < 2e-16 ***
#   emp_length_numeric                      -3.269e-02  1.160e-02   -2.818 0.004836 ** 
#   gradeB                                  -2.587e+01  1.264e-01 -204.701  < 2e-16 ***
#   gradeC                                  -3.693e+01  1.319e-01 -279.894  < 2e-16 ***
#   gradeD                                  -4.318e+01  1.579e-01 -273.507  < 2e-16 ***
#   gradeE                                  -4.815e+01  1.926e-01 -250.063  < 2e-16 ***
#   gradeF                                  -5.214e+01  3.018e-01 -172.767  < 2e-16 ***
#   gradeG                                  -5.474e+01  5.832e-01  -93.863  < 2e-16 ***
#   MORTGAGE                                 2.895e+00  9.171e-02   31.566  < 2e-16 ***
#   OWN                                      3.439e+00  1.436e-01   23.949  < 2e-16 ***
#   RENT                                            NA         NA       NA       NA    
# purpose_modifieddebt_consolidation       5.063e+00  1.002e-01   50.524  < 2e-16 ***
#   purpose_modifiedhome_improvement         1.064e+01  1.906e-01   55.841  < 2e-16 ***
#   purpose_modifiedHousehold, Medical, SBs  1.676e+01  1.931e-01   86.781  < 2e-16 ***
#   purpose_modifiedother                    1.489e+01  2.147e-01   69.351  < 2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 25.53 on 395471 degrees of freedom
# Multiple R-squared:  0.2751,	Adjusted R-squared:  0.275 
# F-statistic:  6820 on 22 and 395471 DF,  p-value: < 2.2e-16

model <- lm(fico_range_low ~ delinq_2yrs + funded_amnt + annual_inc + dti + 
                  +                 loan_status_current + loan_status_fully_paid + 
                  +                 loan_status_charged_off + loan_status_ingrace + loan_status_late + term_numeric + emp_length_numeric + grade + MORTGAGE + OWN + RENT + ds$purpose_car + ds$purpose_credit_card + ds$purpose_debt_consolidation + ds$purpose_educational + ds$purpose_home_improvement + ds$purpose_house + ds$purpose_major_purchase + ds$purpose_other + ds$purpose_medical + ds$purpose_wedding + ds$purpose_vacation, data = ds)
summary(model)

# Call:
#   lm(formula = fico_range_low ~ delinq_2yrs + funded_amnt + annual_inc + 
#        dti + loan_status_current + loan_status_fully_paid + loan_status_charged_off + 
#        loan_status_ingrace + loan_status_late + term_numeric + emp_length_numeric + 
#        grade + MORTGAGE + OWN + RENT + ds$purpose_car + ds$purpose_credit_card + 
#        ds$purpose_debt_consolidation + ds$purpose_educational + 
#        ds$purpose_home_improvement + ds$purpose_house + ds$purpose_major_purchase + 
#        ds$purpose_other + ds$purpose_medical + ds$purpose_wedding + 
#        ds$purpose_vacation, data = ds)
# 
# Residuals:
#   Min     1Q Median     3Q    Max 
# -77.44 -17.50  -4.29  12.93 163.83 
# 
# Coefficients: (2 not defined because of singularities)
# Estimate Std. Error  t value Pr(>|t|)    
# (Intercept)                    7.086e+02  4.935e-01 1435.897  < 2e-16 ***
#   delinq_2yrs                   -4.673e+00  4.376e-02 -106.802  < 2e-16 ***
#   funded_amnt                    4.967e-04  5.591e-06   88.839  < 2e-16 ***
#   annual_inc                    -8.404e-06  5.928e-07  -14.176  < 2e-16 ***
#   dti                            1.330e-01  4.933e-03   26.967  < 2e-16 ***
#   loan_status_current            1.720e+00  3.068e-01    5.608 2.04e-08 ***
#   loan_status_fully_paid         5.178e+00  3.126e-01   16.561  < 2e-16 ***
#   loan_status_charged_off        1.022e+00  3.301e-01    3.097  0.00196 ** 
#   loan_status_ingrace           -1.629e+00  5.009e-01   -3.253  0.00114 ** 
#   loan_status_late                      NA         NA       NA       NA    
# term_numeric                   4.186e-01  4.394e-03   95.262  < 2e-16 ***
#   emp_length_numeric            -3.154e-02  1.160e-02   -2.719  0.00655 ** 
#   gradeB                        -2.592e+01  1.264e-01 -205.067  < 2e-16 ***
#   gradeC                        -3.704e+01  1.321e-01 -280.361  < 2e-16 ***
#   gradeD                        -4.338e+01  1.583e-01 -274.033  < 2e-16 ***
#   gradeE                        -4.841e+01  1.931e-01 -250.729  < 2e-16 ***
#   gradeF                        -5.248e+01  3.023e-01 -173.597  < 2e-16 ***
#   gradeG                        -5.537e+01  5.841e-01  -94.781  < 2e-16 ***
#   MORTGAGE                       2.921e+00  9.169e-02   31.855  < 2e-16 ***
#   OWN                            3.463e+00  1.435e-01   24.125  < 2e-16 ***
#   RENT                                  NA         NA       NA       NA    
# ds$purpose_car                -8.557e+00  5.626e-01  -15.210  < 2e-16 ***
#   ds$purpose_credit_card        -2.095e+01  3.547e-01  -59.063  < 2e-16 ***
#   ds$purpose_debt_consolidation -1.585e+01  3.461e-01  -45.792  < 2e-16 ***
#   ds$purpose_educational        -1.313e+01  2.552e+01   -0.514  0.60692    
# ds$purpose_home_improvement   -1.028e+01  3.819e-01  -26.919  < 2e-16 ***
#   ds$purpose_house               1.285e+00  7.670e-01    1.675  0.09388 .  
# ds$purpose_major_purchase     -5.304e+00  4.580e-01  -11.579  < 2e-16 ***
#   ds$purpose_other              -5.994e+00  3.899e-01  -15.373  < 2e-16 ***
#   ds$purpose_medical            -6.229e+00  5.453e-01  -11.423  < 2e-16 ***
#   ds$purpose_wedding            -1.107e+01  1.276e+01   -0.867  0.38593    
# ds$purpose_vacation           -4.451e+00  6.579e-01   -6.766 1.33e-11 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 25.52 on 395464 degrees of freedom
# Multiple R-squared:  0.2757,	Adjusted R-squared:  0.2756 
# F-statistic:  5190 on 29 and 395464 DF,  p-value: < 2.2e-16
