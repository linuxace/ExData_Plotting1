library(dplyr)

# Read household power consumption csv into a data frame
epc <- read.csv("household_power_consumption.txt", sep=";")

# Use dplyr to filter only the text dates of February 1st and 
# 2nd 2007.
epc <- filter(epc, Date=="1/2/2007"|Date=="2/2/2007")

# In order to simplify processing by date and time, combine the date
# and time fields.
epc$Date <- paste(epc$Date, epc$Time, sep=" ")

# Convert Date/Time string into a POSIXct Datetime.  The date is
# automatically converted into central time, but the timezone
# does not affect the output for the purposes of this 
# assignment.
epc$Date <- as.POSIXct(strptime(epc$Date, format="%d/%m/%Y %H:%M:%S"))

# We can get rid of the Time column here, since it is no longer necessary.
epc <- epc[,c(1,3:9)]

# Because of how we imported the data, the columns that are numeric are
# factors.  Convert all necessary columns to numeric for plotting.
epc$Sub_metering_1 <- as.numeric(as.character(epc$Sub_metering_1))
epc$Sub_metering_2 <- as.numeric(as.character(epc$Sub_metering_2))
epc$Sub_metering_3 <- as.numeric(as.character(epc$Sub_metering_3))

# Open png device for writting the plot.
png(file="plot3.png", bg="transparent", height=480, width=480)

# Plot the Sub Metering 1 by Date
plot(epc$Sub_metering_1~epc$Date,type="l",ylab="Energy sub metering",xlab="")

# Add line for Sub Metering 2 by Date with the line color red
lines(epc$Date,epc$Sub_metering_2, col="red")

# Add line for Sub Metering 3 by Date with the line color blue
lines(epc$Date,epc$Sub_metering_3, col="blue")

# Add legend for three lines with appropriate color
legend("topright", lty=1, col = c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close the png graphics device.
dev.off()