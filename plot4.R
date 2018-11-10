## Exploraatory Data Analysis 
## Peer-graded Assignment: Course Project 1
## plot4.R

## This script generates plot4.png for the assignment
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
## top left data
x_axis <- pwr_filter$DateTime
y_gap <- pwr_filter$Global_active_power
## top right data
y_volt <- pwr_filter$Voltage
## bottom left data
y_meter1 <- pwr_filter$Sub_metering_1
y_meter2 <- pwr_filter$Sub_metering_2
y_meter3 <- pwr_filter$Sub_metering_3
## bottom right data
y_grp <- pwr_filter$Global_reactive_power

## plot as 480 x 480 pixel png
png("plot4.png", width = 480, height = 480)

#prep plot area
##par(mar=c(4,4,2,2))
par(mfrow=c(2,2))

## top left plot
plot(x_axis,y_gap,type="n", xlab="", ylab="Global Active Power")
lines(x_axis,y_gap)

## top right plot
plot(x_axis, y_volt, type="n", xlab="datetime", ylab="Voltage" )
lines(x_axis, y_volt)

## bottome left plot
plot(x_axis, y_meter1, type="n", xlab="", ylab="Energy sub metering")
lines(x_axis,y_meter1, col="black")
lines(x_axis,y_meter2, col="red")
lines(x_axis,y_meter3, col="blue")
legend("topright", legend=c("sub_metering_1", "sub_metering_2", "sub_metering_3"), 
       col=c("black", "red", "blue"), lty=1, bty="n")

## bottom right plot
plot(x_axis, y_grp, type="n", xlab="datetime", ylab="Global_reactive_power" )
lines(x_axis, y_grp)

dev.off()