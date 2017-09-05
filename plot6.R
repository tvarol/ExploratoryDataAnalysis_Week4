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

## Select the data from Los Angeles
LAData <- subset(mergedDT, fips=='06037', select=c(Emissions,year))

## Add columns to both of the data set for the city names
baltimoreData$City.Names <- "Baltimore" 
LAData$City.Names <- "Los Angeles"

## Merge two datasets
mergedSelected <- bind_rows(baltimoreData,LAData)

## Sum the amount of emission for each of the years 1999, 2002, 2005, and 2008 for each city
tot <- summarise(group_by(mergedSelected,year,City.Names),sum(Emissions,na.rm = TRUE))

tot <- as.data.frame(tot)

## Naming the columns of tot
names(tot) <- c("year", "City.Names", "Emissions")

png("plot6.png", width=650, height=480)

#Plotting
p <- qplot(year,Emissions,data=tot,color=City.Names) + geom_line() 
p <- p + labs(title=expression(paste("Comparison of Motor Vehicle Related", " PM"[2.5], " Emissions in Baltimore and LA (1999-2008)")))
p <- p + labs(x = "Year", y = expression(paste("PM"[2.5], " Emissions (tons)")))

print(p)

## Save and quit
dev.off()

