ggplot(df, aes(x=ligand, y=`SGFP2-CTNNB1`, fill = ligand)) +
  geom_boxplot(outlier.color = NA) +
  geom_jitter() +
  facet_wrap(~compartment) +
  theme_linedraw(base_size = 16) +
  theme(panel.spacing = unit(0, "points")) +
  theme(
    strip.background = element_rect(fill=NA, color="black", size = .5),
    strip.text = element_text(color = "black"),
    panel.grid = element_blank(),
    legend.position = "none",
    plot.caption = element_text(color = "grey80")
  ) +
  labs(
    x = "",
    y = "Concentration [nM]",
    title = "Total SGFP2-CTNNB1",
    caption = "@joachimgoedhart | based on data from de Man et al., DOI: 10.7554/eLife.66440",
    tag = "Protocol 12"
  ) +
  NULL
