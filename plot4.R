library(dplyr)

#The dates that we will graph for this exersize
begintime <- strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S")
endtime <- strptime("2007-02-03 00:00:00", "%Y-%m-%d %H:%M:%S")

# Read the datafile
hpc.df <- read.table("household_power_consumption.txt", header = TRUE, sep=";",
                colClasses = c("character", "character", "numeric", "numeric",
                               "numeric", "numeric", "numeric", "numeric", "numeric"),
                strip.white = TRUE, skipNul = TRUE, na.strings = c("?"))

#Combine the date and time fields and then put it in a POSIXct, POSIXt format
#add it to hpc.df
datetimec <- paste(hpc.df$Date, hpc.df$Time)
datetime <- strptime(datetimec, "%d/%m/%Y %H:%M:%S")
hpc.df <- cbind(hpc.df, datetime)

#Extract only the data that needs to be graphed
graphdata <- filter(hpc.df, datetime >= begintime & datetime < endtime)

#Time to graph
png("plot4.png")

#Set 4 panels up
par(mfcol = c(2,2))

#Plot 1
plot(graphdata$datetime, graphdata$Global_active_power, ylab = "Global Active Power",
     type = "l")

#Plot 2
plot(graphdata$datetime, graphdata$Sub_metering_1, ylab = "Energy sub metering",
     xlab = "", type = "l")
points(graphdata$datetime, graphdata$Sub_metering_2, type = "l", col = "red")
points(graphdata$datetime, graphdata$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, bty = "n")

#Plot 3
with(graphdata, plot(datetime, Voltage, type = "l"))

#Plot 4
with(graphdata, plot(datetime, Global_reactive_power, type = "l"))

dev.off()
