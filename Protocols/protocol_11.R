ggplot(df, aes(x=hour)) +
  geom_hline(yintercept = c(2, 4, 6, 8), colour = "grey90", size = 0.5) +
  geom_vline(xintercept = seq(0, 21, by=3), colour = "grey90", size = 0.5) +
  geom_histogram(bins = 24, alpha=.8, color="black") +
  coord_polar(start = (-7.5 - 15*15)*pi/180) +
  scale_x_continuous(breaks=seq(0, 24, by=3)) +
  theme_minimal(base_size = 16) +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    axis.text.y = element_blank()
  ) +
  labs(
    title = "Counting the hours...",
    subtitle = "that a Google form was submitted",
    x = "",
    y = "",
    caption = "@joachimgoedhart | data submitted by students",
    tag = "Protocol 11"
  ) +
  theme(plot.caption = element_text(color = "grey80", hjust = 1)) +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  ) +
  NULL
