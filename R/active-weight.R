# 運動量と翌日の体重増減の関係を解析 (あまり意味のない指標)

# Weight [kg]
filter.type <- "HKQuantityTypeIdentifierBodyMass"
filter.source <- "HealthPlanet"
df.weight <- df %>%
    filter(type == filter.type & sourceName == filter.source) %>%
    select(date, value) %>%
    mutate_at(vars(value), as.numeric) %>%
    rename(weight = value) %>%
    mutate(weight.diff = lead(weight) - weight)  # 次回計測時の減少量

# Active energy : アクティブエネルギー [kcal]
filter.type <- "HKQuantityTypeIdentifierActiveEnergyBurned"
filter.source <- "Mi Fit"
df.activeenergy <- df %>%
    filter(type == filter.type & sourceName == filter.source) %>%
    select(date, value) %>%
    mutate_at(vars(value), as.numeric) %>%
    rename(activeenergy = value) %>%
    group_by(date) %>%
    summarise(activeenergy = sum(activeenergy))

# 日付を key にして join
df.join <- df.weight %>%
    merge(df.activeenergy, "date", all = T) %>%
    select(activeenergy, weight.diff)

# Plot
x <- df.join$activeenergy
y <- df.join$weight.diff
x.med <- x %>%
    median(na.rm = TRUE)
y.med <- y %>%
    median(na.rm = TRUE)
y.abs.max <- y %>%
    abs() %>%
    max(na.rm = TRUE)
dev.new()
plot(x, y,
     ylim = c(-y.abs.max, y.abs.max),   # Y 軸の中心を0にする
     main = "Reration of Active energy and next day's Weight",
     xlab = "Active energy [kcal]",
     ylab = "Weight [kg]",
     pch = 16,                          # ●でプロット
     col = ifelse(y > 0,'red','blue'))
abline(h = 0)                           # Y = 0 に線を引く
abline(v = x.med, col = "gray")         # X 軸の中央値線
abline(h = y.med, col = "gray")         # Y 軸の中央値線
abline(lm(y~x), col = "purple")         # 回帰直線
