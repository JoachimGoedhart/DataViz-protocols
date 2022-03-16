ggplot(df, aes(x=condition, y=`Fold Change`)) +
  geom_jitter(width = 0.2, alpha=0.5, size=3) +
  facet_grid(treatment1~treatment2) +
  stat_summary(fun.min=mean, fun.max=mean, geom='errorbar', width=0.6, size=0.5) +
  labs(
    title = "Effect of DNA sequences on reporter levels under different conditions",
    subtitle = "The expression level was determined by a dual luciferase assay\n and the values were normalized to a control with no DNA sequence (-)",
    x = "DNA Sequence",
    y = "Fold change of the reporter relative to the control (-)",
    caption = "(based on data from Brandorff et al., DOI: 10.1101/2021.07.08.451595)",
    tag = "Protocol 4"
  ) +
  theme_light(base_size = 14) +
  theme(strip.background = element_rect(fill="grey90", color="grey50"),
               strip.text = element_text(color="grey50"),
               plot.caption = element_text(color = "grey80"),
               plot.subtitle = element_text(color = "grey50", face = "italic"),
               #Remove the grid
               panel.grid.major = element_blank(),
               panel.grid.minor = element_blank()
  ) +
  NULL
