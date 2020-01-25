# Determine if the data frames exist.  If they do, remove them
if (exists('power') && is.data.frame(get('power'))) {
    rm(power)
}

if (exists('newPower') && is.data.frame(get('newPower'))) {
    rm(newPower)
}

# Determine if we have downloaded the file
if (!file.exists('./Dataset.zip')) {
    #if the file does not exist, create it
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./Dataset.zip")
}

# Unzip and Load the Data
unzip('./Dataset.zip',exdir = '.')
power <- read.csv("./household_power_consumption.txt",sep=";",na.strings="?")

# Grab only a subset of data. We will only be using data from the dates 2007-02-01 and 2007-02-02.
newPower <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")

# Transform the date and time fields
newPower$Date <- as.Date(newPower$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(newPower$Date), newPower$Time)
newPower$Datetime <- as.POSIXct(datetime)

# print the desired plot
png("./plot3.png", width=480, height=480)
with(newPower, {
    plot(Sub_metering_1~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
})

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,  legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()