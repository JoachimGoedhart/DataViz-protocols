ggplot(df, aes(x=Time+(rank*10), y=(Activity+(rank*1)), group=Cell)) +
  geom_line(alpha=0.5, size=0.5) +
  labs(
    title = "Activities measured in single cells over time",
    subtitle = "Sorting of the cells is based on integrated activity",
    x = "Time [min]",
    y = "Activity [arbitrary units]",
    caption = "@joachimgoedhart | data from Reinhard et al; doi: 10.1091/mbc.E17-03-0136",
    tag = "Protocol 7"
  ) +
  theme_classic(base_size = 16) +
  theme(
    panel.grid.major = element_blank(),
    plot.caption = element_text(color = "grey80"),
    panel.grid.minor = element_blank(),
    axis.line.x = element_blank(),
    axis.title.x = element_text(hjust = 0.3)
  ) +
  annotate(geom = "segment", x=0, y=1, xend=10, yend=2, size=1) +
  annotate(geom = "segment", x=0, y=1, xend=20, yend=1, size=1) +
  scale_x_continuous(breaks = c(0, 20), expand = c(0, 0)) +
  NULL
