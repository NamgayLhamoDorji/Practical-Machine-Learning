# ============================================================
# PRACTICAL MACHINE LEARNING COURSE PROJECT
# Weight Lifting Exercise Prediction
# Algorithm: Random Forest (fast version)
#
# HOW TO RUN: open this file in RStudio and click "Source"
# (Ctrl+Shift+Enter). Do NOT paste it into the console.
# ============================================================


# 1. INSTALL AND LOAD REQUIRED PACKAGES
# ============================================================

packages <- c("caret", "randomForest")

for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}

library(caret)
library(randomForest)


# 2. CREATE PROJECT FOLDER AND SET WORKING DIRECTORY
# ============================================================

project_folder <- "Practical_machine_learning"

if (!dir.exists(project_folder)) {
  dir.create(project_folder)
}

# Only change directory if we are not already inside the folder
if (basename(getwd()) != project_folder) {
  setwd(project_folder)
}

cat("Working directory:", getwd(), "\n")


# 3. DOWNLOAD DATASETS
# ============================================================

base_url <- "https://d396qusza40orc.cloudfront.net/predmachlearn/"

if (!file.exists("pml-training.csv")) {
  download.file(paste0(base_url, "pml-training.csv"),
                "pml-training.csv", mode = "wb")
}

if (!file.exists("pml-testing.csv")) {
  download.file(paste0(base_url, "pml-testing.csv"),
                "pml-testing.csv", mode = "wb")
}

if (file.info("pml-training.csv")$size == 0 ||
    file.info("pml-testing.csv")$size == 0) {
  stop("One or both downloaded files are empty. Delete them and re-run.")
}

cat("Both CSV files are available!\n")


# 4. LOAD DATASETS
# ============================================================

training <- read.csv("pml-training.csv",
                     na.strings = c("", "NA", "#DIV/0!"))

testing <- read.csv("pml-testing.csv",
                    na.strings = c("", "NA", "#DIV/0!"))

cat("Training dimensions:", dim(training), "\n")
cat("Testing dimensions: ", dim(testing), "\n")


# 5. EXPLORE THE DATA
# ============================================================

print(table(training$classe))

missing_values <- colSums(is.na(training))
cat("Columns with missing values:", sum(missing_values > 0), "\n")


# 6. CLEAN THE TRAINING DATA
# ============================================================

# Remove columns that contain any missing values
training_clean <- training[, colSums(is.na(training)) == 0]

# Remove the first seven ID / timestamp columns
training_clean <- training_clean[, -(1:7)]

# Target must be a factor
training_clean$classe <- as.factor(training_clean$classe)

predictor_names <- setdiff(names(training_clean), "classe")


# 7. CLEAN THE TESTING DATA (same predictors)
# ============================================================

testing_clean <- testing[, predictor_names, drop = FALSE]

cat("Cleaned training dimensions:", dim(training_clean), "\n")
cat("Cleaned testing dimensions: ", dim(testing_clean), "\n")


# 8. REMOVE NEAR ZERO VARIANCE PREDICTORS
# ============================================================

nzv <- nearZeroVar(training_clean[, predictor_names, drop = FALSE])

if (length(nzv) > 0) {
  columns_to_remove <- predictor_names[nzv]
  training_clean <- training_clean[, !names(training_clean) %in% columns_to_remove,
                                   drop = FALSE]
  testing_clean  <- testing_clean[, !names(testing_clean) %in% columns_to_remove,
                                  drop = FALSE]
}

cat("Data cleaning completed!\n")


# 9. SPLIT TRAINING DATA (75% train / 25% validation)
# ============================================================

set.seed(123)

train_index <- createDataPartition(training_clean$classe,
                                   p = 0.75, list = FALSE)

train_data      <- training_clean[train_index, ]
validation_data <- training_clean[-train_index, ]

cat("Training split dimensions:  ", dim(train_data), "\n")
cat("Validation split dimensions:", dim(validation_data), "\n")


# 10. TRAIN RANDOM FOREST MODEL
# ============================================================
# Using randomForest() directly is much faster than caret::train().
# The out-of-bag (OOB) error gives a built-in cross-validation-like
# estimate of out-of-sample error.

set.seed(123)

cat("Training model... (about 1 minute)\n")

model <- randomForest(
  classe ~ .,
  data = train_data,
  ntree = 100,
  importance = TRUE
)

print(model)


# 11. EVALUATE MODEL ON VALIDATION SET
# ============================================================

predictions <- predict(model, newdata = validation_data)

results <- confusionMatrix(predictions, validation_data$classe)
print(results)


# 12. ACCURACY AND ERROR RATE
# ============================================================

accuracy   <- mean(predictions == validation_data$classe)
error_rate <- 1 - accuracy

cat("Model accuracy:", accuracy, "\n")
cat("Estimated out-of-sample error:", error_rate, "\n")
cat("OOB error estimate:",
    round(model$err.rate[model$ntree, "OOB"] * 100, 2), "%\n")


# 13. VARIABLE IMPORTANCE (optional)
# ============================================================

varImpPlot(model, n.var = 15, main = "Top 15 Important Variables")


# 14. PREDICT THE 20 TEST CASES
# ============================================================

final_predictions <- predict(model, newdata = testing_clean)

print(final_predictions)
cat("Number of predictions:", length(final_predictions), "\n")


# 15. SAVE OUTPUTS
# ============================================================

write.csv(data.frame(problem_id = seq_along(final_predictions),
                     classe = final_predictions),
          "final_predictions.csv", row.names = FALSE)

saveRDS(model, "random_forest_model.rds")

write.csv(data.frame(Accuracy = accuracy, Error_Rate = error_rate),
          "model_results.csv", row.names = FALSE)

# Optional: one text file per prediction (course submission format)
for (i in seq_along(final_predictions)) {
  writeLines(as.character(final_predictions[i]),
             paste0("problem_id_", i, ".txt"))
}


# 16. FINAL PROJECT SUMMARY
# ============================================================

cat("\n====================================\n")
cat("PROJECT COMPLETED SUCCESSFULLY!\n")
cat("====================================\n")
cat("Training observations:", nrow(training_clean), "\n")
cat("Testing observations: ", nrow(testing_clean), "\n")
cat("Model accuracy:       ", round(accuracy * 100, 2), "%\n")
cat("Estimated error:      ", round(error_rate * 100, 2), "%\n")
cat("Predictions generated:", length(final_predictions), "\n")

