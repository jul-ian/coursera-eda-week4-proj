options(scipen=999)

nei = readRDS('~/Github/coursera-eda-week4-proj/data/summarySCC_PM25.rds')
scc = readRDS('~/Github/coursera-eda-week4-proj/data/Source_Classification_Code.rds')
df = subset(merge(nei, scc, by='SCC'), 
            grepl('\\bcoal\\b', EI.Sector, ignore.case=TRUE))

totals = tapply(df$Emissions, as.factor(df$year), sum)
png('~/Github/coursera-eda-week4-proj/plot4.png')
barplot(totals, 
        xlab='Year', col='steelblue',
        ylab='Emissions (Tons)',
        main='Total PM2.5 Emissions Per Year\nCoal Related Sources')
dev.off()
