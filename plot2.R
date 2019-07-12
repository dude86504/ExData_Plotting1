setwd("C:/Users/ludvi/Desktop/Data Cleaning/Course 4/Projectw1")

library(lubridate)
library(dplyr)
library(magrittr)

# loading data: (could have been more efficient)
household.data <- read.table("household_power_consumption.txt", 
                        na.strings = "?",
                        sep = ";",
                        header = T,
                        colClasses = c("character", "character", rep("numeric",7)))

# selecting columns and filtering dates. 
household <- household.data %>%
        select(Date, Time, Global_active_power) %>%
        mutate(Date = dmy(Date)) %>%
        filter(between(Date, as_date("2007-02-01"), as_date("2007-02-02")))  %>%
        mutate(datetime = paste(as.character(Date), Time, sep = " ")) %>%
        mutate(datetime = as.POSIXct(datetime, tz = Sys.timezone()))

# Creating plot:
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12)
with(household, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()
