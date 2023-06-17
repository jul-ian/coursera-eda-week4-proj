options(scipen=999)

nei = subset(readRDS('~/Github/coursera-eda-week4-proj/data/summarySCC_PM25.rds'),
             fips %in% c('24510', '06037'))
scc = readRDS('~/Github/coursera-eda-week4-proj/data/Source_Classification_Code.rds')
# The term "motor vehicle" is ambiguous, and aircraft and boats being included is debatable
# Boats and aircraft will be included for this exercise, which means "motor vehicle" pollution
# is any pollution source category starting with "Mobile"
df = subset(merge(nei, scc, by='SCC'), 
            grepl('^Mobile', EI.Sector))

df_md = subset(df, fips == '24510')
df_ca = subset(df, fips == '06037')

totals_md = tapply(df_md$Emissions, as.factor(df_md$year), sum)
totals_ca = tapply(df_ca$Emissions, as.factor(df_ca$year), sum)
png('~/Github/coursera-eda-week4-proj/plot6.png')
par(mfrow=c(1, 2))
barplot(totals_md, 
        xlab='Year', col='steelblue',
        ylab='Emissions (Tons)',
        sub='Baltimore City, MD')
barplot(totals_ca, 
        xlab='Year', col='orange',
        ylab='Emissions (Tons)',
        sub='Los Angeles, CA')
mtext('Total PM2.5 Emissions Per Year\nMotor Vehicle Sources',
      side=3, line=-2, outer=TRUE)
dev.off()