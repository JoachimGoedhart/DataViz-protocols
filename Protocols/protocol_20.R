newColors <- c("cornflowerblue", "darkorchid4", "springgreen4")

df_fit_off <- df %>% mutate(Time = Time - 121)
df_fit_off <- df_fit_off %>% filter(System == "iLID" & Time >= 0 | System == "magnets" & Time >= 0)

fitted_off <- df_fit_off %>%
  nest(data = -System) %>%
  mutate(
    fit = map(data, ~nls(mean ~ a0 + a * (1 - exp(-k * Time)),
                         data = .,
                         start = list(a0 = 2, a = -2, k = .1))),
    augmented = map(fit, augment)
  )

augmented <- fitted_off %>% unnest(augmented)

ggplot(data = augmented, aes(x = Time, y = mean, colour = System)) +
  geom_point(size = 4, alpha = .5) +
  geom_line(aes(y = .fitted), color = "black", linewidth = 1) +
  facet_wrap(~System) +
  scale_color_manual(values = newColors) +
  labs(
    title = "Off-kinetics of two optogenetic systems",
    x = "Time [s]",
    y = "Response [arbitrary units]",
    caption = "@joachimgoedhart\nbased on data from Mahlandt et al., DOI: 10.1101/2022.10.17.512253",
    tag = "Protocol 20"
  ) +
  theme(plot.caption = element_text(color = "grey80"),
        legend.position = "none") +
  NULL
