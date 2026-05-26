ggplot(df, aes(x=Size)) +
  geom_histogram(alpha=.5, bins=50) +
  facet_grid(~Sample) +
  labs(
    title = "Distribution of size measurements",
    subtitle = "Sizes of human cells and nuclei of cells",
    x = "Size [µm] - log scale",
    y = "Count",
    caption = "@joachimgoedhart | data submitted by 4 groups of students",
    tag = "Protocol 10"
  ) +
  theme_light(base_size = 16) +
  theme(
    plot.caption = element_text(color = "grey80", hjust = 1)
  ) +
  scale_y_continuous(expand = c(0, NA), limits = c(0, 200)) +
  scale_x_log10(breaks = c(1, 10, 100), limits = c(.5, 200)) +
  theme(panel.grid.minor = element_blank()) +
  annotation_logticks(sides="b", outside = TRUE) +
  theme(axis.text.x = element_text(margin = margin(t=8))) +
  coord_cartesian(clip = "off") +
  NULL
