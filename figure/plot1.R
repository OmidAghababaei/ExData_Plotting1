data_power <- read.table("household_power_consumption.txt",skip=1,sep=";")
head(data_power)
names(data_power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subdata_power <- subset(data_power,data_power$Date=="1/2/2007" | data_power$Date =="2/2/2007")

# Create Plot 1
png(file="plot1.png", width = 480, height = 480)
hist(as.numeric(as.character(subdata_power$Global_active_power)),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")
dev.off()


