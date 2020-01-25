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
unzip('./Dataset.zip')
power <- read.csv("./household_power_consumption.txt",sep=";",na.strings="?")

# Grab only a subset of data. We will only be using data from the dates 2007-02-01 and 2007-02-02.
newPower <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")

# print the desired plot
png("./plot1.png", width=480, height=480)
hist(as.numeric(as.character(newPower$Global_active_power)),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")
dev.off()