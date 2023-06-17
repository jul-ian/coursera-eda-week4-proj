options(scipen=999)

nei = subset(readRDS('~/Github/coursera-eda-week4-proj/data/summarySCC_PM25.rds'),
             fips == '24510')
scc = readRDS('~/Github/coursera-eda-week4-proj/data/Source_Classification_Code.rds')
# The term "motor vehicle" is ambiguous, and aircraft and boats being included is debatable
# Boats and aircraft will be included for this exercise, which means "motor vehicle" pollution
# is any pollution source category starting with "Mobile"
df = subset(merge(nei, scc, by='SCC'), 
            grepl('^Mobile', EI.Sector))

totals = tapply(df$Emissions, as.factor(df$year), sum)
png('~/Github/coursera-eda-week4-proj/plot5.png')
barplot(totals, 
        xlab='Year', col='steelblue',
        ylab='Emissions (Tons)',
        main='Total PM2.5 Emissions Per Year\nMotor Vehicle Sources in Baltimore City, MD')
dev.off()
