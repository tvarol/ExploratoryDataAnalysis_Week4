library(dplyr)

## Reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Select SCC for coal-related sources
coalData <- subset(SCC, grepl('Coal', EI.Sector), select='SCC')

## Match the selected SCC from SCC dataset to the ones in NEI
mergedDT <- merge(NEI, coalData, by = 'SCC')

tot <- with(mergedDT,tapply(Emissions, year, sum, na.rm=TRUE))

## Plotting
png("plot4.png", width=650, height=480)
plot(names(tot), as.numeric(as.character(tot)), xaxt='n', xlab='Year', 
                     ylab=expression(paste("Total", " PM"[2.5], " Emissions (tons)")), 
                     main= expression(paste("Total Coal Related", " PM"[2.5], " Emissions in the US (1999-2008)")),
                     pch = 20, cex = 1.2, col = "blue")

## Label the axis for the given years
axis(side=1, at=c("1999", "2002", "2005", "2008"))

## Connect the data points from each year to see the trend
lines(x=names(tot), y=as.numeric(as.character(tot)), col='red')

## Save and quit
dev.off()
