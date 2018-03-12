# Downloads and unzip data 
if (!file.exists("HouseholdPowerConsumption.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "HouseholdPowerConsumption.zip")
}  

if (!file.exists("UCI HAR Dataset")) { 
  unzip("HouseholdPowerConsumption.zip")
}

#load the data
powerConsumptionData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

#convert date variable to Date class
powerConsumptionData$Date <- as.Date(powerConsumptionData$Date, format = "%d/%m/%Y")

# subset the data to only interested interval
powerConsumptionData <- with(powerConsumptionData, subset(powerConsumptionData, Date >= "2007-02-01" & Date <= "2007-02-02"))

powerConsumptionData$DateTime <- as.POSIXct(strptime(paste(powerConsumptionData$Date, powerConsumptionData$Time), "%Y-%m-%d %H:%M:%S"))

    
#create png file device
png("Plot4.png", width=504, height=504)

par(mfrow = c(2, 2))

#plotting to png file
with(powerConsumptionData, plot(Global_active_power~DateTime, type = "l", ylab = "Global Active Power", xlab = ""))
with(powerConsumptionData, plot(Voltage~DateTime, type = "l"))
with(powerConsumptionData, plot(Sub_metering_1~DateTime, type = "l", ylab = "Energy sub metering", xlab = ""))
with(powerConsumptionData, lines(Sub_metering_2~DateTime, col = "Red"))
with(powerConsumptionData, lines(Sub_metering_3~DateTime, col = "Blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
with(powerConsumptionData, plot(Global_reactive_power~DateTime, type = "l"))

#close the png file device
dev.off()