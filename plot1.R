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

# Open png device for writting the plot.
png(file="plot1.png", bg="transparent", height=480, width=480)

# Create histogram of frequency of Global Active Power.
hist(epc$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

# Close png graphics device.
dev.off()
