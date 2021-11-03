This file describes the variables, the data, and any transformations performed to clean up the data.

* The data X_train and X_test are extracted
* They are added together on top of each other
* Variable headers are obtained from the file features
* Only variables are selected that contain the text mean or std
* Variable names are cleaned by removing instances of ()
* Subjects are extracted from subject_train and subject_test. These are added to the data called Subject
* Activities are extracted from y_train and t_test and converted to descriptions using file activity_labels. This are added to the data called Activity
* The data is grouped by subject and activity
* The mean of each variable is calculated by subject and activity. This is written as output.txt.