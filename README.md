![Lint](https://github.com/rtakasuke/apple-health-aggregate/workflows/Lint/badge.svg)

# apple-health-aggregate
iPhone ヘルスケアデータ解析用 (自分用)  
  
  
![image](https://user-images.githubusercontent.com/1833985/110990110-361ba500-83b6-11eb-83ac-1a581f880779.png)


# Usage
## iPhone のヘルスケアデータをエクスポート
参考：[iPhoneの「ヘルスケア」でヘルスケアおよびフィットネスのデータを共有する - Apple サポート](https://support.apple.com/ja-jp/guide/iphone/iph27f6325b2/ios)

展開して `data` 直下に配置する

```
data
└── apple_health_export
    └── export.xml
```

## コンテナ起動
```
> docker-compose build
> docker-compose up -d
```

## ブラウザから UI にアクセス
http://localhost:8787/<br>
Username: rstudio<br>
Password: MY_PASSWORD


## R コンソールでコマンド実行
```
> source("R/run.R")
```
or
```
> source("R/init.R")
> source("R/active-fat-df.R")
> source("R/active-fat-plot.R")
```
