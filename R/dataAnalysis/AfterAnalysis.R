load("dataAnalyzed.RData")

library(ggplot2)

# Model triggered
# id: 44 to 73

# Model applied
# id : 77

# because id != data index
# we need to subtract every time 11

ggplot() +
  geom_rect(aes(xmin = 33, xmax = 62, ymin = -Inf, ymax = Inf), fill = "#00AFBA", alpha = 0.7) +
  geom_rect(aes(xmin = 12, xmax = 62, ymin = -Inf, ymax = Inf), fill = "#00AFBA", alpha = 0.5) +
  geom_rect(aes(xmin = 62, xmax = 66, ymin = -Inf, ymax = Inf), fill = "#C5832E", alpha = 0.7) +
  annotate("text", x = 64, y = 1.1, label = "Retraining", color = "#173361") +
  annotate("text", x = 45, y = 1.1, label = "Trigger", color = "#173361") +
  annotate("text", x = 35, y = 1.2, label = "Retraining Data", color = "#173361") +
  geom_line(data = data, aes(x = seq(1, 169), y = Diff), color = "#173361") +
  geom_point(data = data, aes(x = 66, y = Diff[66]), color = "#173361") +
  geom_hline(yintercept = 0.15, linetype = "dashed", color = "steelblue") +
  xlab("Events") + ylab("Error") +
  ggtitle("Model Behaviour") +
  theme(axis.title.x = element_text(colour = "#173361"),
        axis.title.y = element_text(colour = "#173361"),
        title = element_text(color = "#173361")) +
  annotate(geom = "text", x = 160, y = 0.2, label = "Threshold 15 %",
           color = "steelblue") +
  annotate(geom = "text", x = 90, y = 0.5, label = "New Model",
           color = "#173361") +
  annotate("segment", x = 90, xend = 68, y = 0.45, yend = 0.05, colour = "#0074A2", size = 1, arrow = arrow())


ggplot() +
  geom_rect(aes(xmin = 1, xmax = 49, ymin = -Inf, ymax = Inf), fill = "#00AFBA", alpha = 0.5) +
  geom_rect(aes(xmin = 50, xmax = 109, ymin = -Inf, ymax = Inf), fill = "#C5832E", alpha = 0.5) +
  geom_rect(aes(xmin = 110, xmax = 169, ymin = -Inf, ymax = Inf), fill = "#00AFBA", alpha = 0.5) +
  annotate("text", x = 24, y = 1.2, label = "Salmon", color = "#173361") +
  annotate("text", x = 78, y = 1.2, label = "Walleye", color = "#173361") +
  annotate("text", x = 140, y = 1.2, label = "Salmon", color = "#173361") +
  geom_line(data = data, aes(x = seq(1, 169), y = Diff), color = "#173361") +
  geom_hline(yintercept = 0.15, linetype = "dashed", color = "steelblue") +
  xlab("Events") + ylab("Error") +
  ggtitle("Error Behaviour") +
  theme(axis.title.x = element_text(colour = "#173361"),
        axis.title.y = element_text(colour = "#173361"),
        title = element_text(color = "#173361")) +
  annotate(geom = "text", x = 160, y = 0.2, label = "Threshold 15 %",
           color = "steelblue") 
