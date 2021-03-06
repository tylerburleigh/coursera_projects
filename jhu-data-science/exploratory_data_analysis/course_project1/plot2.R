##############################################################################
# Load libraries
####################

library("tidyverse")
library("data.table")


##############################################################################
# Loading the data
####################

# Get file size, convert to kB
file.size("household_power_consumption.txt")/1000

# Check available system memory (in kB), command only works on Windows
if(.Platform$OS.type == "windows") 
  system('wmic OS get FreePhysicalMemory /Value')

# Looks like I have more than enough memory to load
df <- fread("household_power_consumption.txt", na.strings="NA")

# Filter dates I'm using
# convert date and time to as.POSIXct object
df %>%
  filter(Date == '1/2/2007' | Date == '2/2/2007') %>%
  mutate(Datetime = as.POSIXct(strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")),
         Global_active_power = as.numeric(Global_active_power)) -> df


##############################################################################
# Plot 2
####################

# Set graphics device as png with 480x480 size
png('plot2.png', width = 480, height = 480, units = "px")

# Plot
with(df, plot(Datetime, Global_active_power, type = "l", 
              ylab = "Global Active Power (kilowatts)", xlab = ""))

# Turn off graphics device
dev.off()

