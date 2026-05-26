df <- df %>%
  filter(n > 15) %>%
  mutate(Material = as.factor(Material),
         Material = fct_reorder(Material, n))

ggplot(df, aes(x=Material, y=n, fill=flame)) +
  geom_col() +
  coord_flip() +
  scale_fill_identity() +
  theme_bw(base_size = 12) +
  labs(
    x = "",
    y = "Number of requests",
    title = "Requests for our plasmids at Addgene.org",
    tag = "Protocol 22",
    caption = "@joachimgoedhart | Data from addgene"
  ) +
  theme(
    legend.position = "none",
    plot.caption = element_text(color="grey80", hjust=1),
    panel.border = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major.y = element_blank(),
    axis.ticks.x = element_blank(),
    axis.text.y = element_text(size=8)
  ) +
  scale_y_continuous(expand = c(0, 0)) +
  NULL
