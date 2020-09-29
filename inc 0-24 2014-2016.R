library(data.table)
library(ggplot2)

base <- "C:/Users/barnesb/Documents/Incidence"
base <- "/Users/benjaminbarnes/Documents/GitHub/Pyramid-plots-cancer-incidence"

inc0_24 <- fread(file.path(base, "Incidence 0-24 2014-2016.csv"),
  na.strings = "x")

mDat <- inc0_24[order(male, decreasing = FALSE)]
mDat[, `Cancer site` := factor(`Cancer site`, levels = `Cancer site`)]
wDat <- inc0_24[order(female, decreasing = FALSE)]
wDat[, `Cancer site` := factor(`Cancer site`, levels = `Cancer site`)]

maxCases <- inc0_24[, max(c(female, male), na.rm = TRUE)]

wp <- ggplot(wDat[!is.na(female) & female >= 10], aes(x = female, y = `Cancer site`)) +
  geom_col(fill = "green3") + ggtitle("Female 0-24 years") + xlim(c(0, maxCases)) +
  xlab("cases")

mp <- ggplot(mDat[!is.na(male) & male >= 10], aes(x = male, y = `Cancer site`)) +
  geom_col(fill = "blue3") + ggtitle("Male 0-24 years") + xlim(c(0, maxCases)) +
  xlab("cases")

myRes <- 150

png(file.path(base, "Incidence women 0-24 2014-2016.png"),
    width = 12 * myRes, height = 16 * myRes)
print(wp + theme_gray(base_size = 50))
dev.off()

png(file.path(base, "Incidence men 0-24 2014-2016.png"),
    width = 12 * myRes, height = 16 * myRes)
print(mp + theme_gray(base_size = 50))
dev.off()

