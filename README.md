![Lint](https://github.com/rtakasuke/apple-health-aggregate/workflows/Lint/badge.svg)

# apple-health-aggregate
iPhone ヘルスケアデータ解析用 (自分用)  
  
  
![image](https://user-images.githubusercontent.com/1833985/110993843-2fdbf780-83bb-11eb-9427-dc10e3f5d4ea.png)


# Usage
## iPhone のヘルスケアデータをエクスポート
参考：[iPhoneの「ヘルスケア」でヘルスケアおよびフィットネスのデータを共有する - Apple サポート](https://support.apple.com/ja-jp/guide/iphone/iph27f6325b2/ios)

展開して `data` 直下に配置する

```
data
└── apple_health_export
    └── export.xml
```

## R 実行環境をセットアップ

### R.app を使う場合
作業ディレクトリをリポジトリルートに設定
```
> setwd("~/git/apple-health-aggregate")
> getwd()
[1] "/Users/rtakasuke/git/apple-health-aggregate"
```

### コンテナ上で RStudio Server を使う場合
コンテナ起動
```
> docker-compose build
> docker-compose up -d
```

ブラウザから UI にアクセス
 - http://localhost:8787/<br>
 - Username: rstudio<br>
 - Password: MY_PASSWORD


## コンソールでコマンド実行
```
> source("R/extract-df.R")
> source("R/active-fat.R")
```
