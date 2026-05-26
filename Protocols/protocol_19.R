ggplot(df, aes(x=Time, y=Ratio, group=Sample, color=Sample)) +
  geom_line(size=1) +
  geom_point(size=2) +
  annotate("rect", xmin=25, xmax=175, ymin=-Inf, ymax=Inf, alpha=0.1, fill="black") +
  theme_light(base_size = 16) +
  labs(x = "Time [s]", y = "Normalized Ratio",
       title = "Calcium oscillations induced by histamine",
       tag = "Protocol 19") +
  theme(panel.grid = element_blank()) +
  coord_cartesian(xlim = c(0, 190), ylim = c(0.8, 5.9), expand = FALSE) +
  facet_wrap(~Sample) +
  theme(strip.text.x = element_blank()) +
  theme(legend.position = "none") +
  NULL
