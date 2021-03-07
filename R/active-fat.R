# 運動量と翌日の体脂肪増減の関係を解析

# Active energy : アクティブエネルギー [kcal]
filter.type <- "HKQuantityTypeIdentifierActiveEnergyBurned"
filter.source <- "Mi Fit"
df.activeenergy <- df %>%
    filter(type == filter.type & sourceName == filter.source) %>%
    select(lifedate, value) %>%
    mutate_at(vars(value), as.numeric) %>%
    rename(date = lifedate) %>%
    rename(activeenergy = value) %>%
    group_by(date) %>%
    summarise(activeenergy = sum(activeenergy))

# Weight [kg]
filter.type <- "HKQuantityTypeIdentifierBodyMass"
filter.source <- "HealthPlanet"
df.weight <- df %>%
    filter(type == filter.type & sourceName == filter.source) %>%
    select(date, value) %>%
    mutate_at(vars(value), as.numeric) %>%
    rename(weight = value)

# Body fat rate : 体脂肪率
filter.type <- "HKQuantityTypeIdentifierBodyFatPercentage"
filter.source <- "HealthPlanet"
df.bodyfat.rate <- df %>%
    filter(type == filter.type & sourceName == filter.source) %>%
    select(date, value) %>%
    mutate_at(vars(value), as.numeric) %>%
    rename(bodyfat.rate = value)

# Body fat : 体脂肪量 [kg] = `Wight` * `Body fat rate`
df.bodyfat <- df.bodyfat.rate %>%
    merge(df.weight, "date", all = T) %>%
    group_by(date) %>%
    summarise(bodyfat = bodyfat.rate * weight) %>%
    mutate(bodyfat.diff = lead(bodyfat) - bodyfat)  # 次回計測時の減少量

# 日付を key にして join
df.join <- df.bodyfat %>%
    merge(df.activeenergy, "date", all = T) %>%
    # select(activeenergy, bodyfat.diff)
    select(date, activeenergy, bodyfat.diff)

# 先に枠線だけ Plot
dev.new()
x <- df.join$activeenergy
y <- df.join$bodyfat.diff
x.med <- x %>%
    median(na.rm = TRUE)
y.med <- y %>%
    median(na.rm = TRUE)
x.abs.max <- x %>%
    abs() %>%
    max(na.rm = TRUE)
y.abs.max <- y %>%
    abs() %>%
    max(na.rm = TRUE)
pch <- 16  # ●でプロット
plot(x, y,
     type = "n",
     xlim = c(0, x.abs.max),
     ylim = c(-y.abs.max, y.abs.max),   # Y 軸の中心を0にする
     main = "Reration of Active energy and next day's Body fat",
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
prot.by.wday <- function(wday) {
    df.target <- df.join %>%
        filter (wday(date) == wday)
    col <- get.wday.color(wday)
    x.target <- df.target$activeenergy
    y.target <- df.target$bodyfat.diff
    par(new = TRUE)
    plot(x.target, y.target,
         xlim = c(0, x.abs.max),
         ylim = c(-y.abs.max, y.abs.max),  # Y 軸の中心を0にする
         ann = FALSE,
         pch = pch,
         col = col)
}
for(i in 1:7){
    prot.by.wday(i)
}
