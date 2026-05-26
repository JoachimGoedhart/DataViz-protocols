df$ID <- as.factor(df$ID)

df_label <- df %>% filter(category == "S")

p <- ggplot(df, aes(x = 1, y = percentage, fill = ID)) +
  geom_bar(stat = "identity") +
  facet_wrap(~Analysis, strip.position = "bottom") +
  coord_polar(theta = "y", direction = -1) +
  xlim(-0.5, 1.5) +
  scale_fill_manual(values = c("darkorange2", "grey80", "dodgerblue3", "grey80")) +
  theme_void() +
  theme(
    legend.position = "none",
    plot.caption = element_text(color = "grey80", hjust = 1),
    plot.title = element_text(hjust = 0.5, size = 18),
    plot.subtitle = element_text(hjust = 0.5, size = 18),
    strip.text = element_text(size = 16, face = "bold"),
    strip.placement = "inside"
  ) +
  geom_text(data = df_label, aes(label = paste0(round(percentage, 0), "%")), x = -0.5, y = 0, size = 12) +
  labs(
    title = "The percentage of HeLa cells in S-phase...",
    subtitle = "...determined by two methods",
    caption = "@joachimgoedhart | data submitted by students",
    tag = "Protocol 26"
  )

p
