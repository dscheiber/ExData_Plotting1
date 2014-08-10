##loads text file, subsets the good dates, creates a DateTime from Date and Time columns, and converts DateTime to POSIXlt 
allData <- fread("household_power_consumption.txt", colClasses=c("character","character","character","character","character","character","character","character","character"))
goodData <- allData[allData$Date == "2/2/2007" | allData$Date == "1/2/2007"]
goodData$DateTime <- paste(goodData$Date, goodData$Time, sep=";")
finalDateTime <- data.frame("DateTime2"=strptime(goodData$DateTime, format="%d/%m/%Y;%H:%M:%S"))
goodData <- cbind(goodData, finalDateTime)

