
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
png("plot2.png", width=480, height=480)
plot(subhpc$datetime, subhpc$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

