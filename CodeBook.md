# Project Overview
30 persons performed a different range of activities wearing a Samsung phone and the result of this processing we should create a tidy data set. 

# Data
y_test.txt : The activity idfor each observation from the X_test.txt.

y_train.txt : The activity idfor each observation from the X_train.txt.

subject_test.txt : The subject id for each observation from the test X_test.

subject_train.txt : The subject id for each observation from the test X_train.

X_test.txt : Testing observations from the different features.

X_train.txt : Train observations from the different features.

features.txt :  The list of names of the different features.

activity_labels.txt : A name description of the activities

# Script
1. All the data was read into data tables and merged in a single data set:
  LabelData: y_test.txt + y_train.txt 
  SubjectData : subject_test.txt  + subject_train.txt 
  Set: X_test.txt + X_train.txt 

2. The feature data set was the name of the columns for the observations (X_test.txt + X_train.txt)
  Dataset : LabelData + SubjectData + Set
3. The data was selected based on the columns, if it has a mean() or std()

4. Renamed the column with more readable names.

5. created a new Tidy Dataset with new aggregate data.
