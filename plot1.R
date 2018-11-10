## Exploraatory Data Analysis 
## Peer-graded Assignment: Course Project 1
## plot1.R

## This script generates plot1.png for the assignment
## It is assumed the data set is in the working directory 

library(data.table)
library(lubridate)
library(dplyr)

## Read data from working directory
pwr <- fread("household_power_consumption.txt")

## Filter data by required timeframe
pwr$Date <- dmy(pwr$Date)
pwr_subset <- select(pwr, Date, Global_active_power)
pwr_filter <- filter(pwr_subset, Date >= "2007-02-01" & Date <= "2007-02-02")

## Extract data for plotting
datapoints <- as.numeric(pwr_filter$Global_active_power)

## plot as 480 x 480 pixel png
png("plot1.png", width=480, height=480)

hist(datapoints, col="red", xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", main="Global Active Power", cex.axis=0.75)

dev.off()