library(ggrepel)

df_top <- df %>%
  filter(Change != "Unchanged") %>%
  mutate(distance = minus_log10_pvalue + abs(log2_FoldChange)) %>%
  top_n(10, distance)

newColors <- c("dodgerblue", "orange", "grey")

ggplot(data = df, aes(x=log2_FoldChange, y=minus_log10_pvalue)) +
  geom_vline(xintercept = c(-1.5, 1.5), linetype="dashed") +
  geom_hline(yintercept = 5, linetype="dashed") +
  geom_point(aes(color = Change)) +
  geom_point(data = df_top, aes(x=log2_FoldChange, y=minus_log10_pvalue, fill=Change),
             shape=21, color="black", size=2) +
  scale_color_manual(values = newColors) +
  scale_fill_manual(values = newColors) +
  geom_text_repel(
    data = df_top,
    aes(label = Gene),
    size = 5,
    min.segment.length = 0,
    box.padding = 0.5
  ) +
  labs(
    title = "Differentially expressed genes",
    x = expression("Fold Change ("*Log[2]*")"),
    y = expression("Significance ("*-Log[10]*")"),
    caption = "@joachimgoedhart\n(based on data from Becares et al, DOI: 10.1016/j.celrep.2018.12.094)",
    tag = "Protocol 14"
  ) +
  theme_light(base_size = 16) +
  theme(plot.caption = element_text(color = "grey80", hjust = 1)) +
  theme(panel.grid = element_blank()) +
  theme(legend.position = "none") +
  xlim(-3, 3) +
  NULL
