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

#create png file device
png("Plot1.png", width=504, height=504)

#plotting to png file
hist(powerConsumptionData$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)",col="red") 

#close the png file device
dev.off()