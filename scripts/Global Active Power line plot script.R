# This R Script generates a line plot of Global Active Power in a 2-day period 
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
png("global_active_power_line_plot.png", height=900, width=1600)

# Line plot Global Active Power for 2-day period in February 2007
plot(dateAndTime, february2DayConsumption$Global_active_power, xlab="", 
     ylab="Global Active Power (kilowatts)", type="l")

# Close png device
dev.off()