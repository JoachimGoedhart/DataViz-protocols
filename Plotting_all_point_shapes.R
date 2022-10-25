library(tidyverse)

x <- rep(0:15, 8)
y <- rep(0:7, each=16)
shape <- 0:127

df_shapes <- data.frame(x=x, y=y, shape=shape) %>%
  filter(!shape %in% c(26:31)) #Shapes 26-31 are not defined, so we'll remove those

ggplot(data=df_shapes, aes(x,y)) +
  geom_point(aes(shape = as.factor(shape)), size=4, fill="blue") +
  scale_shape_manual(values = df_shapes$shape) +
  geom_label(aes(label=shape), nudge_y = -0.4, size=2, label.size = .2) +
  theme_minimal() +
  theme(legend.position = "none",
        axis.title = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_blank()) +
  scale_y_reverse() +
  NULL

