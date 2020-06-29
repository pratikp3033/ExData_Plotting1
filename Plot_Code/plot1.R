library(dplyr)
library(lubridate)



#       Downloading data
filename <- "exdata_data_household_power_consumption.zip"

if (!file.exists(filename))
{
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, filename, method="curl")
}  

if (!file.exists("household_power_consumption")) 
{ 
    unzip(filename) 
}



#   getting data in required form
data<- read.table("household_power_consumption.txt",header = TRUE ,sep = ";")

date<- data$Date
data$Date<- dmy(data$Date)
data$Time<- hms(data$Time)

data_req<- data %>% filter(Date=="2007-02-01" | Date=="2007-02-02")



#    plotting and sending to a graphics device
png(filename = "plot1.png" ,width = 480, height = 480)
hist(as.numeric(data_req$Global_active_power), col = "red",main = "Global Active Power", xlab = "Global Active Power(kilowatts)")
dev.off()

#OR
hist(as.numeric(data_req$Global_active_power), col = "red",main = "Global Active Power", xlab = "Global Active Power(kilowatts)")
dev.copy(png, file="plot1")
dev.off()

