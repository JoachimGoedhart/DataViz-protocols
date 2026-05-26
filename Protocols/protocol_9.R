df$Replicate <- as.factor(df$Replicate)

df_summary <- df %>% group_by(Concentration, Replicate) %>% summarise(mean_Response=mean(Response), .groups = "drop")

fit <- nls(mean_Response ~ top+(bot-top)/(1+(Concentration/EC50)^slope),
           data = df_summary,
           start=list(bot=-2, top=8, EC50=1, slope=1))

Tol_bright <- c('#66CCEE', '#BBBBBB', '#CCBB44','#AA3377','#228833', '#4477AA')

ggplot(data = df, aes(x = Concentration, y = Response)) +
  geom_jitter(aes(color=Replicate), width=0.2, size=2, shape=16, alpha=0.2) +
  geom_point(data=df_summary, aes(y = mean_Response, fill=Replicate), size=8, shape=21, alpha=0.8) +
  scale_x_log10() +
  ylim(-1, 6) +
  theme_light(16) +
  labs(
    title = "Responses of individual cells to Histamine",
    x = "Histamine concentration [µM]",
    y = "Response [arbitrary units]",
    caption = "@joachimgoedhart\nbased on data from Chavez-Abiega et al., DOI: 10.1242/jcs.259685",
    tag = "Protocol 9"
  ) +
  theme(plot.caption = element_text(color = "grey80")) +
  scale_fill_manual(values = Tol_bright) +
  scale_color_manual(values = Tol_bright) +
  geom_smooth(data = augment(fit), aes(x=Concentration, y=.fitted), color="black", size=1) +
  NULL
