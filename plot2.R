##Download and unzip data
if(!file.exists('data.zip')){
  url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url,destfile='data.zip')
}
unzip('data.zip')

##Read data to R
data<-read.table("household_power_consumption.txt", header=TRUE, sep=";")

##We need to change Date and Time values to numeric, thus concetenating Date and Time
data$DateTime<-paste(data$Date, data$Time)

##Change DateTime to yyy-mm-dd hh:mm:ss
data$DateTime<-strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

#Define day limits according to assignment
start<-which(data$DateTime==strptime("2007-02-01", "%Y-%m-%d"))
end<-which(data$DateTime==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))
data2<-data[start:end,]
##setting system locale to USA to ensure correct time format
Sys.setlocale("LC_TIME", "USA")
##as variables used in analysis are factor variables we need to use as.character and as.numeric
png(filename= "plot2.png", width=480, height=480, units="px")
plot(data2$DateTime, as.numeric(as.character(data2$Global_active_power)),
     type='l',ylab="Global Active Power (Kilowatts)", xlab="", xaxt="n")
axis(1, at=c(as.numeric(min(data2$DateTime)), as.numeric(min(data2$DateTime))+86400
             , as.numeric(min(data2$DateTime))+2*86400), labels=c("Thu", "Fri", "Sat"))
dev.off()             
