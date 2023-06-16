library(ggplot2)

nei = subset(readRDS('~/Github/coursera-eda-week4-proj/data/summarySCC_PM25.rds'),
             fips == '24510')
scc = readRDS('~/Github/coursera-eda-week4-proj/data/Source_Classification_Code.rds')
df = merge(nei, scc, by='SCC')

totals = as.data.frame(tapply(df$Emissions, list(df$type, df$year), sum))
totals$type = row.names(totals)
total_df = reshape(totals, direction='long', idvar='type', 
        varying=c("1999", "2002", "2005", "2008"), 
        v.names='emissions', 
        timevar='year', times=c("1999", "2002", "2005", "2008"), 
        new.row.names=1:(length(unique(totals$type))*4))
png('~/Github/coursera-eda-week4-proj/plot3.png')
ggplot(total_df, aes(year)) + 
  geom_bar(aes(weight=emissions)) + 
  facet_grid(. ~ type) +
  labs(x="Year", y="Emissions (Tons)", 
       title="Emissions Per Year For Each Source Type")
dev.off()
  
  
