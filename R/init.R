packages <- c("tidyverse", # 便利パッケージコレクション
              "dplyr",     # データフレーム操作用
              "magrittr",  # パイプ演算子が使える
              "lubridate", # 日付時刻処理
              "XML")
install.packages(setdiff(packages, rownames(installed.packages())))
for(package in packages)
    library(package, character.only = T)

