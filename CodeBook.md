## Codebook
***

This codebook describes the operational procedure of the R script as described by the course project instruction. 

### Section 0: Dataset Preparation and Extraction.
***
The data that was utilized for this project was obtained from UC Irvine Machine Learning Repository. In particular, *Human Activity Recognition Using Smartphones Data Set* was utilized which can be accessed [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 
For this part of the script, the data set was simply downloaded in the working directory.

### Section 1: Merging the training and test sets to create one data set.
***
The first section has three main functions namely:

1. Read the data files which contain training data, test data, feature vector, and activity labels.
2. Accordingly, these data files were assigned to variable names which is necessary for the data to be merged.
3. Finally, the training and test data sets were merged to create a single data set `combinedDataset`.

### Section 2: Subset extraction of mean and standard deviation for each measurement.
***
`DataSubset` was created to subset extract the mean and standard deviation of each measurement from `combinedDataset`. 

### Section 3: Set descriptive activity names to name the activities in the data set.
***
The activity `code` column of the `DataSubset` was reassigned to a new variable which corresponds to the activity obtained from the `activities` variable.

### Section 4: Descriptive variable name assignment to activities.
***
The variable name assignment and their corresponding meanings were clearly listed in the R script.

### Section 5: Tidy data containing the Mean of each variable for each activity and each subject.
***
`TidyData` summarizes data table that contains the mean of each variable for each activity and each subject. 
In addition, the exported version can be seen in `TinyData.txt`
 