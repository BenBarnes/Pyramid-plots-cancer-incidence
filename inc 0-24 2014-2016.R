library(data.table)
library(ggplot2)

base <- "C:/Users/barnesb/Documents/Incidence"

inc0_24 <- fread(file.path(base, "Incidence 0-24 2014-2016.csv"),
  na.strings = "x")

mDat <- inc0_24[order(male, decreasing = FALSE)]
mDat[, `Cancer site` := factor(`Cancer site`, levels = `Cancer site`)]
wDat <- inc0_24[order(female, decreasing = FALSE)]
wDat[, `Cancer site` := factor(`Cancer site`, levels = `Cancer site`)]

ggplot(wDat[female > 25], aes(x = female, y = `Cancer site`)) +
  geom_col(fill = "green3") + ggtitle("Female 0-24 years")

ggplot(mDat[male > 25], aes(x = male, y = `Cancer site`)) +
  geom_col(fill = "blue3") + ggtitle("Male 0-24 years")
