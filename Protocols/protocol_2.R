ggplot(data=df, aes(x=Stage)) +
  geom_violin(data=df, aes(x=Stage, y=`Calcium (uM)`), color=NA, fill="grey80")+
  geom_linerange(data = df, aes(ymin=`95%CI_lo`, ymax=`95%CI_hi`), size=1, alpha=0.8) +
  geom_point(data=df, aes(x=Stage, y=mean, size=n, fill=Replicate),  shape=21, stroke = 1) +
  scale_size_area(breaks = c(10, 50, 90), max_size = 6) +
  coord_flip(ylim = c(0.02,0.09)) +
  # This ensures correct order of conditions when plot is rotated 90 degrees
  scale_x_discrete(limits = rev) +
  geom_hline(yintercept = 0.060, linetype='dotted') +
  labs(
    title = "Calcium concentrations are less than 60 nM",
    subtitle = "at different stages of transendothelial migration",
    x = "Stage",
    y = "Calcium [µM]",
    caption = "(based on data from van der Linden, DOI: 10.1101/2021.06.21.449214)",
    tag = "Protocol 2"
  ) +
  theme_classic(base_size = 16) +
  theme(plot.caption = element_text(color = "grey80", hjust = 1),
    #Set position of legend to lower right corner
    legend.position = c(0.88,0.15),
    #This line positions the label ('title') of the conditions
    axis.title.y = element_text(vjust = 0.98, angle = 0, margin=margin(l=70)),
    #This line positions the names of the conditions
    #A negative margin is needed for aligning the y-axis 'title' with the 'text'
    axis.text.y = element_text(vjust = 0.5, hjust=1, angle = 0, margin=margin(l=-90, r=5)),
    #Move 'tag', so its position partially overlaps with the conditions
    plot.tag.position = c(0.06,0.99)
  ) +
  guides(fill = "none", size = guide_legend(title = 'n per replicate', label.position = "left")) +
  NULL
