## "Exploratory Data Analysis" project 1 / Plot 2

# Set working directory

setwd("C://Vibhas//Coursera Certifications//4 - Exploratory Data Analysis//Homework//Project 1")

# Assuming that the downloader packages are installed,
# if not "install.packages("downloader")

# Loading/Attaching

require(downloader)

# Load data.table library

library(data.table)

# Downlodad File

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "household_power_consumption.zip"
download(url, file, mode = "wb")

# Extract the "household_power_consumption.txt" file!

unzip(file, exdir = "C://Vibhas//Coursera Certifications//4 - Exploratory Data Analysis//Homework//Project 1")

# Read data

data <- fread("household_power_consumption.txt")

# Clean data

class(data$Date)
class(data$Time)

# Data and time variables are characters
# Change the format of Date variable

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
class(data$Date)

# Subset the data for the two dates of interest

data_subset <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02"]

# Convert data subset to a data frame

class(data_subset)
data_subset <- data.frame(data_subset)

# Convert columns to numeric

for(i in c(3:9)) {data_subset[,i] <- as.numeric(as.character(data_subset[,i]))}

# Create Date_Time variable

data_subset$Date_Time <- paste(data_subset$Date, data_subset$Time)

# Convert Date_Time variable to proper format

data_subset$Date_Time <- strptime(data_subset$Date_Time, format="%Y-%m-%d %H:%M:%S")
class(data_subset$Date_Time)

# Plot 2 Line 480 X 480

png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(6, 6, 5, 4))

# type = "n" builds plots without points
# xaxt = NULL suppresses x axis
# xlab = "" removes the label from the x axis
# otherwise, the axis is the name of the x variable, which is date_time

plot(data_subset$Date_Time, data_subset$Global_active_power, xaxt=NULL, xlab = "", ylab = "Global Active Power (kilowatts)", type="n")

lines(data_subset$Date_Time, data_subset$Global_active_power, type="S")

# Turn off device

dev.off()