# This R Script generates a line plot of submeterings one to three in a 2-day period 
# in February, 2007 according to "Individual household electric power consumption 
# Data Set" from UC Irvine Machine Learning Repository

# Verifying if the Dataset is in the working directory 
if(sum(grepl("household_power_consumption.txt",dir()))==0){
  message("Please set working directory to folder 
          containing household_power_consumption.txt")
}

# Read household_power_consumption.txt into data table
powerConsumption <- fread("household_power_consumption.txt",nrows = 2075259, 
                          na.strings = "?")
# Transform Date attribute from character to Date
powerConsumption <- mutate(powerConsumption, Date = as.Date(Date,format = "%d/%m/%Y"))

# Generate random date
randomDate <- sample(powerConsumption$Date[month(powerConsumption$Date)==2 & 
                                             year(powerConsumption$Date) == 2007],1)
# Create random 2-day span in February 2007
twoDayRandomConsumptionSpan <- c(randomDate, randomDate + 1)  

# Filter sample from dataset for pertinent 2-day span
february2DayConsumption <- filter(powerConsumption, Date == twoDayRandomConsumptionSpan)

# Get date and time of measurements
dateAndTime <- strptime(paste(february2DayConsumption$Date, february2DayConsumption$Time
                              , sep = " "), format= "%Y-%m-%d %H:%M:%S")
# Open png device
png("plot3.png", height=480, width=480)

# Line plot sub meterings one to three for 2-day period in February 2007
plot(dateAndTime, february2DayConsumption$Sub_metering_1, xlab="", 
     ylab="Energy sub metering", type="l")
points(dateAndTime, february2DayConsumption$Sub_metering_2, col="red", type="l")
points(dateAndTime, february2DayConsumption$Sub_metering_3, col="blue", type="l")

# Set legend box
legend("topright",cex=0.85,lwd=1,col =c("black","red","blue"),
       legend=as.character(colnames(february2DayConsumption)[7:9]))

# Close png device
dev.off()