# apple-health-aggregate
iOS ヘルスケアアプリのデータ解析用 (自分用)  
  
  
![image](https://user-images.githubusercontent.com/1833985/110324194-02a8e580-8059-11eb-8d34-c12fd206cee2.png)


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
http://localhost:8787/
Username: rstudio
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
