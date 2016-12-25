## Exploratory Data Analysis - Assignment 2 - part4
## Guðfinna Kristinsdóttir - 25.des'16

## Across the United States, how have emissions from coal combustion-related sources 
## changed from 1999-2008?

## I'll use ggplot2 since I find it the most comfortable to work with

## Load the dataset
SummarySCC <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Get all coal combustion related from SCC
Coal <- SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

## Merge Coal dataset with SummarySSC
merge <- merge(x=SummarySCC, y=Coal, by='SCC')
mergeall <- aggregate(merge[, 'Emissions'], by=list(merge$year), sum)
colnames(mergeall) <- c('Year', 'Emissions')


# Generate the graph 
png(filename='plot4.png')

ggplot(data=mergeall, aes(x=Year, y=Emissions/1000)) + 
        geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=2, col=Emissions)) + 
        ggtitle(expression('Total Emissions of PM'[2.5])) + 
        ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 
        geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) + 
        theme(legend.position='none') + scale_colour_gradient(low='blue', high='yellow')

dev.off()
