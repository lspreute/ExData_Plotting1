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

png(filename="plot2.png")

with(df, plot(datetime, Global_active_power, type="l", 
              xlab="", ylab = "Global Active Power (kilowatts)"))

dev.off()