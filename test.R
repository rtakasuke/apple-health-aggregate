packages <- c("XML", "lubridate", "tidyverse", "magrittr", "dplyr", "zoo", "xts")

install.packages(setdiff(packages, rownames(installed.packages())))
for(package in packages) library(package, character.only = T)


# generate main DF from XML file
xml <- xmlParse("~/Downloads/apple_health_export/export.xml")
df <- XML:::xmlAttrsToDataFrame(xml["//Record"], stringsAsFactors = FALSE)
df$date <- str_extract_all(df$startDate, "\\d{4}-\\d{2}-\\d{2}") %>% unlist() %>% as.Date()


# print summary of DF
dfTypes <- df %>% subset(TRUE, c(sourceName, type))
print(unique(dfTypes))
print(head(df, 10))


# Weight
dfWeight <- subset(df, df$type=="HKQuantityTypeIdentifierBodyMass" & df$sourceName=="HealthPlanet", c(date, value))
dfWeight$value <- as.numeric(dfWeight$value)
colnames(dfWeight) <- c("date","Weight")


# Body Fat
dfBodyFat <- subset(df, df$type=="HKQuantityTypeIdentifierBodyFatPercentage" & df$sourceName=="HealthPlanet", c(date, value))
dfBodyFat$value <- as.numeric(dfBodyFat$value) * 100
colnames(dfBodyFat) <- c("date","BodyFat")


# ActiveEnergy
dfActiveEnergyTemp <- subset(df, df$type=="HKQuantityTypeIdentifierActiveEnergyBurned" & df$sourceName=="Mi Fit", c(date, value))
dfActiveEnergyTemp$ActiveEnergy <- as.numeric(dfActiveEnergyTemp$value)
dfActiveEnergy <- dfActiveEnergyTemp %>% group_by(date) %>% summarise(ActiveEnergy = sum(ActiveEnergy))


# join
dfJoin <- dfWeight %>%
          merge(dfBodyFat, "date", all=T) %>%
          merge(dfActiveEnergy, "date", all=T)

xtsJoin <- read.zoo(dfJoin, index.column = 1) %>% as.xts()
plot(xtsJoin)

