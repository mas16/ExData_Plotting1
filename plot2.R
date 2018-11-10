## Exploraatory Data Analysis 
## Peer-graded Assignment: Course Project 1
## plot2.R

## This script generates plot3.png for the assignment
## It is assumed the data set is in the working directory 

library(data.table)
library(lubridate)
library(dplyr)

## Read data from working directory
pwr <- fread("household_power_consumption.txt")

## Create DateTime variable as POSIXct for plotting
pwr_mutated <- mutate(pwr, DateTime = paste(Date, Time))
pwr_mutated$DateTime <- strptime(pwr_mutated$DateTime, "%d/%m/%Y %H:%M:%S")
pwr_mutated$DateTime <- as.POSIXct(pwr_mutated$DateTime) 

## Filter data by required timeframe
pwr_mutated$Date <- dmy(pwr_mutated$Date)
pwr_filter <- filter(pwr_mutated, Date >= "2007-02-01" & Date <= "2007-02-02")

## Extract data for plotting
x_axis <- pwr_filter$DateTime
y_axis <- pwr_filter$Global_active_power

## plot as 480 x 480 pixel png
png("plot2.png", width=480, height=480)

plot(x_axis,y_axis,type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(x_axis,y_axis)

dev.off()