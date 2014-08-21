---
output:
  html_document:
    keep_md: yes
---
###Description of run_analysis.R script


The goal of the project is to prepare tidy data that can be used for later analysis. 

Source of the original data: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip . 

A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


The following attribute Information is taken from the original website:

For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.



The attached R script (run_analysis.R) performs the following:

1. Merges the training and test sets to create one data set. 
X_train and X_test are initially combined into x, and then added appropriate column names from the features file. The result is a data frame with 561 columns and 10,299 rows.  

Y_train and Y_test are combined into Y, and each activity is assigned a proper label from Activity_labels file. 

Subject_test and Subject_train are combined into subject dataset. 


2. Next step extracts mean and std column names from features dataset, allowing us to select appropriate columns from X dataset into a new X_select dataset.

3. We finally combine x_select, y and subject datasets into one combine_mean dataset with 82 columns and 10,299 rows. 
    a. First column contains Subject_ID
    b. Second - Activity_ID 
    c. Third - Activity_label
    d. Various mean and std features following. 

4. Final step transforms combine_mean dataset into a combined_tbl table, and then the average of each variable for each activity and each subject is calculated. The result is saved as final_mean.txt, using comma (",") as separator.