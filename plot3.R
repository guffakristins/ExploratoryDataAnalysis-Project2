## Exploratory Data Analysis - Assignment 2 - part3
## Guðfinna Kristinsdóttir - 25.des'16

## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
## Which have seen increases in emissions from 1999-2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

## Load ggplot2 library
library(ggplot2)

## Load the dataset
SummarySCC <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset to Maryland
plot3 <- subset(SummarySCC, fips == 24510)
plot3$year <- factor(plot3$year, levels=c('1999', '2002', '2005', '2008'))

## Plot the graph
png(filename='plot3.png', width=800, height=500, units='px')

ggplot(data=plot3, aes(x=year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill=F) +
        geom_boxplot(aes(fill=type)) + stat_boxplot(geom ='errorbar') +
        ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + 
        ggtitle('Emissions per Type in Baltimore City, Maryland') +
        geom_jitter(alpha=0.10)

dev.off()
