#             R Script for Creating Tidy Data using Smartphone Study Data 
# 
#  Overall Goal:  
#
#     Read in smartphone data files and create one data frame.
#     Extract all but the columns that represent "mean" and "std"
#     Subgroup and calculate mean for the data columns. 
#
#     Refer to associated Readme.txt as well as the code book
#     in this github site for more details.
#
#     The following code contains tutorial style comments that
#     could be deleted for easier readability or maintenance.
#   
#  Author:  tmerk@sonic.net
#  Date:    2015/01/24


run_analysis <- function() 
    {

    setwd("/home/tmerk/Coursera/03_Tidy_data/UCI_HAR_Dataset")
    
    
    #----------------------------------------------------------------------------  
    #  Create dataframe #1:  training
    #  
    #     column 1    = Read  /train/subject_train.txt  7352 x 1
    #     column 2    = "train"
    #     column 3    = Read  /train/y_train.txt        7352 x 1
    #     column 4... = Read  /train/X_train.txt        7352 x 561

    subject_train <- read.table ("train/subject_train.txt")

    y_train      <- read.table ("train/y_train.txt", col.names = "Activity")
    
    X_train      <- read.table ("train/X_train.txt")
    

    #     Merge 3 columns and add a new 2nd column to indicate that this is the training data (vs. test data).

    df_train <- cbind (subject_train, Type="train",  y_train, X_train)


    #  Clear memory; don't need these, anymore
    
    rm (subject_train, y_train, X_train)

   
    #----------------------------------------------------------------------------  
    #  Create dataframe #2:  test
    #  
    #     column 1    = Read  /test/subject_test.txt      2947 x 1
    #     column 2    = "test"
    #     column 3    = Read  /test/y_test.txt            2947 x 1
    #     column 4... = Read  /test/X_test.txt            2947 x 561
    #  
    
    subject_test <- read.table ("test/subject_test.txt")
    
    y_test       <- read.table ("test/y_test.txt", col.names = "Activity")
    
    X_test       <- read.table ("test/X_test.txt")


    #  Merge 3 columns and add a new 2nd column to 
    #  indicate that this is the test data (vs. train data).

    df_test <- cbind (subject_test, Type="test", y_test, X_test)
    
    
    #  Clear memory; don't need these, anymore

    rm (subject_test, y_test, X_test)


    #----------------------------------------------------------------------------  
    #  Append the 2 data frame rows.  It becomes 10,299 rows by 564 columns
    #
    #  V1    Type   Activity   tBodyAcc-mean()-X   tBodyAcc-mean()-Y  tBodyAcc-mean()-Z  ...

    df_combined <- rbind (df_train, df_test)


    #  Clear memory; don't need these, anymore

    rm (df_train, df_test)

    
    #----------------------------------------------------------------------------  
    #  Give the 1st column a name:  "Subject"  
    #  This column represents the people who took part in this experiment. 
    
    colnames(df_combined)[1] <- 'Subject'

    
    #  Replace the integer values in the 'Subject' column with fictitious names.
    #  The data remains anonmyous, but is easier to interpret 
    #  (vs. looking at a list of numbers 1 - 30).

    df_combined$Subject [df_combined$Subject ==  1] <- "Atkins"
    df_combined$Subject [df_combined$Subject ==  2] <- "Beck"
    df_combined$Subject [df_combined$Subject ==  3] <- "Clapton"
    df_combined$Subject [df_combined$Subject ==  4] <- "Dale"
    df_combined$Subject [df_combined$Subject ==  5] <- "Eddy"
    df_combined$Subject [df_combined$Subject ==  6] <- "Frampton"
    df_combined$Subject [df_combined$Subject ==  7] <- "Garcia"
    df_combined$Subject [df_combined$Subject ==  8] <- "Gilmour"
    df_combined$Subject [df_combined$Subject ==  9] <- "Hendrix"
    df_combined$Subject [df_combined$Subject == 10] <- "Hooker"
    df_combined$Subject [df_combined$Subject == 11] <- "Johnson"
    df_combined$Subject [df_combined$Subject == 12] <- "King"
    df_combined$Subject [df_combined$Subject == 13] <- "Knopfler"
    df_combined$Subject [df_combined$Subject == 14] <- "Kottke"
    df_combined$Subject [df_combined$Subject == 15] <- "Lee"
    df_combined$Subject [df_combined$Subject == 16] <- "McLaughlin"
    df_combined$Subject [df_combined$Subject == 17] <- "Montgomery"
    df_combined$Subject [df_combined$Subject == 18] <- "Nugent"
    df_combined$Subject [df_combined$Subject == 19] <- "Page"
    df_combined$Subject [df_combined$Subject == 20] <- "Raitt"
    df_combined$Subject [df_combined$Subject == 21] <- "Richards"
    df_combined$Subject [df_combined$Subject == 22] <- "Santana"
    df_combined$Subject [df_combined$Subject == 23] <- "Satriani"
    df_combined$Subject [df_combined$Subject == 24] <- "Segovia"
    df_combined$Subject [df_combined$Subject == 25] <- "Townsend"
    df_combined$Subject [df_combined$Subject == 26] <- "Vaughn"
    df_combined$Subject [df_combined$Subject == 27] <- "Walker"
    df_combined$Subject [df_combined$Subject == 28] <- "Winter"
    df_combined$Subject [df_combined$Subject == 29] <- "Young"
    df_combined$Subject [df_combined$Subject == 30] <- "Zappa"



    #  Replace column values with text (sitting, walking, etc.)
    #
    #  These values are from file   activity_labels.txt
    # 
    #    1 WALKING
    #    2 WALKING_UPSTAIRS
    #    3 WALKING_DOWNSTAIRS
    #    4 SITTING
    #    5 STANDING
    #    6 LAYING
    
    df_combined$Activity [df_combined$Activity == 1] <- "WALKING"
    df_combined$Activity [df_combined$Activity == 2] <- "WALKING_UPSTAIRS"
    df_combined$Activity [df_combined$Activity == 3] <- "WALKING_DOWNSTAIRS"
    df_combined$Activity [df_combined$Activity == 4] <- "SITTING"
    df_combined$Activity [df_combined$Activity == 5] <- "STANDING"
    df_combined$Activity [df_combined$Activity == 6] <- "LAYING"
    
    
    #----------------------------------------------------------------------------  
    #  Create headers for the 561 data columns (but not the first 3 columns)
    #
    #  Read features.txt   561 x 1
    #
    #  You need the  stringsAsFactors=F  to prevent the 3rd, "Activity"
    #  column from being interpreted as a factor.  Otherwise, the 
    #  list somehow becomes numbers. 

    features <- read.table ("features.txt", stringsAsFactors=F)

    
    #  These 3 lines remove unwanted symbols from the  features.txt  list.
    #  Parantheses and commas may interfere with later functions.
    #
    #  E.g., before:   tBodyAcc-arCoeff()-X,1
    #        after:    tBodyAcc-arCoeff-X_1
    
    features[ , 2] <- gsub ( "\\(", "",  as.matrix (features [ , 2]) )
    features[ , 2] <- gsub ( "\\)", "",  as.matrix (features [ , 2]) )
    features[ , 2] <- gsub ( "\\,", "_", as.matrix (features [ , 2]) )
    
    
    #  Relabel columns 4 through 561+4 with the edited labels from features.txt
    
    features_row <- 1   #  Start with values from 1st row in features DF
    
    features_row_length <- nrow (features)   # This is the loop count
    
    column_num <- 4     #  The first column name to replace is #4
    
    
    for (column_num in  column_num : (column_num + features_row_length -1)  ) {
    
        colnames(df_combined)[column_num] <- features [features_row, 2]
        
        
        column_num <- column_num + 1      # Point to next column, moving right
        
        features_row <- features_row + 1  # Point to next row in features DF
    }
    

    #----------------------------------------------------------------------------  
    #  We have a 10,299 row by  564 column data frame, 
    #  but need to extract columns that
    #  do not have "mean" or "std" in their names.
    #  
    #  
    #  We should wind up with 10,299 rows and 69 columnns total
    #  ( columns 1, 2, 3 + ones with "mean" and "std")
    
    
    #  Get the column numbers of the ones we're interested in:
    #
    #    - The first three columns:  "Subject"   "Type"   "Activity"
    #    - All columns containing "-mean" or "Mean" in the label
    #    - All columns containing "-std"  in the label (and accept capital letters)
    
    columns_1_3  <- c(1:3)
    columns_mean <- grep('-mean', names(df_combined), ignore.case = TRUE)
    columns_std  <- grep('-std',  names(df_combined), ignore.case = TRUE)
    
    
    #  Create a new list of the column labels that we want; 
    #  sort them to keep them in the original order.
    
    columns_desired <- sort ( c(columns_1_3, columns_mean, columns_std) )


    #  This step creates a new data frame that does not contain columns 
    #  that are not of interest
    
    df_final <- df_combined [ , columns_desired]

    #  This line removes all the "meanFreq" columns -- we only want the ones
    #  with just the ones with "mean" 
    
    df_final <- df_final [ , -grep("meanFreq", colnames(df_final)) ]
    
    
    rm (df_combined)        #  Clear memory
    
    
    #  Save the data frame to a file.
 
    write.table (df_final, file="tidy_samsung.txt", row.names=TRUE)
    
    
    #----------------------------------------------------------------------------  
    #
    #  This is step 5 in the project assignment:
    # 
    #      Create a second, independent tidy data set with 
    #      the average of each variable for each activity and each subject.
    #
    #  I interpret this to mean:  
    #
    #      calculate the mean for each of the 6 activities AND each of the 30 subjects;
    #      i.e., group-wise.
    #
    #  The following command computes the mean for columns 4 through the last column 
    #  and groups the process per the 'Activity' and 'Subject' column values.
    #

    df_aggr <- (aggregate (x   = df_final[4:ncol(df_final)], 
                           by  = list (Activity = df_final$Activity, Subject = df_final$Subject), 
                           FUN = mean ) )

    
    df_aggr_sorted <- ( df_aggr[ order(df_aggr[, 1], df_aggr[, 2]),  ]  )   # Column numbers work, but col. names do not.
    
    rm (df_aggr)              #  Clear memory
    
    
    #  Save the data frame to a file.

    write.table (df_aggr_sorted, file="tidy_samsung_subset_means.txt", row.names=FALSE)
    
    cat ("\nReturn ")
    return ()          
}
