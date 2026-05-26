library(tidyverse)

# df_sheet <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vSc-nI1-s_u-XkNXEn_u2l6wkBafxJMHQ_Cd3kStrnToh7kawqjQU3y2l_1riLigKRkIqlNOqPrgkdW/pub?output=csv", na.strings = "")

df_sheet <-  read.csv("data/20220421_Resultaat-metingen.csv", na.strings = "")

head(df_sheet)

df_sheet <- df_sheet %>% na.omit()

colnames(df_sheet) <- c("Timestamp", "Group", "Cell", "Nucleus")

df_tidy <-
  pivot_longer(
    df_sheet,
    cols = -c("Timestamp", "Group"),
    names_to = "Sample",
    values_to = "Size"
  )
head(df_tidy)

df_tidy <- df_tidy %>% mutate(Size = gsub(" ", "", Size)) %>% separate_rows(Size, sep=",") 

df_tidy <- df_tidy %>% mutate(Size = as.numeric(Size))

df_size <- df_tidy %>% filter(Size>0 & Size<1000)
head(df_size)

ggplot(df_size, aes(x=Size, fill=Sample))+geom_density(alpha=.8) +
  scale_x_log10()

ggplot(df_size, aes(x=Size, fill=Sample))+geom_histogram(alpha=.8) +
  facet_grid(Sample~Group, labeller = labeller(Group=label_both)) +
  scale_x_log10()

p <- ggplot(df_size, aes(x=Size)) +
  geom_histogram(alpha=.5, bins=50) +
  facet_grid(~Sample) +
  annotation_logticks(sides="b", outside = TRUE) +
  scale_x_log10()
p

p <-
  p + labs(
    title = "Distribution of size measurements",
    subtitle = "Sizes of human cells and nuclei of cells",
    x = "Size [µm] - log scale",
    y = "Count",
    caption = "@joachimgoedhart | data submitted by 4 groups of students",
    tag = "Protocol 10"
  )

p <-
  #Set text size
  p + theme_light(base_size = 16) +
  # Change the color and position of the caption
  theme(
    plot.caption = element_text(
      color = "grey80",
      hjust = 1
    )
  )
p

p <- p +
  #Force the y-axis to start at zero
  scale_y_continuous(expand = c(0, NA), limits = c(0,200)) +
  #Apply a logarithmic scale to the x-axis and set the numbers for the scale
  scale_x_log10(breaks = c(1,10,100), limits = c(.5,200)) +
  #Remove minor gridlines
  theme(panel.grid.minor = element_blank()) +
  #Add ticks to the bottom, outside
  annotation_logticks(sides="b", outside = TRUE) +
  #Give a little more space to the log-ticks by adding margin to the top of the x-axis text
  theme(axis.text.x = element_text(margin = margin(t=8))) +
  #Needed to see the tcks outside the plot panel
  coord_cartesian(clip = "off")
p

png(file=paste0("Protocol_10.png"), width = 3000, height = 2000, units = "px", res = 400)
  p
dev.off()
