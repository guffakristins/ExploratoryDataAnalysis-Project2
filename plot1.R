## Exploratory Data Analysis - Assignment 2 - part1
## Guðfinna Kristinsdóttir - 25.des'16

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
## for each of the years 1999, 2002, 2005, and 2008.

## Load the dataset
SummarySCC <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Make the needed dataset to plot
Emissions <- aggregate(SummarySCC[, 'Emissions'], by=list(SummarySCC$year), FUN=sum)
EmissionsPM <- round(Emissions[,2]/1000,2)

## Plot
png(filename='plot1.png')

barplot(EmissionsPM, names.arg=Emissions$Group.1, 
        main=expression('Total Emission of PM'[2.5]),
        xlab='Year', ylab=expression(paste('PM', ''[2.5], ' in Kilotons')))

dev.off()
