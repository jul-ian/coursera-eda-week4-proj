options(scipen=999)

nei = subset(readRDS('~/Github/coursera-eda-week4-proj/data/summarySCC_PM25.rds'),
             fips == '24510')
scc = readRDS('~/Github/coursera-eda-week4-proj/data/Source_Classification_Code.rds')
df = merge(nei, scc, by='SCC')

totals = tapply(df$Emissions, as.factor(df$year), sum)
png('~/Github/coursera-eda-week4-proj/plot2.png')
barplot(totals, 
        xlab='Year', col='steelblue',
        ylab='Emissions (Tons)',
        main='Total PM2.5 Emissions Per Year\nBaltimore City, MD')
dev.off()
