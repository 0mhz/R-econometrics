install.packages("dplyr")
install.packages("corrplot")
install.packages("forcats")
install.packages("tidyr")
library(dplyr)
library(readxl)
library(corrplot)
library(ggplot2)
library(tidyr)
data_accepted_2015 <- read_excel("Downloads/data_accepted_2015.xlsx", sheet = "Sheet1", na = "NA")
data_accepted_2015 <- data_accepted_2015 %>%
  mutate(
    emp_length_numeric = as.numeric(gsub("\\D", "", emp_length)),
    emp_length_numeric = case_when(
      emp_length == "< 1 year" ~ 0.9,
      emp_length == "10+ years" ~ 10,
      TRUE ~ emp_length_numeric
    )
  )
data_accepted_2015$term_numeric <- as.numeric(gsub("\\D", "", data_accepted_2015$term))
data_accepted_2015 <- data_accepted_2015 %>%
  mutate(
    loan_status_numeric = case_when(
      loan_status == "Current" ~ 1,
      loan_status == "Charged Off" ~ 2,
      loan_status == "Fully Paid" ~ 0,
      loan_status == "In Grace Period" ~ 3,
      loan_status == "Late (31-120 days)" ~ 4,
      TRUE ~ NA_integer_
    )
  )
data_accepted_2015 <- data_accepted_2015 %>%
  mutate(
    purpose_numeric = as.numeric(factor(purpose, levels = unique(purpose)))
  )
unique_purpose_mapping <- data.frame(
  purpose = unique(data_accepted_2015$purpose),
  purpose_numeric = as.numeric(factor(unique(data_accepted_2015$purpose)))
)
print(unique_purpose_mapping)

#               purpose purpose_numeric
# 1  debt_consolidation               3
# 2               other              10
# 3         credit_card               2
# 4    home_improvement               5
# 5      small_business              12
# 6               house               6
# 7             medical               8
# 8                 car               1
# 9      major_purchase               7
# 10           vacation              13
# 11             moving               9
# 12   renewable_energy              11
# 13            wedding              14
# 14        educational               4


data_accepted_2015$...18 <- NULL
data_accepted_2015$...19 <- NULL
data_accepted_2015$`INFORMATION TO THE ATTRIBUTES`<-NULL

# Assuming your data frame is named 'data_accepted_2015'
column_names <- names(data_accepted_2015)
# Concatenate column names into a single string with a separator (e.g., comma)
columns_string <- paste(column_names, collapse = ", ")
# or using paste0 without a separator
# columns_string <- paste0(column_names, collapse = "")
# Print or use the resulting string
print(columns_string)

# "id, year, funded_amnt, term, grade, emp_title, emp_length, home_ownership,
# annual_inc, loan_status, purpose, zip_code, addr_state, dti, delinq_2yrs,
# fico_range_low, home_ownership_numeric, emp_length_numeric, term_numeric,
# loan_status_numeric, purpose_numeric"


data_accepted_2015_sorted <- data_accepted_2015 %>% select(id, year, funded_amnt, term, term_numeric, grade, emp_title, emp_length, emp_length_numeric, home_ownership,home_ownership_numeric, annual_inc, loan_status, loan_status_numeric, purpose, purpose_numeric, zip_code, addr_state, dti, delinq_2yrs, fico_range_low)

data_accepted_2015_sorted <- data_accepted_2015_sorted[complete.cases(data_accepted_2015_sorted), ]
row_indices_with_na <- which(apply(data_accepted_2015_sorted, 1, anyNA)) 
# ^this should return none (not NONE but just no values)

export_path <- "Downloads/data_accepted_2015_cleaned.csv"
write.csv(data_accepted_2015_sorted, file = export_path, row.names = FALSE)


cor_matrix <- cor(data_accepted_2015_sorted[, c("funded_amnt", "annual_inc", "dti", "delinq_2yrs", "fico_range_low", "emp_length_numeric", "loan_status_numeric", "purpose_numeric")])
corrplot(cor_matrix, method = "color", type = "upper", order = "hclust", tl.col = "black", tl.srt = 45)


data_accepted_2015_sorted <- data_accepted_2015_sorted %>%
  mutate(
    emptitle_numeric = as.numeric(factor(emp_title, levels = unique(emp_title)))
  )
unique_emptitle_mapping <- data.frame(
  emp_title = unique(data_accepted_2015$emp_title),
  emp_title_numeric = as.numeric(factor(unique(data_accepted_2015$emp_title)))
)
print(unique_emptitle_mapping)

# Assuming your data frame is named 'data_accepted_2015_sorted' and the column is 'purpose'
library(dplyr)

# Count occurrences of each category
counts <- data_accepted_2015_sorted %>%
  count(purpose) %>%
  arrange(n)

# Identify the four least frequent categories
categories_to_combine <- counts$purpose[1:7]

# Create a new column with 'Other' for the selected categories
data_accepted_2015_sorted <- data_accepted_2015_sorted %>%
  mutate(purpose_modified = ifelse(purpose %in% categories_to_combine, 'Education, House, Vacation & Wedding', purpose))

# Recount occurrences after consolidation
new_counts <- data_accepted_2015_sorted %>%
  count(purpose_modified)

colors <- c("#92407e", "#f4625d", "#fc8e3a", "#fec007", "#182f58", "#214178", "#3d2b55", "#543b74")
pie(new_counts$n, labels = new_counts$purpose_modified, main = "Consolidated Distribution of Purposes", col=colors)


##### New try #####

# Assuming your data frame is named 'data_accepted_2015_sorted' and the column is 'purpose'
library(dplyr)
library(forcats)

counts <- data_accepted_2015_sorted %>%
  count(purpose) %>%
  arrange(n)

# Identify the four least frequent categories
categories_to_combine <- counts$purpose[1:10]

data_accepted_2015_sorted <- data_accepted_2015_sorted %>%
  mutate(purpose_modified = if_else(purpose %in% categories_to_combine, 'Household, Medical, SBs', as.character(purpose)))

# Recount occurrences after consolidation
new_counts <- data_accepted_2015_sorted %>%
  count(purpose_modified)

# Create a vector of colors for each category
# 3, 2, 1, 4, 5
colors <- c("#214178","#92407e", "#3d2b55", "#fc8e3a", "#cb4573")
# Reorder factor levels by counts
new_counts$purpose_modified <- factor(new_counts$purpose_modified, levels = new_counts$purpose_modified[order(new_counts$n, decreasing = TRUE)])

# Take the first 7 rows (or adjust as needed)
new_counts_subset <- head(new_counts, 7)

# Create a pie chart with assigned colors
pie(new_counts_subset$n, labels = new_counts_subset$purpose_modified, main = "Consolidated Distribution of Purposes", col = colors)

##############


# Count occurrences of each category
counts <- data_accepted_2015_sorted %>%
  count(emp_title) %>%
  arrange(n)
# Count occurrences of each category
counts <- data_accepted_2015_sorted %>%
  count(emp_length_numeric) %>%
  arrange(n)

# Identify the four least frequent categories
categories_to_combine <- counts$emp_length_numeric[1:1]

data_accepted_2015_sorted <- data_accepted_2015_sorted %>%
  mutate(emp_length_modified = if_else(emp_length_numeric %in% categories_to_combine, 'Household, Medical, SBs', as.character(emp_length_numeric)))

# Recount occurrences after consolidation
new_counts <- data_accepted_2015_sorted %>%
  count(emp_length_modified)

# Create a vector of colors for each category
colors <- c("#214178", "#92407e", "#3d2b55", "#fc8e3a", "#cb4573")

# Reorder factor levels by counts
new_counts$emp_length_modified <- factor(new_counts$emp_length_modified, levels = new_counts$emp_length_modified[order(new_counts$n, decreasing = TRUE)])

# Take the first 7 rows (or adjust as needed)
new_counts_subset <- head(new_counts, 7)

# Create a pie chart with assigned colors
pie(new_counts_subset$n, labels = new_counts_subset$emp_length_modified, main = "Consolidated Distribution of Employee Lengths", col = colors)

annui_fico <- lm(ds$annual_inc ~ ds$fico_range_low, data=ds)
annui_dti <- lm(ds$annual_inc ~ ds$dti, data=ds)

# #############
# 
# > 
#   > # Count occurrences of each category
#   > counts <- data_accepted_2015_sorted %>%
#   +     count(grade) %>%
#   +     arrange(n)
# > 
#   > # Identify the one least frequent category
#   > categories_to_combine <- counts$grade[1]
# > 
#   > data_accepted_2015_sorted <- data_accepted_2015_sorted %>%
#   +     mutate(grade_modified = if_else(grade %in% categories_to_combine, 'Other', as.character(grade)))
# > 
#   > # Recount occurrences after consolidation
#   > new_counts <- data_accepted_2015_sorted %>%
#   +     count(grade_modified)
# > 
#   > # Create a vector of colors for each category
#   > colors <- c("#214178", "#92407e", "#3d2b55", "#fc8e3a", "#cb4573")
# > 
#   > # Reorder factor levels by counts
#   > new_counts$grade_modified <- factor(new_counts$grade_modified, levels = new_counts$grade_modified[order(new_counts$n, decreasing = TRUE)])
# > 
#   > # Take the first 7 rows (or adjust as needed)
#   > new_counts_subset <- head(new_counts, 7)
# > 
#   > # Create a pie chart with assigned colors
#   > pie(new_counts_subset$n, labels = new_counts_subset$grade_modified, main = "Consolidated Distribution of Grades", col = colors)



cor_matrix <- cor(data_accepted_2015_sorted[, c("funded_amnt", "annual_inc", "dti", "delinq_2yrs", "fico_range_low", "emp_length_numeric")])
corrplot(cor_matrix, method = "color", type = "upper", order = "hclust", tl.col = "black", tl.srt = 45)

model <- lm(data_accepted_2015_sorted$fico_range_low ~ data_accepted_2015_sorted$delinq_2yrs + data_accepted_2015_sorted$funded_amnt + data_accepted_2015_sorted$annual_inc + data_accepted_2015_sorted$dti, data = data_accepted_2015_sorted)

data_accepted_2015_sorted <- data_accepted_2015_sorted %>%
  mutate(dummy_variable = 1) %>%
  pivot_wider(names_from = loan_status, values_from = dummy_variable, values_fill = 0)

cor_matrix <- cor(data_accepted_2015_sorted[, c("funded_amnt", "annual_inc", "dti", "delinq_2yrs", "fico_range_low", "emp_length_numeric")])
corrplot(cor_matrix, method = "color", type = "upper", order = "hclust", tl.col = "black", tl.srt = 45)

model <- lm(data_accepted_2015_sorted$fico_range_low ~ data_accepted_2015_sorted$delinq_2yrs + data_accepted_2015_sorted$funded_amnt + data_accepted_2015_sorted$annual_inc + data_accepted_2015_sorted$dti + ds$Current + ds$`Late (31-120 days)` + ds$`Fully Paid` + ds$`Charged Off` + ds$`In Grace Period`, data = data_accepted_2015_sorted)

library(dplyr)

# Create a mapping for renaming
column_rename_mapping <- c(
  "Fully Paid" = "loan_status_fully_paid",
  "Charged Off" = "loan_status_charged_off",
  "In Grace Period" = "loan_status_ingrace",
  "Late (31-120 days)" = "loan_status_late",
  "Current" = "loan_status_current"
)

data_accepted_2015_sorted <- data_accepted_2015_sorted %>%
  rename(!!!setNames(as.list(names(column_rename_mapping)), column_rename_mapping))

# Create a mapping for renaming
column_rename_mapping <- c(
  "Current" = "loan_status_current"
)

data_accepted_2015_sorted <- data_accepted_2015_sorted %>%
  rename(!!!setNames(as.list(names(column_rename_mapping)), column_rename_mapping))


data_accepted_2015_sorted <- data_accepted_2015_sorted %>%
  mutate(dummy_variable = 1) %>%
  pivot_wider(names_from = purpose, values_from = dummy_variable, values_fill = 0)

library(dplyr)

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
data_accepted_2015_sorted <- data_accepted_2015_sorted %>%
  rename(!!!setNames(as.list(names(column_rename_mapping_purpose)), column_rename_mapping_purpose))


new_column_names <- unname(sapply(column_rename_mapping_purpose, function(x) x))
selected_columns <- c("funded_amnt", new_column_names)

# Create a subset of the data
subset_data <- data_accepted_2015_sorted[selected_columns]

# Calculate the correlation matrix
correlation_matrix <- cor(subset_data)
# 
# # Print the correlation matrix
# print(correlation_matrix)
# corrplot(correlation_matrix, method = "color", type = "upper", order = "hclust", tl.col = "black", tl.srt = 45)
# 



cor_matrix <- cor(data_accepted_2015_sorted[, c("funded_amnt", "annual_inc", "dti", "delinq_2yrs", "fico_range_low", "emp_length_numeric", "loan_status_current", "loan_status_fully_paid", "loan_status_charged_off", "loan_status_late", "loan_status_ingrace")])
corrplot(cor_matrix, method = "color", type = "upper", order = "hclust", tl.col = "black", tl.srt = 45)

ds <- data_accepted_2015_sorted
model <- lm(ds$fico_range_low ~ ds$delinq_2yrs + ds$funded_amnt + ds$annual_inc + ds$dti + ds$loan_status_current + ds$loan_status_fully_paid + ds$loan_status_charged_off + ds$loan_status_ingrace + ds$loan_status_late)

install.packages("car")
library(car)
model <- lm(fico_range_low ~ delinq_2yrs + funded_amnt + annual_inc + dti + 
              loan_status_current + loan_status_fully_paid + 
              loan_status_charged_off + loan_status_ingrace + loan_status_late, data = ds)
par(mfrow = c(2, 2))  # Set up a 2x2 grid for plots
plot(model)

install.packages("ggcorrplot")
library(ggcorrplot)
cor_matrix <- round(cor(data_accepted_2015_sorted[, c("delinq_2yrs", "fico_range_low", "dti", "annual_inc", "funded_amnt", "emp_length_numeric", "loan_status_current", "loan_status_fully_paid", "loan_status_charged_off", "loan_status_late1", "loan_status_late2", "loan_status_ingrace")]), 1)
ggcorrplot(cor_matrix, lab=T)

## + grade?

model <- lm(fico_range_low ~ delinq_2yrs + funded_amnt + annual_inc + dti + 
              loan_status_current + loan_status_fully_paid + 
              loan_status_charged_off + loan_status_ingrace + loan_status_late + term_numeric + emp_length_numeric + grade, data = ds)


data_accepted_2015_sorted <- data_accepted_2015_sorted %>%
  mutate(dummy_variable = 1) %>%
  pivot_wider(names_from = home_ownership, values_from = dummy_variable, values_fill = 0)

model <- lm(fico_range_low ~ delinq_2yrs + funded_amnt + annual_inc + dti + 
              +                 loan_status_current + loan_status_fully_paid + 
              +                 loan_status_charged_off + loan_status_ingrace + loan_status_late + term_numeric + emp_length_numeric + grade + MORTGAGE + OWN + RENT, data = ds)
summary(model)

cor_matrix <- round(cor(data_accepted_2015_sorted[, c("funded_amnt", "annual_inc", "dti", "delinq_2yrs", "fico_range_low", "emp_length_numeric", "loan_status_current", "loan_status_fully_paid", "loan_status_charged_off", "loan_status_late", "loan_status_ingrace", "MORTGAGE", "RENT", "OWN")]), 1)
ggcorrplot(cor_matrix, lab=T)