library(scales)

custom_order <- rev(strsplit("QENHDRKTSAGMCLVIWYFP", "")[[1]])
df$mutAA <- factor(df$mutAA, levels = custom_order)

ggplot(data = df, aes(pos, mutAA, fill = ddG)) +
  geom_tile(colour="white", linewidth = .4) +
  geom_point(aes(pos, wtAA), colour="grey80", shape=21, fill=NA) +
  scale_fill_gradient2(high = "purple4", low = "orange4",
                       limits = range(-2, 2), oob = squish) +
  coord_cartesian(expand = FALSE) +
  theme_light(base_size = 12) +
  theme(
    legend.position = "bottom",
    panel.grid = element_blank(),
    panel.border = element_blank(),
    plot.caption = element_text(color = "grey80", hjust = 1),
    plot.title = element_text(hjust = 0.5, size = 18),
    plot.subtitle = element_text(hjust = 0.5, size = 18),
    legend.title = element_text(vjust = .8)
  ) +
  labs(
    title = "Predicted protein stability",
    caption = "data generated with ThermoMPNN | PDB ID: 1PGA",
    x = "position",
    y = "amino acid",
    tag = "Protocol 28",
    fill = "ΔΔG (kcal/mol) "
  ) +
  NULL
