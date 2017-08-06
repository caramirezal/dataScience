
chrNumber <- 20
n <- as.character(chrNumber)
frequencies.m <- melt(frequencies.df[frequencies.df$CHR==n,])

## plot stacked bar graph
g <- ggplot(data = frequencies.m, aes(x = X,y = value,fill=variable))
g <- g + scale_color_manual(values=variable)
g <- g + geom_bar(stat="identity",width = 1)
g <- g + theme(axis.line=element_blank(),
               axis.text.x=element_blank(),
               axis.title.x=element_blank(),
               panel.background=element_blank(),
               panel.border=element_blank(),
               panel.grid.major=element_blank(),
               panel.grid.minor=element_blank(),
               plot.background=element_blank())
plot(g)