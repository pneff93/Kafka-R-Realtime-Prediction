load("dataAnalyzed.RData")

library(ggplot2)

# Model getriggert
# 47 bis 61 erste Analye danach
# 62 bis 86

# Model applied
# 78
# 102

ggplot(data = data) + geom_line(aes(x = seq(1, 170), y = Diff), color = "steelblue") +
  xlab("events") + ylab("difference prediction vs. actual") +
  geom_vline(xintercept = 61) + geom_vline(xintercept = 78) +
  geom_hline(yintercept = 0.1)
