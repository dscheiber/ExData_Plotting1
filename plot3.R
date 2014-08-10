library(data.table)
##loads text file, subsets the good dates, creates a DateTime from Date and Time columns, and converts DateTime to POSIXlt 
allData <- fread("household_power_consumption.txt", colClasses=c("character","character","character","character","character","character","character","character","character"))
goodData <- allData[allData$Date == "2/2/2007" | allData$Date == "1/2/2007"]
goodData$DateTime <- paste(goodData$Date, goodData$Time, sep=";")
finalDateTime <- data.frame("DateTime2"=strptime(goodData$DateTime, format="%d/%m/%Y;%H:%M:%S"))
goodData <- cbind(goodData, finalDateTime)
goodData$Global_active_power <- as.numeric(goodData$Global_active_power)
goodData$Global_reactive_power <- as.numeric(goodData$Global_reactive_power)
goodData$Voltage <- as.numeric(goodData$Voltage)
goodData$Global_intensity <- as.numeric(goodData$Global_intensity)
goodData$Sub_metering_1 <- as.numeric(goodData$Sub_metering_1)
goodData$Sub_metering_2 <- as.numeric(goodData$Sub_metering_2)
goodData$Sub_metering_3 <- as.numeric(goodData$Sub_metering_3)


##png open
png("plot3.png", width=480, height=480, units="px", pointsize=12)
##plot 3
with(goodData, plot(DateTime2, Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
with(goodData, points(DateTime2, Sub_metering_2, col="red", type="l"))
with(goodData, points(DateTime2, Sub_metering_3, col="blue", type="l"))
legend("topright", pch = "-", col = c("black","blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()