# setwd("C:\\Users\\Sam\\SkyDrive\\Documents\\Coursera\\4. Explorer Analysis\\project")
## save current system's locale
## set English locale in order to have labels printed in English
Sys.setlocale("LC_TIME", "English")

myrawdata<-read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", 
                      colClasses = c("character", "character", rep("numeric",1,7)))
mydata<-myrawdata
mydata$Date<-as.Date(mydata$Date, "%d/%m/%Y")

mysub<-myrawdata[mydata$Date >= as.Date("2007-02-01") & mydata$Date<=as.Date("2007-02-02"),]

mysub$DateTime <-paste(mysub$Date, mysub$Time)
mysub$DateTime <-strptime(mysub$DateTime, "%d/%m/%Y %H:%M:%S")
str(mysub)

##plot start
png(filename = "plot4.png",width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
#produce the first graph
with(mysub, plot(DateTime, Global_active_power,type = "l",xlab = "",ylab="Global Active Power"))
#produce the second graph
with(mysub, plot(DateTime, Voltage, type = "l",xlab = "datetime",ylab="Voltage"))
#produce the thrid graph
with(mysub, plot(DateTime, Sub_metering_1, col="black", type = "l", xlab = "", ylab="Energy sub metering"))
with(mysub, lines(DateTime,Sub_metering_2,col="red"))
with(mysub, lines(DateTime,Sub_metering_3,col="blue"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, cex=0.7)
with(mysub, plot(DateTime, Global_reactive_power, type = "l",xlab = "datetime",ylab="Global_reactive_power"))
dev.off()
