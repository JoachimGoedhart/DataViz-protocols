df_cor <- df %>%
  group_by(System, Order) %>%
  drop_na() %>%
  summarize(R_squared = cor(CFP, YFP, method = "pearson")^2, .groups = "drop")

ggplot(df, aes(x=YFP, y=CFP)) +
  geom_point(size = 0.5, alpha=0.5) +
  facet_grid(Order~System) +
  geom_smooth(method = "lm", formula = y~x+0) +
  theme_minimal(14) +
  theme(
    axis.text = element_blank(),
    panel.grid = element_blank(),
    strip.background = element_rect(fill="#E0E0FF", color="grey90", size = .5),
    panel.background = element_rect(fill="#F4F4FF", color="grey90"),
    plot.caption = element_text(color="grey80", hjust=1)
  ) +
  labs(
    x = "yellow fluorescence [a.u.]",
    y = "cyan fluorescence [a.u.]",
    title = "Correlations for co-expression systems",
    caption = "\n@joachimgoedhart\nbased on data from Goedhart et al., DOI: 10.1371/journal.pone.0027321",
    tag = "Protocol 16"
  ) +
  geom_text(data=df_cor,
            x=Inf, y=0, hjust=1.1, vjust=0,
            aes(label=paste0("R^2 == ", round(R_squared, 2))),
            parse = TRUE, color="darkslateblue") +
  NULL
