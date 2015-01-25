
# README for Coursera "Getting and Cleaning Data" Class Project

## Instructions on how to set up up the data environment and run the program

* Download data from   
   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

* Unzip the data; it creates a set of subdirectories

* Download run_analysis.R from this repo.

* Copy run_analysis.R script into the folder **above** UCI_HAR_Dataset directory

* Edit the path in the run_analysis.R file to match your path

* Open the RStudio application

* Load the run_analysis.R file

* Execute the script:   run_analysis()


* Input:   

  Files from UCI_HAR_Dataset download  

* Output is 2 files:  

   tidy_samsung.txt  - 10,299 rows by  69 columns 

   tidy_samsung_subset_means.txt   - 180 rows by 68 columns  

Note:  This script uses basic R functions, so there's no need to install any packages (e.g., dplyr).  

See  codebook.txt  for more details on input and output file structures.   




## Overview of what run_analysis.R does

See comments in  run_analysis.R  for more detail.  


* Goal:   

   Read in **UCI_HAR_Dataset** files and create one data frame.  
   Then, extract all but the columns that represent "mean" and "std" 
   to create a tidy data set.  
   Finally, use the tidy data set to calculate the mean of a subgroup of rows.  

###Algorithm  

* Create dataframe #1  

   Read  /training/subject_train.txt  (7352 x 1)   
   Read  /training/y_train.txt        (7352 x 1)   
   Read  /training/X_train.txt        (7352 x 561)   

   Merge 3 data frames   
   
   Add column to represent "train" data
   
   Result is a data frame with 7352 rows and 564 columns


* Create dataframe #2   

   Read  /test/subject_test.txt       (2947 x 1)    
   Read  /test/y_test.txt             (2947 x 1)   
   Read  /test/X_test.txt             (2947 x 561)   

   Merge 3 columns   

   Add column to represent "test" data
   
   Result is a data frame with 2947 rows and 564 columns


* Append dataframe #2 to dataframe #1   


* Create header row:

   column 1 = "Subject"   

   Replace subject values 1 - 30 with the names of 30 guitarists    

   column 2 = "Activity"   

   Replace column numbers with text (sitting, walking, etc.)    
      
   column 3 = "Type"
   
   Represents source of row:  "train" vs. "test"   

   Read features.txt   (561 x 1)   

   Extract parantheses and commas from the variable names.   
   
   Use the modified variable names as the column headers  for columns 4 through 564.   

   Result is a 10,299 row by 564 column data frame   

* Remove extraneous columns

   Extract columns that do  not have "mean" or "std" in their names  

   Result is a 10,299 row by 69 column data frame

   That is, columns 1, 2, 3, plus those with "-mean" and with "-std" function names in header.    


*  Create a second, independent tidy data set with the average of each variable for each activity and each subject.

   Subset per "Activity" and "Subject" columns and calculate means 
   
   Result is a 180 row by 68 column data frame (the "Type" column is removed)
   
   