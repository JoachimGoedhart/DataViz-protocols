df_summary <- df %>% na.omit() %>%
  group_by(Condition) %>%
  summarise(
    n = n(),
    mean = mean(Area),
    sd = sd(Area),
    sem = sd / sqrt(n - 1),
    .groups = "drop"
  )

p1 <- ggplot(df, aes(x=Condition)) +
  theme_bw(base_size = 12) +
  theme(panel.grid = element_blank()) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 4200)) +
  labs(y = NULL) +
  geom_errorbar(data=df_summary,
                aes(x=Condition, ymin=mean-sem, ymax=(mean+sem)),
                width=0.3, size=1, alpha=0.7) +
  geom_bar(data=df_summary, aes(y=mean), stat = "identity", width = 0.5) +
  labs(y = expression("Area [µm"^2*"]"), title = "Clean | Data hidden")

p2 <- ggplot(df, aes(x=Condition, y=Area)) +
  theme_bw(base_size = 12) +
  theme(panel.grid = element_blank()) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 4200)) +
  labs(y = NULL) +
  geom_jitter(position=position_jitter(0.3), cex=2, alpha=0.4) +
  labs(title = "Messy | Data shown")

p3 <- ggplot(df, aes(x=Condition, y=Area)) +
  theme_bw(base_size = 12) +
  theme(panel.grid = element_blank()) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 4200)) +
  labs(y = NULL) +
  geom_quasirandom(varwidth = TRUE, cex=2, alpha=0.4) +
  labs(title = "Clean | Data shown")

p1 + p2 + p3 +
  plot_annotation(
    title = "Protocol 13",
    caption = "@joachimgoedhart",
    theme = theme(
      plot.caption = element_text(size = 12, color = "grey80"),
      plot.title = element_text(size = 18)
    )
  )
