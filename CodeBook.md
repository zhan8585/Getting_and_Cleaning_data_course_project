---
title: "CodeBook"
author: "Charles"
date: "4/27/2020"
output: pdf_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

#Variables and data
The variables were derived from the variables in original dataset. Among the original variables, all the variables indicating the means or standard deviation of the corresponding measurement were selected. 

averages_for_subjects_activities.txt: average of each variable for each activity and each subject.

#transformations to tidy up the data
list in the features_info.txt was added as variable names
Acitivities was labeled according to activity_labels.txt
All the test and train data were combined together
average_for_subjects_activities.txt was grouped by subject and activities