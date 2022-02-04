
rm(list=(ls()))
library(tidyverse)

Irect <- read.csv("./ICES_StatRec_mapto_ICES_Areas 2021.csv")


Irect <- select(Irect, ICESNAME, Area_27, AreasList) %>%
  filter(!Area_27 %in% "" & !AreasList %in% "")

# Split the data between the records that have a list in areas and those that haven't 
# to check
Alist  <- filter(Irect, str_detect(AreasList, ","))
NoAlist <- filter(Irect, !str_detect(AreasList, ","))

(nrow(Alist) + nrow(NoAlist)) %in% nrow(Irect)

# Split the list 
new <- strsplit(Alist$AreasList, ",")

# Create new df 
IrectList <- data.frame(ICESNAME = rep(Alist$ICESNAME, sapply(new, length)), 
                        Area_27 = rep(Alist$Area_27, sapply(new, length)),
                        AreasList = unlist(new))

# # Add subarea
# IrectList <- mutate(IrectList, Subarea = sub("\\..*", "", Area_27))
# NoAlist  <- mutate(NoAlist , Subarea = sub("\\..*", "", Area_27))

# Fix the space after the comma in the new df 
IrectList <- mutate(IrectList,  AreasList = gsub(" ", "", AreasList))


# Bind the two dfs 
Irectbind <- rbind(NoAlist, IrectList)

Irectnew <- select(Irectbind, ICESNAME, AreasList) %>%
  distinct()

Irectnew   <- mutate(Irectnew , Subarea = sub("\\..*", "", AreasList))


subarea <- select(Irectnew, ICESNAME, Subarea) %>%
  rename(AreasList = Subarea)

Irectnew <- select(Irectnew, ICESNAME,AreasList)

Irectnew1 <- rbind(Irectnew, subarea)

unique(Irectnew$AreasList)


# Account for most combinations of areas/rectangles (subarea, division, subdivision - NEAFC)

# Get out divisions (ignore area 3 subdivisions)
newdf <- mutate(Irectnew1, Check = str_detect(AreasList, ".*\\..*\\..*"))


newdf1 <- mutate(newdf, Division = ifelse(Check %in% TRUE & !str_detect(AreasList, "3."), sub("^([^.]*.[^.]*).*", "\\1", AreasList), AreasList))


# Create final list 

# & !str_detect(AreasList, "3.")

ICESrectfin <- newdf1 %>% select(ICESNAME, AreasList, Division) %>% gather(source, Area_27, -ICESNAME) %>%
  select(Area_27, ICESNAME) %>%
  distinct()
# Correct area 3.a (Add it)

ll <- filter(ICESrectfin, str_detect(Area_27, "3.a")) %>%
  mutate(Area_27 = "3.a",
         Area = paste("27.",Area_27,sep=""))

ICESrectfin$Area <- paste("27.",ICESrectfin$Area_27,sep="")

ICESrectfin2 <- rbind(ICESrectfin, ll)

# Write final df 

write.csv(ICESrectfin2,"./ICESRectAreas.csv", row.names = FALSE)


