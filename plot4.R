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
        mutate(Date = dmy(Date)) %>%
        filter(between(Date, as_date("2007-02-01"), as_date("2007-02-02")))  %>%
        mutate(datetime = paste(as.character(Date), Time, sep = " ")) %>%
        mutate(datetime = as.POSIXct(datetime, tz = Sys.timezone()))


# plotting:     
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(household, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
with(household, plot(datetime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))
with(household, plot(datetime, 
                     Sub_metering_1, 
                     type="l",
                     xlab = "",
                     ylab="Energy sub metering"))

lines(household$datetime, household$Sub_metering_2,type="l", col= "red")
lines(household$datetime, household$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty= 1, lwd=2, col = c("black", "red", "blue"))
with(household, plot(datetime, Global_reactive_power, type = "l"))
dev.off()


