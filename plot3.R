## Goal is to generate this image: https://d396qusza40orc.cloudfront.net/exdata/CP1/ExDataCP1Plot3.png
## as a 480x480 PGN named plot3.png
## from this electric power consumption data set: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## using the data from dates 2007-02-01 and 2007-02-02

plot3 <- function()
{
  ##----------
  ##Download and unzip files, if necessary
  ##----------
  
  #Checks if data has been downloaded, 
  #else download and unzip into working directory
  if(!file.exists("household_power_consumption.txt"))
  {
    download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile = "PowerData.zip")
    unzip("PowerData.zip")
  }
  
  
  #Load data
  powerdata <- read.table("household_power_consumption.txt",
                          check.names=FALSE,
                          sep=";",
                          na.string="?",
                          nrows=1000000,
                          header=TRUE)
  
  powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")
  feb1and2data <- powerdata[(powerdata$Date=="2007-02-01") | (powerdata$Date=="2007-02-02"),]
  feb1and2data$Date <- as.factor(weekdays(feb1and2data$Date))
  
  png("plot3.png", width=480, height=480)
  
  plot(feb1and2data$Sub_metering_1,type="l",xaxt="n",xlab="",ylab="Energy sub metering")
  lines(feb1and2data$Sub_metering_2,type="l",col="red")
  lines(feb1and2data$Sub_metering_3,type="l",col="blue")
  
  axis(side=1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))
  legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)  
  dev.off()
  
}