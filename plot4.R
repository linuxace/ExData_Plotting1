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
epc$Global_active_power <- as.numeric(as.character(epc$Global_active_power))
epc$Global_reactive_power <- as.numeric(as.character(epc$Global_reactive_power))
epc$Voltage<-as.numeric(as.character(epc$Voltage))
epc$Sub_metering_1 <- as.numeric(as.character(epc$Sub_metering_1))
epc$Sub_metering_2 <- as.numeric(as.character(epc$Sub_metering_2))
epc$Sub_metering_3 <- as.numeric(as.character(epc$Sub_metering_3))

# Open png device for writting the plot.
png(file="plot4.png", bg="transparent", height=480, width=480)

# Create an array to write/display at 2x2 grid of plots
par(mfrow = c(2,2))

# Create a line plot of Global Active Power over time
plot(epc$Global_active_power~epc$Date, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# Create a line Plot of Voltage over time
plot(epc$Voltage~epc$Date,type="l",xlab="datetime",ylab="Voltage")

# Create a line Plot for Submetering 1,2 and 3 over time
plot(epc$Sub_metering_1~epc$Date,type="l",ylab="Energy sub metering",xlab="")
lines(epc$Date,epc$Sub_metering_2, col="red")
lines(epc$Date,epc$Sub_metering_3, col="blue")

# Add legend to previously created plot for the three lines
legend("topright", lty=1, col = c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot Global Reactive Power over time
plot(epc$Global_reactive_power~epc$Date,type="l",xlab="datetime",ylab="Global_reactive_power")

# Close the png graphics device.
dev.off()