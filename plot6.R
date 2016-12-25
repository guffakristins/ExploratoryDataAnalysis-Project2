## Exploratory Data Analysis - Assignment 2 - part6
## Guðfinna Kristinsdóttir - 25.des'16

## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
## in Los Angeles County, California (fips == 06037). Which city has seen greater changes over time 
## in motor vehicle emissions? 

## I'll use ggplot2 since I find it the most comfortable to work with

## Load the dataset
SummarySCC <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Factor the years
SummarySCC$year <- factor(SummarySCC$year, levels=c('1999', '2002', '2005', '2008'))

## Subset onroad for Baltimore City, Maryland and Los Angeles County, California
OnroadMD <- subset(SummarySCC, fips == '24510' & type == 'ON-ROAD')
OnroadLA <- subset(SummarySCC, fips == '06037' & type == 'ON-ROAD')

## Aggregate
#Maryland
DataframeMD <- aggregate(OnroadMD[, 'Emissions'], by=list(OnroadMD$year), sum)
colnames(DataframeMD) <- c('year', 'Emissions')
DataframeMD$City <- paste(rep('MD', 4))

#LA
DataframeLA <- aggregate(OnroadLA[, 'Emissions'], by=list(OnroadLA$year), sum)
colnames(DataframeLA) <- c('year', 'Emissions')
DataframeLA$City <- paste(rep('CA', 4))

## Combine
DataFrame <- as.data.frame(rbind(DataframeMD, DataframeLA))

# Generate the graph 
png('plot6.png', width=1040, height=480)

ggplot(data=DataFrame, aes(x=year, y=Emissions)) + geom_bar(stat="identity") +
        ggtitle("Total Emissions of Motor Vehicle Sources Los Angeles County vs Baltimore City") + 
        ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + facet_grid(. ~ City) + 
        geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))

dev.off()
