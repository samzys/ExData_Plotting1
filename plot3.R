# setwd("C:\\Users\\Sam\\SkyDrive\\Documents\\Coursera\\4. Explorer Analysis\\project")
## save current system's locale
locale <- Sys.getlocale(category = "LC_TIME")

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
png(filename = "plot3.png",width = 480, height = 480, units = "px")
plot(mysub$DateTime, mysub$Sub_metering_1, col="black", type = "l", xlab = "", ylab="Energy sub metering")
lines(mysub$DateTime,mysub$Sub_metering_2,col="red")
lines(mysub$DateTime,mysub$Sub_metering_3,col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)

dev.off()
