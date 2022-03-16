ggplot() +
  geom_tile(data=df, aes(x=position, y=aa)) +
  scale_y_discrete(limits = rev(amino_acid_ordered)) +
  theme_classic(base_size = 16) +
  annotate(geom = "rect", xmin = -Inf, ymin = 0.5, xmax = Inf, ymax=3.5, fill='blue', alpha=0.15) +
  annotate(geom = "rect", xmin = -Inf, ymin = 3.5, xmax = Inf, ymax=5.5, fill='red', alpha=0.15) +
  annotate(geom = "rect", xmin = -Inf, ymin = 5.5, xmax = Inf, ymax=10.5, fill='yellow', alpha=0.15) +
  annotate(geom = "rect", xmin = -Inf, ymin = 10.5, xmax = Inf, ymax=20.5, fill='black', alpha=0.15) +
  labs(
    title = "Mapping the amino acid positions of HOXD13",
    subtitle = "shows a high abundance of alanines in the IDR",
    y = "Amino acid",
    caption = "(based on data from Basu et al, DOI: 10.1016/j.cell.2020.04.018)",
    tag = "Protocol 5"
  ) +
  theme(plot.caption = element_text(color = "grey80", hjust = 1)) +
  annotate("rect", xmin=0, xmax=118, ymin=21, ymax=22, fill='darkblue') +
  annotate("text", x=59, y=23, alpha=1, color='darkblue', size=4,label='IDR') +
  coord_cartesian(clip = 'off') +
  theme(plot.subtitle = element_text(margin = margin(b=20))) +
  NULL
