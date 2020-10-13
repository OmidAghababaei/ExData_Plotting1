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

# Create the matrix of plot 4
par(mfrow=c(2,2))

png(file="plot4.png", width = 480, height = 480)
layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE))
with(subdata_power,{
  plot(subdata_power$Time,as.numeric(as.character(subdata_power$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(subdata_power$Time,as.numeric(as.character(subdata_power$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(subdata_power$Time,subdata_power$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(subdata_power,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(subdata_power,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(subdata_power,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(subdata_power$Time,as.numeric(as.character(subdata_power$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})
dev.off()
