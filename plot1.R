## Goal is to generate this image: https://d396qusza40orc.cloudfront.net/exdata/CP1/ExDataCP1Plot1.png
## as a 480x480 PGN named plot1.png
## from this electric power consumption data set: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## using the data from dates 2007-02-01 and 2007-02-02


plot1 <- function()
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
  
  png("plot1.png", width=480, height=480)
  
  hist(feb1and2data$Global_active_power,
       main="Global Active Power",
       xlab="Global Active Power (kilowatts)",
       ylab="Frequency",
       col="red")
  
  dev.off()
  
}