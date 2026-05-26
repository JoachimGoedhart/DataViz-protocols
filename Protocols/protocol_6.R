df$Unique_Object <- as.factor(df$Unique_Object)

top_five <- function(x) {sum(tail(sort(x), 5))}

df <- df %>% mutate(Unique_Object = fct_reorder(Unique_Object, ERKn, top_five))

ggplot(df, aes(x=Time_in_min, y=Unique_Object, fill=ERKn)) +
  geom_tile() +
  scale_fill_viridis_c(na.value="black", limits = range(-0.1,1.5)) +
  labs(
    title = "ERK activity is increased by S1P",
    subtitle = "and varies strongly between cells",
    x = "Time after addition of S1P (min)",
    y = "Cells sorted according to response",
    caption = "@joachimgoedhart\n(based on data from Chavez-Abiega: xxxx)",
    tag = "Protocol 6",
    fill = "ERK C/N ratio"
  ) +
  theme_light(base_size = 14) +
  theme(
    plot.caption = element_text(color = "grey80", hjust = 1.3),
    plot.title = element_text(hjust = 0.1, margin = margin(t=10)),
    plot.subtitle = element_text(hjust = 0.1, margin = margin(t=2, b=5)),
    panel.background = element_blank(),
    panel.border = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.title.y = element_blank(),
    axis.ticks = element_line(colour = "black")
  ) +
  NULL
