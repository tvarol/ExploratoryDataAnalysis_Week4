library(dplyr)

## Reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Select SCC for vehicle-related sources
motorData <- subset(SCC, grepl('Vehicles', EI.Sector), select='SCC')

## Match the selected SCC with the ones in NEI
mergedDT <- merge(NEI, motorData, by = 'SCC')

## Select the data from the Baltimore City
baltimoreData <- subset(mergedDT, fips=='24510', select=c(Emissions,year))

## Sum the amount of emission for each of the years 1999, 2002, 2005, and 2008
tot <- with(baltimoreData,tapply(Emissions, year, sum, na.rm=TRUE))

## Plotting
png("plot5.png", width=650, height=480)
plot(names(tot), as.numeric(as.character(tot)), xaxt='n', xlab='Year', 
     ylab=expression(paste("PM"[2.5], " Emissions (tons)")), 
     main= expression(paste("Motor-Vehicle Related", " PM"[2.5], " Emissions in Baltimore (1999-2008)")),
     pch = 20, cex = 1.2, col = "blue")

## Label the axis for the given years
axis(side=1, at=c("1999", "2002", "2005", "2008"))

## Connect the data points from each year to see the trend
lines(x=names(tot), y=as.numeric(as.character(tot)), col='red')

## Save and quit
dev.off()

