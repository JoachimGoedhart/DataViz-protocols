require(tidyverse)

# In protocol 6 we have seen how many time traces can be visualized with a heatmap style data visualization.
# The advantage is that huge amounts of data can be simultaneously visualized. However, it is difficult to relate the color to numbers.
# As such the color coded values in a heatmap give a qualitative view of heterogeneity.
# In this protocol, we use a method that allows more data than an ordinary lineplot, but keeps the advantage of this plot, i.e. allowing a quantitative comparison.
# To do this, an offset between curves is introduced. A package to this directly in ggplot2 is available (`ggridges`) but it may not work well when the values show a negative and positive deviation from baseline values (usually the baseline is zero).
# In addition, we have more flexibility (and insight) when we do this ourselves.


# Read the data
df1 <- read.csv("Rac_S1P.csv")

#Make tidy

df_tidy <- pivot_longer(df1, cols = -c(Time), names_to = "Cell", values_to = "Activity")

# Calculate for every cell the max value, for a defined time window, and determine the rank based on this value
df_rank <- df_tidy %>% group_by(Cell) %>% filter(Time>=2 & Time <=10) %>% summarise(amplitude=sum(Activity)) %>% mutate(rank=percent_rank(amplitude))

#Add rank to the df_tidy dataframe
df_tidy <- as.data.frame(full_join(df_tidy, df_rank,by="Cell"))

#Define the plot
p <- ggplot(df_tidy, aes(x=Time+(rank*10), y=(Activity+(rank*1)), group=Cell)) 

#Ucomment for no shift x-axis
#p <- ggplot(df_tidy, aes(x=Time, y=Ratio+(rank*1), group=Cell, height = rank)) 

#Add  the data as lines
p <- p + geom_line(alpha=0.5, size=0.5)

# p <- p +  annotate("segment", x = 0, xend = 20, y = 1, yend = 3, size=.5, color="grey50") +
#   annotate("segment", x = 0, xend = 20, y = 1, yend = 1, size=.5, color="grey50") +
#   annotate("segment", x = 20, xend = 40, y = 1, yend = 3, size=.5, color="grey50")
  


#Add labels:

p <-
  p + labs(
    title = "Activities measured in single cells over time",
    subtitle = "Sorting of the cells is based on integrated activity",
    x = "Time [min]",
    y = "Activity [arbitrary units]",
    caption = "(based on data from Reinhard: xxxx)",
    tag = "Protocol 7"
  )

#Uncomment to add color
#p <- p+ geom_line(aes(color=as.factor(rank)))

#Format layout
p <- p + theme_classic(base_size = 16)
p <- p + theme(panel.grid.major = element_blank(),
               plot.caption = element_text(color = "grey80"),
           panel.grid.minor = element_blank(),
           axis.line.x = element_blank(),
           axis.title.x = element_text(hjust = 0.3),
           NULL)

p <- p + annotate(geom = "segment", x=0,y=1,xend=10,yend=2, size=1)
p <- p + annotate(geom = "segment", x=0,y=1,xend=20,yend=1, size=1)

p + scale_x_continuous(breaks = c(0,20), expand = c(0, 0))

