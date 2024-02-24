install.packages("dplyr")
install.packages("corrplot")
install.packages("forcats")
install.packages("tidyr")
library(dplyr)
library(readxl)
library(corrplot)
library(ggplot2)
library(tidyr)

ds15 <- read_excel("Downloads/data_accepted_2015.xlsx", sheet = "Sheet1", na = "NA")
ds15 <- ds15 %>%
  mutate(
    emp_length_numeric = as.numeric(gsub("\\D", "", emp_length)),
    emp_length_numeric = case_when(
      emp_length == "< 1 year" ~ 0.9,
      emp_length == "10+ years" ~ 10,
      TRUE ~ emp_length_numeric
    )
  )
ds15$term_numeric <- as.numeric(gsub("\\D", "", ds15$term))
# ds15 <- ds15 %>%
#   mutate(
#     loan_status_numeric = case_when(
#       loan_status == "Current" ~ 1,
#       loan_status == "Charged Off" ~ 2,
#       loan_status == "Fully Paid" ~ 0,
#       loan_status == "In Grace Period" ~ 3,
#       loan_status == "Late (31-120 days)" ~ 4,
#       TRUE ~ NA_integer_
#     )
#   )
# ds15 <- ds15 %>%
#   mutate(
#     purpose_numeric = as.numeric(factor(purpose, levels = unique(purpose)))
#   )
# unique_purpose_mapping <- data.frame(
#   purpose = unique(ds15$purpose),
#   purpose_numeric = as.numeric(factor(unique(ds15$purpose)))
# )

ds15$...18 <- NULL
ds15$...19 <- NULL
ds15$`INFORMATION TO THE ATTRIBUTES`<-NULL


column_names <- names(ds15)
columns_string <- paste(column_names, collapse = ", ")
print(columns_string)



# ds15 <- ds15 %>% select(id, year, funded_amnt, term, term_numeric, grade, emp_title, emp_length, emp_length_numeric, home_ownership, annual_inc, loan_status, loan_status_numeric, purpose, zip_code, addr_state, dti, delinq_2yrs, fico_range_low)
ds15 <- ds15[complete.cases(ds15), ]
# row_indices_with_na <- which(apply(ds15, 1, anyNA)) 
# ^this should return none (not NONE but just no values)

# ds15 <- ds15 %>%
#   mutate(
#     emptitle_numeric = as.numeric(factor(emp_title, levels = unique(emp_title)))
#   )
# unique_emptitle_mapping <- data.frame(
#   emp_title = unique(ds15$emp_title),
#   emp_title_numeric = as.numeric(factor(unique(ds15$emp_title)))
# )
# print(unique_emptitle_mapping)

ds15$ls_origin <- ds15$loan_status
ds15 <- ds15 %>%
  mutate(dummy_variable = 1) %>%
  pivot_wider(names_from = loan_status, values_from = dummy_variable, values_fill = 0)
names(ds15)[names(ds15) == "ls_origin"] <- "loan_status"

# Create a mapping for renaming
column_rename_mapping <- c(
  "Fully Paid" = "loan_status_fully_paid",
  "Charged Off" = "loan_status_charged_off",
  "In Grace Period" = "loan_status_ingrace",
  "Late (16-30 days)" = "loan_status_late1",
  "Late (31-120 days)" = "loan_status_late2",
  "Current" = "loan_status_current"
)

ds15 <- ds15 %>%
  rename(!!!setNames(as.list(names(column_rename_mapping)), column_rename_mapping))


ds15$purpose_origin <- ds15$purpose
ds15 <- ds15 %>%
  mutate(dummy_variable = 1) %>%
  pivot_wider(names_from = purpose, values_from = dummy_variable, values_fill = 0)
names(ds15)[names(ds15) == "purpose_origin"] <- "purpose"

# Create a mapping for renaming
column_rename_mapping_purpose <- c(
  "debt_consolidation" = "purpose_debt_consolidation",
  "other" = "purpose_other",
  "credit_card" = "purpose_credit_card",
  "home_improvement" = "purpose_home_improvement",
  "small_business" = "purpose_small_business",
  "house" = "purpose_house",
  "medical" = "purpose_medical",
  "car" = "purpose_car",
  "major_purchase" = "purpose_major_purchase",
  "vacation" = "purpose_vacation",
  "moving" = "purpose_moving",
  "renewable_energy" = "purpose_renewable_energy",
  "wedding" = "purpose_wedding",
  "educational" = "purpose_educational"
)

# Use rename with unquote-splice
ds15 <- ds15 %>%
  rename(!!!setNames(as.list(names(column_rename_mapping_purpose)), column_rename_mapping_purpose))
new_column_names <- unname(sapply(column_rename_mapping_purpose, function(x) x))
selected_columns <- c("funded_amnt", new_column_names)

ds15 <- ds15 %>%
  mutate(dummy_variable = 1) %>%
  pivot_wider(names_from = home_ownership, values_from = dummy_variable, values_fill = 0)

ds15 <- ds15[!(ds15$ANY == "1"), ]
ds15$ANY <- NULL
ds15 <- ds15[!(ds15$Default == "1"), ]
ds15$Default <- NULL

ds15$term_split <- ds15$term
ds15 <- ds15 %>%
  mutate(dummy_variable = 1) %>%
  pivot_wider(names_from = term, values_from = dummy_variable, values_fill = 0)
colnames(ds15)[colnames(ds15) == 'term_split'] <- 'term'
colnames(ds15)[colnames(ds15) == '36 months'] <- 'term_36'
colnames(ds15)[colnames(ds15) == '60 months'] <- 'term_60'

export_path <- "Downloads/ds15_cleaned_dummies.csv"
write.csv(ds15, file = export_path, row.names = FALSE)