# Script for producing plot1.png

# This allows to have the dates in english
Sys.setlocale("LC_TIME", "C")

# Reading the data

filename <- "household_power_consumption.txt"
header <- read.table(filename, nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
df <- read.table(filename, sep=";",na.strings="?", header=FALSE, skip=66637, nrows=2880)
colnames(df) <- unlist(header)

# Converting and combining date and time in a new variable datetime

df$Date <- as.Date(df$Date, format="%d/%m/%Y")
df$datetime <- strptime(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S")

# producing the plot

png(filename="plot4.png")
par(mfcol = c(2,2))

# subplot 1
with(df, plot(datetime, Global_active_power, type="l", 
              xlab="", ylab = "Global Active Power"))

# subplot 2
with(df, plot(datetime, Sub_metering_1, type="l", 
              xlab="", ylab = "Energy sub metering"))
with(df, lines(datetime, Sub_metering_2, col = "red"))
with(df, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", col = c("black", "red", "blue"), lty = 1,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        bty="n")

# subplot 3
with(df, plot(datetime, Voltage, type="l"))

# subplot 4
with(df, plot(datetime, Global_reactive_power, type="l"))

dev.off()
