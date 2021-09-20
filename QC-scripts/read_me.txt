Folder for scripts to quality check the RDBES data files.

Run the R-markdown (RDBESNationalOverviews.rmd) script in the subfolder "NationalOverviews" on national RDBES CE and CL data.
It will output a report in html format. 
In line 61 and 62 of the script, it reads a test dataset. These lines can be replaced with a reference to national RDBES CE and CL data sets.
Several years can be read using code like below:

# Read CL + CE tables (the upload files without headers)
CL2018 <- read.csv("Q:/CL_2018_HCL.csv", header = FALSE)
CL2019 <- read.csv("Q:/CL_2019_HCL.csv", header = FALSE)
CL2020 <- read.csv("Q:/CL_2020_HCL.csv", header = FALSE)
CE2018 <- read.csv("Q:/CE_2018_HCE.csv", header = FALSE)
CE2019 <- read.csv("Q:/CE_2019_HCE.csv", header = FALSE)
CE2020 <- read.csv("Q:/CE_2020_HCE.csv", header = FALSE)

CL <- rbind(CL2018,CL2019,CL2020)
CE <- rbind(CE2018,CE2019,CE2020) 

The script is a service provided to help checking the national data before upload to ICES.
The script can be improved and updated based on user feedback.