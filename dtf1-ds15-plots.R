#dtf1-replicate-ds15-plots, dtf1-ds15-plots
install.packages("ggcorrplot")
library(ggcorrplot)
library(ggplot2)

column_names <- names(ds15)
columns_string <- paste(column_names, collapse = ", ")
print(columns_string)
#[1] "id, year, funded_amnt, term, grade, emp_title, emp_length, annual_inc
# zip_code, addr_state, dti, delinq_2yrs, fico_range_low, emp_length_numeric
# term_numeric, loan_status, loan_status_current, loan_status_late2, loan_status_fully_paid
# loan_status_charged_off, loan_status_ingrace, loan_status_late1, purpose, purpose_debt_consolidation
# purpose_other, purpose_credit_card, purpose_home_improvement, purpose_small_business, purpose_house
# purpose_medical, purpose_car, purpose_major_purchase, purpose_vacation, purpose_moving, purpose_renewable_energy,
# purpose_wedding, purpose_educational, MORTGAGE, OWN, RENT"

cor_matrix <- round(cor(ds15[, c("delinq_2yrs", "fico_range_low", "dti", "annual_inc", "funded_amnt", "emp_length_numeric", "loan_status_current", "loan_status_fully_paid", "loan_status_charged_off", "loan_status_late1", "loan_status_late2", "loan_status_ingrace", "MORTGAGE", "OWN", "RENT")]), 1)
ggcorrplot(cor_matrix, lab=T)

cor_matrix <- cor(ds15[, c("delinq_2yrs", "fico_range_low", "dti", "annual_inc", "funded_amnt", "emp_length_numeric", "loan_status_current", "loan_status_fully_paid", "loan_status_charged_off", "loan_status_late1", "loan_status_late2", "loan_status_ingrace", "MORTGAGE", "OWN", "RENT")])
ggcorrplot(cor_matrix, lab=T)


#the big correl matrix
numeric_data <- ds15[sapply(ds15, is.numeric) & colnames(ds15) != "id" & colnames(ds15) != "year" & colnames(ds15) != "term_numeric"]
correlation_matrix <- cor(numeric_data, use = "complete.obs", method = "pearson")
ggcorrplot(correlation_matrix, type = "full", method = "square", colors = c("blue", "white", "red"))



fico_model <- lm(fico_range_low ~ delinq_2yrs + dti + annual_inc + funded_amnt + term_numeric + grade + emp_length_numeric + MORTGAGE + OWN + RENT +
              +                 loan_status_current + loan_status_fully_paid + 
              +                 loan_status_charged_off + loan_status_ingrace + loan_status_late1 + loan_status_late2 + 
              +                 purpose_car + purpose_credit_card + purpose_debt_consolidation + purpose_home_improvement + purpose_other, data = ds15)
summary(fico_model)

delinq_model <- lm(delinq_2yrs ~ fico_range_low, data = ds15)
ggplot(ds15, aes(x = fico_range_low, y = delinq_2yrs)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(title = "", x = "FICO Range Low", y = "Delinquencies in the Last 2 Years")

funded_annui_model <- lm(funded_amnt ~ annual_inc, data = ds15)
ggplot(ds15, aes(x = annual_inc, y = funded_amnt)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "green")
## ^This one shows extreme outlier(s)

# Set the upper percentile limit (e.g., 0.98)
upper_percentile_limit <- 0.95
# Filter data based on the upper percentile limit
filtered_ds <- ds15[ds15$funded_amnt <= quantile(ds15$funded_amnt, upper_percentile_limit),]
# Fit a linear regression model
funded_annui_model <- lm(funded_amnt ~ annual_inc, data = filtered_ds)
# Create a scatter plot with the regression line using ggplot2
ggplot(filtered_ds, aes(x = annual_inc, y = funded_amnt)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue", formula = y ~ x) +
  labs(title = "Scatter Plot with Regression Line (Upper Percentile Limit)", x = "Annual Income", y = "Funded Amount")

delinq_model <- lm(delinq_2yrs ~ fico_range_low + dti + annual_inc + funded_amnt + emp_length_numeric + loan_status_current + loan_status_fully_paid + loan_status_charged_off + loan_status_ingrace + loan_status_late1 + loan_status_late2 + MORTGAGE + RENT, data=ds15)


term_dti_model <- lm(term_numeric ~ dti, data = ds15)
ggplot(ds15, aes(x = term_numeric, y = dti)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "green")


fico_model <- lm(fico_range_low ~ delinq_2yrs + dti + annual_inc + funded_amnt + term_numeric + grade + emp_length_numeric + MORTGAGE + OWN + RENT +
                   +                 loan_status_current + loan_status_fully_paid + 
                   +                 loan_status_charged_off + loan_status_ingrace + loan_status_late1 + loan_status_late2 + 
                   +                 purpose_car + purpose_credit_card + purpose_debt_consolidation + purpose_home_improvement + purpose_other, data = ds15)
summary(fico_model)

#Split term into dummies, removed grade

fico_model <- lm(fico_range_low ~ delinq_2yrs + dti + annual_inc + funded_amnt + term_36 + term_60 + emp_length_numeric + MORTGAGE + OWN + RENT +
                   +                 loan_status_current + loan_status_fully_paid + 
                   +                 loan_status_charged_off + loan_status_ingrace + loan_status_late1 + loan_status_late2 + 
                   +                 purpose_car + purpose_credit_card + purpose_debt_consolidation + purpose_home_improvement + purpose_other, data = ds15)
summary(fico_model)

#delinq_model <- lm(delinq_2yrs ~ fico_range_low, data = ds15)
ggplot(ds15[ds15$delinq_2yrs <= 26, ], aes(x = fico_range_low, y = delinq_2yrs)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(title = "", x = "FICO score", y = "Delinquencies in the last 2 years") +
  theme(axis.title.x = element_text(size = 20), axis.title.y = element_text(size = 20), axis.text.x = element_text(size = 15),  # Adjust x-axis numbers size
        axis.text.y = element_text(size = 15))

ggplot(ds15[ds15$dti <= 104 & ds15$delinq_2yrs <= 26, ], aes(x = dti, y = delinq_2yrs)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(title = "", x = "Debt-to-Income", y = "Delinquencies in the last 2 years") +
  theme(axis.title.x = element_text(size = 20), axis.title.y = element_text(size = 20), axis.text.x = element_text(size = 15),  # Adjust x-axis numbers size
        axis.text.y = element_text(size = 15))

ggplot(ds15, aes(x = fico_range_low, y = dti)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(title = "", x = "Debt-to-Income", y = "Delinquencies in the last 2 years") +
  theme(axis.title.x = element_text(size = 20), axis.title.y = element_text(size = 20))
