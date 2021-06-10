load("dataAnalyzed.RData")

library(ggplot2)

# Model triggered
# id: 44 to 73

# Model applied
# id : 77

# because id != data index
# we need to subtract every time 11

ggplot() +
  geom_rect(aes(xmin = 33, xmax = 62, ymin = -Inf, ymax = Inf), fill = "lightgreen", alpha = 0.7) +
  geom_rect(aes(xmin = 12, xmax = 62, ymin = -Inf, ymax = Inf), fill = "lightgreen", alpha = 0.5) +
  geom_rect(aes(xmin = 62, xmax = 66, ymin = -Inf, ymax = Inf), fill = "lightblue", alpha = 0.7) +
  annotate("text", x = 64, y = 1.1, label = "Retraining") +
  annotate("text", x = 45, y = 1.1, label = "Trigger") +
  annotate("text", x = 35, y = 1.2, label = "Retraining Data") +
  geom_line(data = data, aes(x = seq(1, 169), y = Diff)) +
  geom_point(data = data, aes(x = 66, y = Diff[66])) +
  geom_hline(yintercept = 0.15, linetype = "dashed", color = "red") +
  xlab("events") + ylab("error") +
  ggtitle("Model Behaviour")


ggplot() +
  geom_rect(aes(xmin = 1, xmax = 49, ymin = -Inf, ymax = Inf), fill = "steelblue", alpha = 0.5) +
  geom_rect(aes(xmin = 50, xmax = 109, ymin = -Inf, ymax = Inf), fill = "darkred", alpha = 0.5) +
  geom_rect(aes(xmin = 110, xmax = 169, ymin = -Inf, ymax = Inf), fill = "steelblue", alpha = 0.5) +
  annotate("text", x = 24, y = 1.2, label = "Salmon") +
  annotate("text", x = 78, y = 1.2, label = "Walleye") +
  annotate("text", x = 140, y = 1.2, label = "Salmon") +
  geom_line(data = data, aes(x = seq(1, 169), y = Diff)) +
  geom_hline(yintercept = 0.15, linetype = "dashed", color = "red") +
  xlab("events") + ylab("error") +
  ggtitle("Error Behaviour")
