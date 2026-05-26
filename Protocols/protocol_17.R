ggplot(df, aes(x=Time, y=mean, color = type)) +
  geom_line(linewidth=2) +
  geom_point(aes(fill=type), color="black", size=4, shape=21) +
  theme_light(base_size=14) +
  theme(
    panel.grid = element_blank(),
    legend.position = "none"
  ) +
  annotate("rect", xmin=17.8333, xmax=18.0833, ymin=-Inf, ymax=Inf, fill="blue", alpha=0.1) +
  annotate("rect", xmin=18.3333, xmax=18.5833, ymin=-Inf, ymax=Inf, fill="blue", alpha=0.1) +
  scale_color_manual(values = c("#BEBEBE", "darkorchid")) +
  scale_fill_manual(values = c("#BEBEBE", "darkorchid")) +
  labs(
    title = "Reversible increase of resistance in endothelial cells by optogenetics",
    x = "Time [h]",
    y = "Resistance [Ω]",
    caption = "@joachimgoedhart\n(based on data from Mahlandt et al, DOI: https://doi.org/10.1101/2022.10.17.512253)",
    tag = "Protocol 17"
  ) +
  theme(plot.caption = element_text(color="grey80", hjust=1)) +
  NULL
