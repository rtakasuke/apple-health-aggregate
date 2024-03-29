# iOS ヘルスケアデータの DF を生成

# Generate source DF from XML file
xml <- xmlParse("data/apple_health_export/export.xml")
df <- XML:::xmlAttrsToDataFrame(xml["//Record"], stringsAsFactors = FALSE)
df %>%
    summary() %>%
    print()

# date
df$date <- df$startDate %>%
    str_extract_all("\\d{4}-\\d{2}-\\d{2}") %>%
    ymd(tz = "Japan") %>%
    date()

# lifedate : 夜ふかしを考慮して 5:00 に日付変更 (for Active energy)
df$lifedate <- df$startDate %>%
    str_extract_all("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}") %>%
    ymd_hms(tz = "Japan") - hours(5)
df$lifedate <- df$lifedate %>%
    date()

# print summary info of DF
df.summary <- df %>%
    select(sourceName, type) %>%
    group_by(sourceName, type) %>%
    summarise(count = n()) %>%
    print()
