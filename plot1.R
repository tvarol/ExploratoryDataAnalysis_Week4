## Reading the data
NEI <- readRDS("summarySCC_PM25.rds")

## Sum the amount of emission from all sources for each of the years 1999, 2002, 2005, and 2008
tot <- with(NEI,tapply(Emissions, year, sum, na.rm=TRUE))

## Create a data frame containing total sum of emission for each year (1999,2002,2005,2008)
sumVsYear <- data.frame(year=as.numeric(names(tot)), totalSum=tot)

## Plotting
png("plot1.png", width=650, height=480)
with(sumVsYear, plot(as.numeric(as.character(year)), as.numeric(as.character(totalSum)), xaxt='n', xlab='Year', 
                      ylab=expression(paste("Total", " PM"[2.5], " Emissions (tons)")), 
                      main= expression(paste("Total", " PM"[2.5], " Emissions in the US from 1999 to 2008")),
                      pch = 20, cex = 1.2, col = "blue"),)

## Label the axis for the given years
axis(side=1, at=c("1999", "2002", "2005", "2008"))

## Connect the data points from each year to see the trend
lines(x=as.numeric(as.character(sumVsYear$year)), y=as.numeric(as.character(sumVsYear$totalSum)), col='red')

## Save and quit
dev.off()



