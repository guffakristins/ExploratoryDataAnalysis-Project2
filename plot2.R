## Exploratory Data Analysis - Assignment 2 - part2
## Guðfinna Kristinsdóttir - 25.des'16

## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.

## Load the dataset
SummarySCC <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset data
plot2 <- subset(SummarySCC, fips=='24510')

## Plot the graph
png(filename='plot2.png')

barplot(tapply(X=plot2$Emissions, INDEX=plot2$year, FUN=sum), 
        main='Total Emission in Baltimore City', 
        xlab='Year', ylab=expression('PM'[2.5]))

dev.off()
