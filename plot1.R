setwd("C:/Users/ludvi/Desktop/Data Cleaning/Course 4/Projectw1")

library(lubridate)
library(dplyr)
library(magrittr)

# loading data: (could have been more efficient)
household <- read.table("household_power_consumption.txt", 
                        na.strings = "?",
                        sep = ";",
                        header = T,
                        colClasses = c("character", "character", rep("numeric",7)))
        
# Changing class of date and time. 
household[,1] <- dmy(household[,1])
household[,2] <- hms(household[,2])

# selecting columns and filtering dates. 
household <- household %>%
        select(Date, Global_active_power) %>%
        filter(between(Date, as_date("2007-02-01"), as_date("2007-02-02")))

# creating .png file: 
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12)
with(household, hist(Global_active_power, col = "red",
                     xlab = "Global Active Power (kilowatts",
                     main = "Global Active Power"
))
dev.off()
