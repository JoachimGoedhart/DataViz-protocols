#Define the line segments that are used for the axes
ann_line<-data.frame(xmin=0,xmax=300,ymin=0,ymax=1,
                     Cell=factor("neutro 6",levels=c("neutro 6")))


ggplot(df, aes(x=time, y=Roundness, group=Cell)) +
  geom_line() +
  facet_wrap(~Cell) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 1.0)) + 
  scale_x_continuous(expand = c(0,0), limits = c(0, 300)) +
  theme_minimal(base_size = 14) +
  theme(strip.background = element_blank(),
               strip.text = element_blank(),
               plot.caption = element_text(color = "grey80"),
               #Remove grid
               panel.grid.major = element_blank(),
               panel.grid.minor = element_blank(),
                #Remove axis labels
                axis.text = element_blank()
                ) +
  geom_segment(data=ann_line, aes(x=xmin,xend=xmin,y=ymin,yend=ymax), size=2, color='grey40') +
  #Horizontal line
  geom_segment(data=ann_line, aes(x=xmin,xend=xmax,y=ymin,yend=ymin), size=2, color='grey40') +

  theme(panel.background = element_rect(fill='grey98', color=NA),
        panel.border = element_rect(color='grey90', fill=NA),
        axis.title.x = element_text(size=14, hjust = 0, color='grey40'),
        axis.title.y = element_text(size=14, vjust = 0, hjust=0, angle = 90, color='grey40'),
  ) +
  labs(
    title = "Changes in the shape of migrating cells over time",
    x = "Time [300s]",
    y = "Circularity [0-1]",
    caption = "(based on data from Arts et al., DOI: 10.3389/fimmu.2021.667213)",
    tag = "Protocol 3"
  ) +
  NULL


