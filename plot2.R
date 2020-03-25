# Source functions
sapply(list.files("./src", full.names = TRUE), source)

# Define Variables
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
target.folder = "./data"

# Load data
df <- load_data(url, target.folder)

# Plot
png(file = "plot2.png", width = 480, height = 480)
plot(x = df$Time,
     y = df$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()
