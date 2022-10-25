library(tidyverse)

x <- rep(0:15, 8)
y <- rep(0:7, each=16)
shape <- 1:128

df_shapes <- data.frame(x=x, y=y, shape=shape) 

ggplot(df_shapes, aes(x,y))+geom_label(aes(label=shape))


df_label <- df_shapes %>% filter(!shape %in% c(26:32))

ggplot(data=(df_shapes), aes(x,y)) +
  geom_point(shape = as.factor(shape), size=4, fill="blue") +
  scale_shape_manual(values = c(1:128)) +
  geom_label(data=df_label, aes(x=x,y=y,label=shape), nudge_y = -0.4, size=2, label.size = .2) +
  theme_minimal() +
  theme(legend.position = "none",
        axis.title = element_blank(),
        axis.text = element_blank()) +
  theme(panel.grid = element_blank()) +
  scale_y_reverse() +
  NULL
