packages <- c("tidyverse", # 便利パッケージコレクション
              "dplyr",     # データフレーム操作用
              "magrittr",  # パイプ演算子が使える
              "lubridate", # 日付時刻処理
              "XML")
install.packages(setdiff(packages, rownames(installed.packages())))
for(package in packages)
    library(package, character.only = T)

# Generate source DF from XML file
xml <- xmlParse("~/Downloads/apple_health_export/export.xml")
df <- XML:::xmlAttrsToDataFrame(xml["//Record"], stringsAsFactors = FALSE)
df %>%
    summary() %>%
    print()
df$date <- df$startDate %>%
    str_extract_all("\\d{4}-\\d{2}-\\d{2}") %>%
    unlist() %>%
    as.Date()

df.summary <- df %>%
    select(sourceName, type) %>%
    group_by(sourceName, type) %>%
    summarise(count = n()) %>%
    print()
