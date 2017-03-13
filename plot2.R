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
png("plot2.png")
plot(graphdata$datetime, graphdata$Global_active_power, ylab = "Global Active Power (kilowatts)",
     xlab = "", type = "l")
dev.off()
