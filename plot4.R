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
#### Pre-processing the data
#################################################################
head(data$Date)
myData <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

## Adding a variable to indicate the weekday
myData$datetime <- paste(myData$Date, myData$Time, sep = " ")
myData$datetime <- strptime(myData$datetime, format = "%d/%m/%Y %H:%M:%S")
myData$datetime_TF <- weekdays(myData$datetime)
table(myData$datetime_TF) # Fri and Thu

## converting factor variables to numeric ones 
myData$datetime <- as.numeric(as.factor(as.character(myData$datetime)))
head(myData$datetime)

names(myData)
## Global_active_power, Sub_metering_1, Sub_metering_2, Sub_metering_3
## Voltage, Global_reactive_power
myData[, c(3:5, 7:9)] <- lapply(myData[, c(3:5, 7:9)], as.character)
myData[, c(3:5, 7:9)] <- lapply(myData[, c(3:5, 7:9)], as.numeric)
tail(myData[, c(3:5, 7:9)])


#################################################################
#### plot4: four plots
#################################################################

library(datasets)

par(mfrow = c(2, 2))

## topleft: Global_active_power (plot2) vs. datetime
plot(x = myData$datetime, y = myData$Global_active_power, 
     type = "l", xaxt = "n", ylab = "Global Active Power",
     xlab = "", cex.lab = 0.8)
mn <- range(myData$datetime)[1]
mx <- range(myData$datetime)[2]
axis(side = 1, at = c(mn, mx/2, mx), labels = c("Thu", "Fri", "Sat"))

## topright: Voltage vs. datetime
plot(x = myData$datetime, y = myData$Voltage, 
     type = "l", xaxt = "n", ylab = "Voltage",
     xlab = "datetime", cex.lab = 0.8)
mn <- range(myData$datetime)[1]
mx <- range(myData$datetime)[2]
axis(side = 1, at = c(mn, mx/2, mx), labels = c("Thu", "Fri", "Sat"))

## bottomleft:energy sub-metering
plot(x = myData$datetime, y = myData[, 7],
     type = "l", xaxt = "n", ylab = "Energy sub-metering",
     xlab = "", cex.lab = 0.8)
lines(myData[, 8], col = "red")
lines(myData[, 9], col = "blue")
mxy <- max(myData[, 7:9])    
mn <- range(myData$datetime)[1]
mx <- range(myData$datetime)[2]
legend(x = mx - 1500 ,y=mxy+1.5, col = c("black", "red", "blue"), lty = 1, cex = 0.5, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
axis(side = 1, at = c(mn, mx/2, mx), labels = c("Thu", "Fri", "Sat"))

## bottomright: Global_reactive_power vs. datetime
plot(x = myData$datetime, y = myData$Global_reactive_power, 
     type = "l", xaxt = "n",
     ylab = "Global_reactive_power",xlab = "", cex.lab = 0.8)
mn <- range(myData$datetime)[1]
mx <- range(myData$datetime)[2]
axis(side = 1, at = c(mn, mx/2, mx), labels = c("Thu", "Fri", "Sat"))
dev.copy(png, file = "plot4.png") 
dev.off() 

par(mfrow = c(1, 1))

## default PNG file with a width of 480 pixels and a height of 
## 480 pixels
?png
