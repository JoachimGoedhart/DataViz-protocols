ggplot(df, aes(x=Tissue, y=Value)) +
  geom_line(aes(group=Replicate, color=difference<0), linewidth=1, alpha=0.8) +
  geom_point(color = "black", fill="grey", shape=21, size=3, alpha=0.8) +
  theme_light(base_size = 16) +
  scale_color_manual(
    values = c("red", "darkblue"),
    labels = c("Positive", "Negative"),
    name = "Slope Direction"
  ) +
  labs(
    title = "A colored slope plot",
    tag = "Protocol 24"
  ) +
  NULL
