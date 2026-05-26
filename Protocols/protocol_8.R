ggplot(data=df, aes(x=as.factor(column), y=fct_rev(row))) +
  geom_point(aes(color=Intensity), size=10) +
  scale_x_discrete(position = "top") +
  scale_color_viridis_c(label = scales::comma) +
  labs(
    title = "Readings from a 96-wells plate",
    x = NULL,
    y = NULL,
    caption = "\n@joachimgoedhart\nbased on data from Brandorff et al., DOI: 10.1101/2021.07.08.451595",
    color = "Intensity [a.u.]",
    tag = "Protocol 8"
  ) +
  theme_light(base_size = 14) +
  theme(
    legend.text.align = 1,
    plot.caption = element_text(color = "grey80"),
    plot.subtitle = element_text(color = "grey50", face = "italic"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  ) +
  coord_fixed() +
  NULL
