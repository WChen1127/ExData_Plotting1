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
myData$Global_active_power <- as.numeric(as.character(myData$Global_active_power))
head(myData$Global_active_power)


#################################################################
#### plot2: Global Active Power ~ datetime
#################################################################

library(datasets)

plot(x = myData$datetime, y = myData$Global_active_power, 
     type = "l", xaxt = "n", ylab = "Global Active Power (kilowatts)",
     xlab = "")
mn <- range(myData$datetime)[1]
mx <- range(myData$datetime)[2]
axis(side = 1, at = c(mn, mx/2, mx), labels = c("Thu", "Fri", "Sat"))

dev.copy(png, file = "plot2.png") 
dev.off() 


## default PNG file with a width of 480 pixels and a height of 
## 480 pixels
?png
