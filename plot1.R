#################################################################
#### Setting the working directory 
#################################################################
getwd()
setwd("./Desktop/SUMMER/exploratorydata/figures")


#################################################################
#### Reading the data: txt data
#################################################################
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, sep = ";")
head(data)


#################################################################
#### Pre-processing the data: dates 2007-02-01 and 2007-02-02.
#################################################################
head(data$Date)
myData <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

## converting factor variable to numeric one 
myData$Global_active_power <- as.numeric(as.character(myData$Global_active_power))
head(myData$Global_active_power)

#################################################################
#### plot1: Global Active Power (hist)
#################################################################

library(datasets)

hist(myData$Global_active_power, 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "red",
     ylim = c(0, 1200))

dev.copy(png, file = "plot1.png") 
dev.off() 

## default PNG file with a width of 480 pixels and a height of 
## 480 pixels
?png

