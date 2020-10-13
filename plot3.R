data_power <- read.table("household_power_consumption.txt",skip=1,sep=";")
head(data_power)
names(data_power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subdata_power <- subset(data_power,data_power$Date=="1/2/2007" | data_power$Date =="2/2/2007")

# Transform the Date and Time variables
subdata_power$Date <- as.Date(subdata_power$Date, format="%d/%m/%Y")
subdata_power$Time <- strptime(subdata_power$Time, format="%H:%M:%S")

nrow(subdata_power)   #  2880
nrow(subdata_power[subdata_power$Date< as.Date("2007-02-02"),])      # 1440

subdata_power[1:1440,"Time"] <- format(subdata_power[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subdata_power[1441:2880,"Time"] <- format(subdata_power[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


# Create Plot 3
png(file="plot3.png", width = 480, height = 480)

plot(subdata_power$Time,subdata_power$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering", main="Energy sub-metering")
with(subdata_power,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(subdata_power,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(subdata_power,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

