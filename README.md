# apple-health-aggregate
![image](https://user-images.githubusercontent.com/1833985/110207480-13c1ed00-7ec7-11eb-8893-e5cfce0e221e.png)  


iOS のヘルスケアアプリのデータ解析用 (自分専用)

# Usage
## iOS からヘルスケアデータをエクスポート
参考：[iPhoneの「ヘルスケア」でヘルスケアおよびフィットネスのデータを共有する - Apple サポート](https://support.apple.com/ja-jp/guide/iphone/iph27f6325b2/ios)

`~/Download` 直下に展開する
```
~/Downloads/apple_health_export/export.xml
```

## R コンソールで実行

### 作業ディレクトリをリポジトリルートに設定
```
> setwd("~/git/apple-health-aggregate")
> getwd()
[1] "/Users/rtakasuke/git/apple-health-aggregate"
```

### 実行
```
> source("R/run.R")
```
or
```
> source("R/prep.R")
> source("R/active-fat.R")
```
