Okabe_Ito <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#000000")

theme_light_dark_bg <- function() {
  theme_light(base_size = 16) %+replace%
    theme(
      plot.background = element_rect(fill = "grey15", color = NA),
      panel.background = element_rect(fill = "grey15", color = NA),
      strip.background = element_rect(fill = "grey25", color = NA),
      strip.text = element_text(color = "grey90"),
      axis.text = element_text(color = "grey70"),
      axis.title = element_text(color = "grey80"),
      plot.title = element_text(color = "grey90"),
      plot.caption = element_text(color = "grey50")
    )
}

ggplot(df, aes(x=Time, y=Value, color=Sample)) +
  geom_line(linewidth=1.5) +
  facet_wrap(~Sample) +
  scale_color_manual(values=Okabe_Ito) +
  theme_light_dark_bg() +
  theme(
    legend.position = "none",
    strip.text = element_blank(),
    panel.grid = element_blank(),
    panel.border = element_blank(),
    axis.line.x = element_line(colour = "grey80"),
    axis.line.y = element_line(colour = "grey80")
  ) +
  labs(
    x = "Time [s]",
    y = "Normalized Ratio",
    title = "G-protein activation and deactivation",
    tag = "Protocol 25"
  ) +
  scale_x_continuous(breaks=c(0, 100, 200)) +
  NULL
