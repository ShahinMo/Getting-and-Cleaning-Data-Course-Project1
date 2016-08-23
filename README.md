
# Getting-and-Cleaning-Data-Course-Project
This is the course project for the Getting and Cleaning Data Coursera course. 

Here is an explanation about what the R script called run_analysis.R does:

1. Ckeck for the data in the work directory and downloads the dataset if it does not exist in the directory.
2. Load the training and the test datasets.
3. Load the activity and subject data for each dataset, and merges those columns with eavh dataset.
4. Load the activity and feature info.
5. lable the colums based on the feature labels
6. keep only those columns which reflect a mean or standard deviation. The colomns that contain "Mean" and "meanFreq" are not included as they do not represent the mean values calculated from the signals.
5. Merge the train and test datasets.
6. Convert the activity and subject columns into factors and change the numeric variable names to descriptive names.
8. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair. The tidy data is in a wide format and is shown in the file MyTidyData.txt.
