df_label <- df %>%
  filter(Month == 12) %>%
  arrange(desc(Year)) %>%
  slice(seq(1, n(), 5))

df_label_last <- tail(df, 1)

ggplot(df, aes(Month, total_max, color=as.factor(Year), fill=as.factor(Year))) +
  geom_line(linewidth=2) +
  coord_polar() +
  theme_bw(base_size = 14) +
  labs(
    x = "", y = "", color = "Year",
    title = "Evolution of the total number of plasmids",
    subtitle = "shared through addgene.org",
    tag = "Protocol 21",
    caption = "data provided by addgene.org - March 2024"
  ) +
  scale_y_continuous(limits = c(0, NA), expand = c(0, 0)) +
  guides(color = guide_legend(reverse = TRUE)) +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.x = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title.y = element_text(hjust = .8),
    plot.caption = element_text(color="grey80", hjust=1, vjust=5),
    legend.position = "none"
  ) +
  geom_point(data=df_label, aes(x=Month, y=total_max+600), color="black", shape=25, size=5) +
  geom_label(data=df_label, aes(x=Month, y=total_max+1200, label=paste0(Year,": ",total_max)),
             color="black", size=4, alpha=1) +
  geom_point(data=df_label_last, aes(x=Month, y=total_max), size=3) +
  geom_label(data=df_label_last, aes(x=Month, y=total_max+2000, label=paste0(total_max)),
             color="black", size=4, alpha=1) +
  NULL
