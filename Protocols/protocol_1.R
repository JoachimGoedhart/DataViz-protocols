ggplot(data = df, aes(x = Wavelength, y = Intensity, fill = `Fluorescent Protein`)) +
  geom_line(aes(linetype = Spectrum), size = 0.5, alpha = 0.5) +
  geom_area(aes(linetype = Spectrum), color = NA, position = "identity", size = 1, alpha = 0.5) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 1.1)) + 
  scale_x_continuous(expand = c(0,0), limits = c(350, 810)) +
  labs(
    title = "Spectra of Fluorescent Proteins",
    x = "Wavelength [nm]",
    y = "Normalized Intensity [a.u.]",
    caption = "(based on data from FPbase.org)",
    tag = "Protocol 1"
  ) + 
  theme_light(base_size = 14) +
  theme(plot.caption = element_text(color = "grey80", hjust = 1),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    legend.position = "top",
    legend.justification = "left"
  ) +
  guides(
    linetype = "none",
    fill = guide_legend(title = NULL, label.position = "right")
  ) +
  scale_fill_manual(values = c("blue", "green", "orange", "red")) +
  NULL
