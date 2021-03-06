# Exploratory Data Analysis
# Author: Martin Martinez
# 

#The purpose of this R-Script is to reproduce the the Plot 4 graph

#Step 1:  Load the Libraries if necessary
library(data.table)
library(dplyr)
library(png)

#Step 2.  Load the data files

# set the working dir 
#myWorkingDir <- "/Volumes/User Data 3TB/Users/mmartine/Documents/Education/Coursera/Data Science Certificate/04. Exploratory Data Analysis"
myWorkingDir <- "/home/mmartine/Documents/Education/Corusera/Exploratory-Data-Analysis/Proj1"
setwd(myWorkingDir)

#create the Data directory if needed

if (!file.exists("./data")){
  dir.create("./data")
}

#At this point we would normally pull the raw file from a different location eg URL location
# but since the data was provided we'll, I've unzipped the file in the data direction within the working directory
# So all that is needed to be done is load the data

myData <- tbl_df(read.table("./data/household_power_consumption.txt",header=TRUE, sep=";", dec=".", stringsAsFactors=FALSE))
myDataSubset <- myData %>% filter(Date==c("1/2/2007","2/2/2007"))

dateTime <- strptime(paste(myDataSubset$Date, myDataSubset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
gap <- as.numeric(myDataSubset$Global_active_power)
grp <- as.numeric(myDataSubset$Global_reactive_power)
volt <- as.numeric(myDataSubset$Voltage)

metering1Sub <- as.numeric(myDataSubset$Sub_metering_1)
metering2Sub <- as.numeric(myDataSubset$Sub_metering_2)
metering3Sub <- as.numeric(myDataSubset$Sub_metering_3)

#create png file
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

#do gap plot
plot(dateTime,gap, type="l", ylab="Global Active Power", xlab="")

#do next plot
plot(dateTime, volt, type="l", ylab="Voltage", xlab="Date/Time")

plot(dateTime, metering1Sub, type="l", ylab="Energy  submetering", xlab="")
lines(dateTime,metering2Sub, type="l", col="red")
lines(dateTime,metering3Sub, type="l", col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, lwd=2, col=c("black","red","blue"))

plot(dateTime, grp, type="l", ylab="Global Reactive Power", xlab="Date/Time")
dev.off()