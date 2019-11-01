
## data directory
if(!file.exists("./data")){dir.create("./data")}
datadir <- "./data/household_power_consumption.txt"

# set local timezone to english, otherwise weekdays will not be printed in English
Sys.setlocale("LC_TIME","English")

# Load data  ----------------------------------------------------------

## Download data
if(!file.exists(datadir)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  destf <- "./data/household_power_consumption.zip"
  download.file(fileUrl,destfile = destf)
  unzip(destf,exdir="./data")
}

# REad data
hpc <- read.table(datadir,sep=';',header=TRUE,na.strings = c("NA","?"))

# Select correct date range
subhpc <- subset(hpc,hpc$Date=="1/2/2007" | hpc$Date =="2/2/2007")

# create datetime
subhpc$datetime <- strptime(paste(subhpc$Date, subhpc$Time, sep=" "), "%d/%m/%Y %H:%M:%S")


# Plot and save data  ----------------------------------------------------------
png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2))
#1
plot(subhpc$datetime, subhpc$Global_active_power, type="l", xlab="", ylab="Global Active Power")
#2
plot(subhpc$datetime, subhpc$Voltage, type="l", xlab="datetime", ylab="Voltage")
#3
plot(subhpc$datetime,subhpc$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(subhpc, lines(datetime,Sub_metering_1, col="black"))
with(subhpc, lines(datetime,Sub_metering_2, col="red"))
with(subhpc, lines(datetime,Sub_metering_3, col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
#4
plot(subhpc$datetime, subhpc$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")


dev.off()

# restore default
par(mfrow = c(1, 1))
