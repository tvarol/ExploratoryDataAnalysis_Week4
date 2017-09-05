library(dplyr)

## Reading the data
NEI <- readRDS("summarySCC_PM25.rds")

## Select the data from the Baltimore City
baltimoreData <- subset(NEI, fips=='24510', select=c(Emissions,year))

## Sum the amount of emission from all sources for each of the years 1999, 2002, 2005, and 2008
tot <- with(baltimoreData, tapply(Emissions, year, sum, na.rm=TRUE))

## Plotting
png("plot2.png", width=650, height=480)

plot(names(tot), as.numeric(as.character(tot)), xaxt='n', xlab='Year', 
                     ylab=expression(paste("Total", " PM"[2.5], " Emissions in Baltimore (tons)")), 
                     main= expression(paste("Total", " PM"[2.5], " Emissions in Baltimore from 1999 to 2008")),
                     pch = 20, cex = 1.2, col = "blue")


## Label the axis for the given years
axis(side=1, at=c("1999", "2002", "2005", "2008"))

## Connect the data points from each year to see the trend
lines(x=names(tot), y=as.numeric(as.character(tot)), col='red')

## Save and quit
dev.off()


