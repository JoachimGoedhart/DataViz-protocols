yrs <- data.frame(Year = min(df$Year):max(df$Year))

ggplot(df, aes(x=1, y=Year)) +
  geom_vline(xintercept = 1, size=0.1) +
  geom_point(shape=21, size=3, fill="white") +
  geom_point(data=yrs, aes(x=1), size=0.5, color="grey20") +
  geom_text(aes(label = Event), hjust = 0, nudge_x = 0.02, size=3) +
  theme_minimal() +
  theme(
    panel.grid.major.y = element_line(colour = "grey90", size=0.25),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    legend.position = "none",
    plot.caption = element_text(color = "grey80")
  ) +
  scale_y_continuous(breaks = seq(min(df$Year), max(df$Year), by = 2)) +
  labs(
    title = "A brief timeline of GFP",
    x = "",
    y = "",
    caption = "@joachimgoedhart | based on data from various sources",
    tag = "Protocol 15"
  ) +
  NULL
