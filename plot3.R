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
## Sub_metering_1, Sub_metering_2, Sub_metering_3
myData[, 7:9] <- lapply(myData[, 7:9], as.character)
myData[, 7:9] <- lapply(myData[, 7:9], as.numeric)
tail(myData[, 7:9])


#################################################################
#### plot3: energy sub-metering ~ datetime
#################################################################

library(datasets)

plot(x = myData$datetime, y = myData[, 7],
     type = "l", xaxt = "n", ylab = "Energy sub-metering",
     xlab = "")
lines(myData[, 8], col = "red")
lines(myData[, 9], col = "blue")
mxy <- max(myData[, 7:9])    
mn <- range(myData$datetime)[1]
mx <- range(myData$datetime)[2]
legend(x = mx - 955 ,y=mxy+1.5, col = c("black", "red", "blue"), lty = 1, cex = 0.75, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
axis(side = 1, at = c(mn, mx/2, mx), labels = c("Thu", "Fri", "Sat"))

dev.copy(png, file = "plot3.png") 
dev.off() 


## default PNG file with a width of 480 pixels and a height of 
## 480 pixels
?png
