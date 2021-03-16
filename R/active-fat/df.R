# 運動量と翌日の体脂肪増減の関係を解析するための DF を生成

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

df.activeenergy.dates <- df.activeenergy %>%
    select(date)

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
# 体組成計は乗り忘れがち. 翌日減少量を計算するために Active energy の日付を join
df.bodyfat <- df.activeenergy.dates %>%
    merge(df.bodyfat.rate, "date", all = T) %>%
    merge(df.weight, "date", all = T) %>%
    group_by(date) %>%
    summarise(bodyfat = bodyfat.rate * weight) %>%
    mutate(bodyfat.diff = lead(bodyfat) - bodyfat)  # 翌日減少量

# 日付を key にして join
df.join <- df.bodyfat %>%
    merge(df.activeenergy, "date", all = T) %>%
    select(date, activeenergy, bodyfat.diff)
