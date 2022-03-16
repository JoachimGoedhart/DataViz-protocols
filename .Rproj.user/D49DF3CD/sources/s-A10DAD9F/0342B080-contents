library(tidyverse)
library(data.table)

# Read the data. Since the file is a couple of Megabytes, we use the faster `fread()` function from the package `data.table`:
df_S1P <- data.table::fread("ERK_repsonse_to_S1P.csv") 

# The first 5 timepoints of each timeseries reflect the baseline activity. Here, we subtract the average baseline value from each trace. The ``Unique_Object` column is used to identify and distinguish the different measurements. Each number in the `Unique_Object` column reflects an indivudal cell measuerement
df_sub <- df_S1P %>% group_by(Unique_Object) %>% arrange(Time_in_min) %>% mutate(ERKn=CN_ERK-mean(CN_ERK[1:5])) %>% ungroup()

#Around Timepoint 23, the ligand was added. To set this time point to zero, we subtract 23 from each point:
df_sub$Time_in_min <- df_sub$Time_in_min-23

#The column that identifies the individual cells contains natural numbers, but these need to be treated as qualitative data. Therefore, we change the data type in this column to a factor with `as.factor()`:
df_sub <- df_sub %>% mutate(Unique_Object=as.factor(Unique_Object))


# To order objects, we need to order 'Unique_Object' according to something. That something can be the maximum value of the Erk activity:
df_sub <- df_sub %>% mutate(Unique_Object = fct_reorder(Unique_Object, ERKn, max))


#Plot the data in heatmap style. We use theme_void here to focus only on the data and we will deal with styling of the axes and labels later:
ggplot(df_sub, aes(x=Time_in_min, y=Unique_Object,fill=ERKn)) +
  geom_tile() + theme_void()+
  scale_fill_viridis_c() 

# Can we also sort the data based on something else? Definitely, but it requires a bit of understanding of functions. Previously, we used the maximum value. This is defined by the function `max`, whihc takes the maxium value from a vector of numbers. Let's look at an artificial example:
x <- c(1,3,4,5,6,7,9)
max(x)

# Other functions that take a vector as input and return a single value as output can be used. Other existing examples are `mean()`, `sum()` and `min()`. We can also define a function:
second <- function(x) {x[2]}
second(x)

one_but_last <- function(x) {x[length(x)-1]}
one_but_last(x)

#We can use the new function to sort the dataframe: 
df_sub <- df_sub %>% mutate(Unique_Object = fct_reorder(Unique_Object, ERKn, one_but_last)) 

ggplot(df_sub, aes(x=Time_in_min, y=Unique_Object,fill=ERKn)) +
  geom_tile() + theme_void()+
  scale_fill_viridis_c() 

#If we want to sort on the sum of the top five values we can define a function:
top_five <- function(x) {sum(tail(sort(x),5))}

#But we can also directly implement the function in the `fct_reorder()` function:
df_sub <- df_sub %>% mutate(Unique_Object = fct_reorder(Unique_Object, ERKn, function(x) {sum(tail(sort(x),5))})) 

p <-  ggplot(df_sub, aes(x=Time_in_min, y=Unique_Object,fill=ERKn)) + geom_tile() +
  # scale_x_continuous(breaks=seq(0,60, by=15), labels=seq(0,60, by=15), limits=c(-8,60))  +
  scale_fill_viridis_c(na.value="black", limits = range(-0.1,1.5))
#Let's look at the plot
p

#Add labels:

p <-
  p + labs(
    title = "ERK activity is increased by S1P",
    subtitle = "and varies strongly between cells",
    x = "Time after addition of S1P (min)",
    y = "Cells sorted according to response",
    caption = "(based on data from Chavez-Abiega: xxxx)",
    tag = "Protocol 6",
    fill= "ERK C/N ratio"
  )


  
  
p <- 
  #Set text size
  p + theme_light(base_size = 14) +
  
  theme(plot.caption = element_text(color = "grey80", hjust = 1.3),
        plot.title = element_text(hjust = 0.1, margin = margin(t=10)),
        plot.subtitle = element_text(hjust = 0.1, margin = margin(t=2, b=5)),
        # Remove background
        panel.background = element_blank(),
        # Remove borders
        panel.border = element_blank(),
        # Remove grid
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        # Remove text of the y-axis
        axis.text.y = element_blank(),
        # Remove ticks on y-axis
        axis.ticks.y = element_blank(),
        # Remove label of y-axis
        axis.title.y = element_blank(),
        # Make x-axis ticks more pronounced
        axis.ticks = element_line(colour = "black")
  )

p




#Save the data as PNG
# png(file=paste0("Figure_2.png"), width = 1600, height = 600, units = "px")
#   p3
# dev.off()
