library(ggplot2)
library(dplyr)

## Reading the data
NEI <- readRDS("summarySCC_PM25.rds")

## Select the data from the Baltimore City
baltimoreData <- subset(NEI, fips=='24510', select=c(Emissions,year,type))

## Sum the amount of emission for each type for each of the years 1999, 2002, 2005, and 2008
tot <- summarise(group_by(baltimoreData,year,type),sum(Emissions,na.rm = TRUE))

tot <- as.data.frame(tot)

names(tot) = c("year", "type", "Emissions")

png("plot3.png", width=650, height=480)

#Plotting
p <- qplot(year,Emissions,data=tot,color=type) + geom_line() 
p <- p + labs(title=expression(paste("Total", " PM"[2.5], " Emissions in Baltimore by Emission Type from 1999 to 2008")))
p <- p + labs(x = "Year", y = expression(paste("Total", " PM"[2.5], " Emissions in Baltimore (tons)")))

print(p)

## Save and quit
dev.off()


