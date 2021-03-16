# 運動量と翌日体脂肪増減の関係解析用散布図をプロット

# 先に枠線だけ Plot
dev.new()
x <- df.join$activeenergy
y <- df.join$bodyfat.diff
x.med <- x %>%
    median(na.rm = TRUE) %>%
    formatC(digits = 3)
x.avg <- x %>%
    mean(na.rm = TRUE) %>%
    formatC(digits = 3)
y.med <- y %>%
    median(na.rm = TRUE) %>%
    formatC(digits = 3)
y.avg <- y %>%
    mean(na.rm = TRUE) %>%
    formatC(digits = 3)
x.abs.max <- x %>%
    abs() %>%
    max(na.rm = TRUE)
y.abs.max <- y %>%
    abs() %>%
    max(na.rm = TRUE)
n <- df.join %>%
    na.omit() %>%
    nrow()
xlim <- c(0, x.abs.max)
ylim <- c(-y.abs.max, y.abs.max) # Y 軸の中心を0にする
sub <- paste("n =", n, ", ",
             "x.med =", x.med, ", ",
             "x.avg =", x.avg, ", ",
             "y.med =", y.med, ", ",
             "y.avg =", y.avg)

pch <- 16  # ●でプロット
plot(x, y,
     type = "n",
     xlim = xlim,
     ylim = ylim,
     main = "Reration of Active energy and next day's Body fat",
     sub = sub,
     xlab = "Active energy [kcal]",
     ylab = "Increased body fat [kg]")
abline(h = 0)                    # Y = 0 に線を引く
abline(v = x.med, col = "gray")  # X 軸の中央値線
abline(h = y.med, col = "gray")  # Y 軸の中央値線
abline(lm(y~x), col = "purple")  # 回帰直線

# 凡例
legend.key <- c("Mon. Tue. Wed. Thu.",
                "Fri.",
                "Sat. Sun.")
legend.col <- c("blue",
                "green",
                "red")
legend("topright", legend = legend.key, col = legend.col, pch = pch)

# 曜日毎に Plot 色を設定
get.wday.color <- function(wday) {
    #           Sun.   Mon.    Tue.    Wed.    Thu.    Fri.     Sat.
    color <- c("red", "blue", "blue", "blue", "blue", "green", "red")
    return(color[wday])
}

# 曜日毎に Plot
plot.by.wday <- function(wday) {
    df.target <- df.join %>%
        filter (wday(date) == wday)
    col <- get.wday.color(wday)
    x.target <- df.target$activeenergy
    y.target <- df.target$bodyfat.diff
    par(new = TRUE)
    plot(x.target,
         y.target,
         xlim = xlim,
         ylim = ylim,
         ann = FALSE,
         pch = pch,
         col = col)
}
for(i in 1:7){
    plot.by.wday(i)
}
