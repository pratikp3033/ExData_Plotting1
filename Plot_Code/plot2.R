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

data$Date<- dmy(data$Date)

data_req<- data %>% filter(Date=="2007-02-01" | Date=="2007-02-02")

data_req$Time <- strptime(data_req$Time, format="%H:%M:%S")
data_req[1:1440,"Time"] <- format(data_req[1:1440,"Time"],"2007-02-01 %H:%M:%S")
data_req[1441:2880,"Time"] <- format(data_req[1441:2880,"Time"],"2007-02-02 %H:%M:%S")



#    plotting and sending to a graphics device
png(filename = "plot2.png" ,width = 480, height = 480)
with(data_req, plot(Time, as.numeric(Global_active_power), type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()

#OR
with(data_req, plot(Time, as.numeric(Global_active_power), type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file="plot2")
dev.off()

