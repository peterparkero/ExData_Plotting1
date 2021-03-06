# Source functions
sapply(list.files("./src", full.names = TRUE), source)

# Define Variables
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
target.folder = "./data"

# Load data
df <- load_data(url, target.folder)  # Check ./src/load_data.R

# Plot
png(file = "plot3.png", width = 480, height = 480)
plot(x = df$Time,
     y = df$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(x = df$Time,
      y = df$Sub_metering_2,
      type = "l",
      col = "red")
lines(x = df$Time,
      y = df$Sub_metering_3,
      type = "l",
      col = "blue")
legend("topright",
       lty = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()