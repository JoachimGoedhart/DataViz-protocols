ggplot(df, aes(x=fct_rev(Analysis), y=S_phase, fill=Analysis, color=Analysis)) +
  geom_flat_violin(position = position_nudge(x = .15, y = 0), width=0.8) +
  geom_jitter(width = 0.1) +
  coord_flip() +
  theme_light(base_size = 16) +
  scale_fill_manual(values = c("darkorange2", "dodgerblue3")) +
  scale_color_manual(values = c("darkorange2", "dodgerblue3")) +
  theme(
    legend.position = "none",
    plot.caption = element_text(color = "grey80", hjust = 1)
  ) +
  labs(
    title = "The percentage of cells in S-phase...",
    subtitle = "...determined by two methods",
    x = "Analysis",
    y = "S-phase [%]",
    caption = "@joachimgoedhart | data submitted by students",
    tag = "Protocol 27"
  ) +
  NULL
