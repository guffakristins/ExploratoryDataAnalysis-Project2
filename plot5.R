## Exploratory Data Analysis - Assignment 2 - part5
## Guðfinna Kristinsdóttir - 25.des'16

## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

## I'll use ggplot2 since I find it the most comfortable to work with

## Load the dataset
SummarySCC <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Factor the years
SummarySCC$year <- factor(SummarySCC$year, levels=c('1999', '2002', '2005', '2008'))

# On road Maryland
OnroadM <- subset(SummarySCC, fips == 24510 & type == 'ON-ROAD')

# Aggregate
Marylanddataframe <- aggregate(OnroadM[, 'Emissions'], by=list(OnroadM$year), sum)
colnames(Marylanddataframe) <- c('year', 'Emissions')

# Generate the graph
png('plot5.png')

ggplot(Marylanddataframe, aes(factor(year), Emissions)) + geom_bar(stat="identity") +
        xlab("year") + ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland')

dev.off()

