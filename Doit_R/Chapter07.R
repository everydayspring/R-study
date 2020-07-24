#------------ 결측치 만들기 ------------#
df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA))
df

#------------ 결측치 확인하기 ------------#
is.na(df)

table(is.na(df))

#------------ 변수별로 결측치 확인하기 ------------#
table(is.na(df$sex))

table(is.na(df$score))

#------------ 결측치 포함된 상태로 분석 ------------#
mean(df$sex)
mean(df$score)

#------------ 결측치 있는 행 제거하기 ------------#
library(dplyr)
df %>% filter(is.na(score))

df %>% filter(!is.na(score))

#------------ 결측치 제외한 데이터로 분석하기 ------------#
df_nomiss <- df %>% filter(!is.na(score))
df_nomiss
mean(df_nomiss$score)
sum(df_nomiss$score)

#------------ 여러 변수 동시에 결측치 없는 데이터 추출하기 ------------#
df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))
df_nomiss

#------------ 결측치가 하나라도 있으면 제거하기 ------------#
df_nomiss2 <- na.omit(df)
df_nomiss2

#------------ 함수의 결측치 제외 기능 이용하기 ------------#
mean(df$score, na.rm = T)
sum(df$score, na.rm = T)

getwd()
setwd("C:/Users/multicampus/Documents/R/R_github_repository/Data")

exam <- read.csv("csv_exam.csv")
exam[c(3, 8, 15), "math"] <- NA
exam

exam %>% summarise(mean_math = mean(math))
exam %>% summarise(mean_math = mean(math, na.rm = T))

#------------ 다른 함수들에 적용 ------------#
exam %>% summarise(mean_math = mean(math, na.rm = T),
                   sum_math = sum(math, na.rm = T),
                   median_math = median(math, na.rm = T))

#------------ 평균값으로 결측치 대체하기 ------------#
mean(exam$math, na.rm = T)
exam$math <- ifelse(is.na(exam$math), 55, exam$math)
table(is.na(exam$math))

#------------ 실습 ------------#
mpg <- as.data.frame(ggplot2::mpg)
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA

# Q1. drv(구동방식)별로 hwy(고속도로 연비) 평균이 어떻게 다른지 알	  아보려고 합니다. 분석을 하기 전에 우선 두 변수에 결측치가 있는지 확인해야 합니다. dvr 변수와 hwy 변수에 결측치가 몇 개 있는지 알아보세요.
table(is.na(mpg$drv))
table(is.na(mpg$hwy))

# Q2. filter()를 이용해 hwy 변수의 결측치를 제외하고, 어떤 구동방식의 hwy 평균이 높은지 알아보세요. 하나의 dplyr 구문으로 만들어야 합니다.
mpg %>% 
  filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))

#------------ 이상치 제거하기 ------------#
outlier <- data.frame(sex = c(1,2,1,3,2,1),
                      score = c(5,4,3,4,2,6))
outlier

' 이상치 확인하기 '
table(outlier$sex)
table(outlier$score)

' 결측 처리하기 '
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier

install.packages("dplyr")
library(dplyr)

outlier %>% 
  filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))

#------------ 상자 그림으로 극단치 기준 정하기 ------------#
install.packages("ggplot2")
library(ggplot2)

mpg <- as.data.frame(ggplot2::mpg)
boxplot(mpg$hwy)

'  상자 그림 통계치 출력  '
boxplot(mpg$hwy)$stats

'  결측 처리하기  '
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T))

#------------ 실습 ------------#
mpg <- as.data.frame(ggplot2::mpg)
mpg[c(10, 14, 58, 93), "drv"] <- "k"
mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42)

'
Q1. drv에 이상치가 있는지 확인하세요.
  이상치를 결측 처리한 후 이상치가 사라졌는지 확인하세요.
  결측 처리를 할 때는 %in% 기호를 활용하세요.
'
mpg$drv <- ifelse(mpg$drv %in% c("4","f","r"), mpg$drv, NA)
table(mpg$drv)

'
Q2. 상자 그림을 이용해 cty에 이상치가 있는지 확인하세요.
  상자 그림의 통계치를 이용해 정상 범위를 벗어난 값을 결측 처리한 후 
  다시 상자 그림을 만들어 이상치가 사라졌는지 확인하세요.
'
boxplot(mpg$cty)$stats
mpg$cty <- ifelse(mpg$cty < 9 | mpg$cty > 26, NA, mpg$cty)
table(is.na(mpg$cty))
boxplot(mpg$cty)

'
Q3. 두 변수의 이상치를 결측 처리 했으니 이제 분석할 차례입니다.
  이상치를 제외한 다음 drv별로 cty 평균이 어떻게 다른지 알아보세요.
  하나의 dplyr 구문으로 만들어야 합니다.
'
mpg %>%
  filter(!is.na(drv) & !is.na(cty)) %>% 
  group_by(drv) %>% 
  summarise(mean_cty = mean(cty))

#------------ 정리하기 ------------#
'  1.결측치 정제하기  '
'  결측치 확인  '
table(is.na(df$score))

'  결측치 제거  '
df_nomiss <- df %>% filter(!is.na(score))

'  여러 변수 동시에 결측치 제거  '
df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))

'  함수의 결측치 제외 기능 이용하기  '
mean(df$score, na.rm = T)
exam %>% summarise(mean_math = mean(math, na.rm = T))

'  2.이상치 제거하기  '
'  이상치 확인  '
table(outlier$sex)

'  결측 처리  '
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)

'  boxplot으로 극단치 기준 찾기  '
boxplot(mpg$hwy)$stats

'  극단치 결측 처리  '
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)