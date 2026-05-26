ggplot(df, aes(x=state, y=norm_ratio, group = replicate, fill=construct, color=construct)) +
  geom_quasirandom(alpha=0.3, size=2) +
  facet_wrap(~construct, nrow = 1) +
  theme_bw(base_size = 16) +
  theme(aspect.ratio = 4) +
  stat_summary(fun = median, geom="line", color="black", linewidth=1) +
  stat_summary(fun = median, geom="point", size=6, shape=21, color="black", alpha=0.5) +
  scale_color_manual(values = c("darkgreen","darkgreen","darkgreen","darkgreen","darkgreen","darkseagreen4","darkseagreen4")) +
  scale_fill_manual(values = c("darkgreen","darkgreen","darkgreen","darkgreen","darkgreen","darkseagreen4","darkseagreen4")) +
  guides(fill = "none", color = "none") +
  labs(
    title = "Cellular brightness of green Calcium biosensors",
    subtitle = "pre and post ionomycin addition",
    tag = "Protocol 23",
    y = "normalized brightness"
  ) +
  theme(panel.grid = element_blank()) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 1.3)) +
  NULL
