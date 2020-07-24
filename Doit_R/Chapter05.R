#------------ 데이터 파악하기1 ------------# 
exam <- read.csv("csv_exam.csv")
head(exam)

head(exam, 10)

tail(exam)

tail(exam, 10)

View(exam)

dim(exam)

str(exam)

summary(exam)

#------------ 데이터 파악하기2 ------------# 
mpg <- as.data.frame(ggplot2::mpg)    # 데이터 프레임 형태로 불러오기

head(mpg)

tail(mpg)

View(mpg)

dim(mpg)

str(mpg)

summary(mpg)

#------------ 데이터 수정하기 ------------#
install.packages("dplyr")
library(dplyr)

?dplyr

df_raw <- data.frame(var1 = c(1, 2, 1),
                     var2 = c(2, 3, 3))
df_raw

df_new <- df_raw
df_new

df_new <- rename(df_new, v2 = var2)   # dplyr 함수, '새 변수명 = 기존 변수명'
df_new

mpg <- as.data.frame(ggplot2::mpg)
mpg_new <- mpg
mpg_new <- rename(mpg_new, city = cty, highway = hwy)
head(mpg_new)

#------------ 파생변수 만들기 ------------#
df <- data.frame(var1 = c(4, 3, 8),
                 var2 = c(2, 6, 1))
df

df$var_sum <- df$var1 + df$var2
df

df$var_mean <- (df$var1 + df$var2)/2
df

# 각 차량의 연비의 평균 구하기
mpg$total <- (mpg$cty + mpg$hwy) / 2

# 연비의 총 평균 구하기
mean(mpg$total)

summary(mpg$total)
hist(mpg$total)

# 연비에 따른 합겹 불합격 구분
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")
head(mpg, 10)
head(mpg$test,20)


# 합격, 불합격 갯수
table(mpg$test)
qplot(mpg$test)

mpg$grade <- ifelse(mpg$total >= 30, "A",
                    ifelse(mpg$total >= 20, "B", "c"))
head(mpg, 20)
table(mpg$grade)
qplot(mpg$grade)

mpg$grade2 <- ifelse(mpg$total >= 30, "A",
                     ifelse(mpg$total >= 25, "B",
                            ifelse(mpg$total >= 20, "C", "D")))


## 정리하기
### 1.데이터 준비, 패키지 준비
mpg <- as.data.frame(ggplot2::mpg)  # 데이터 불러오기
library(dplyr)                      # dplyr 로드
library(ggplot2)                    # ggplot2 로드

### 2.데이터 파악
head(mpg)     # Raw 데이터 앞부분
tail(mpg)     # Raw 데이터 뒷부분
View(mpg)     # Raw 데이터 뷰어창에서 확인
dim(mpg)      # 차원
str(mpg)      # 속성
summary(mpg)  # 요약 통계량

### 3.변수명 수정
mpg <- rename(mpg, company = manufacturer)

### 4.파생변수 생성
mpg$total <- (mpg$cty + mpg$hwy)/2                    # 변수 조합
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")   # 조건문 활용

### 5.빈도 확인
table(mpg$test)   # 빈도표 출력
qplot(mpg$test)   # 막대 그래프 활용

"
ggplot2 패키지에는 미국 동북중부 437개 지역의 인구통계 정보를 담은 midwest라는 데이터가 포함되어 닜습니다. midwest 데이터를 사용해 데이터 분석 문제를 해결해보세요.
"

# Q1.ggplot2의 midwest 데이터를 데이터 프레임 형태로 불러와서 데이터의 특성을 파악하세요.
midwest <- as.data.frame(ggplot2::midwest)
midwest
head(midwest,5)
tail(midwest,5)
View(midwest)
dim(midwest)
str(midwest)
summary(midwest)

# Q2.poptotal(전체 인구)을 total로, popasian(아시아 인구)을 asian으로 변수명을 수정하세요.
midwest <- rename(midwest, total = poptotal, asian = popasian)
head(midwest, 5)

# Q3.total, asian 변수를 이용해 '전체 인구 대비 아시아 인구 백분율'파생변수를 만들고, 히스토그램을 만들어 도시들이 어떻게 분포하는지 살펴보세요.
midwest$percasian <- (midwest$asian / midwest$total)*100
head(midwest, 5)
hist(midwest$percasian)

# Q4.아시아 인구 백분율 전체 평균을 구하고, 평균을 초과하면 "large", 그 외에는 "small"을 부여하는 파생변수를 만들어 보세요.
mean(midwest$percasian)
midwest$percasiantotal <- ifelse(midwest$percasian > mean(midwest$percasian), "large", "small")
head(midwest, 10)

# Q5."large"와 "small"에 해당하는 지역이 얼마나 되는지, 진도표와 빈도막대그래프로 만들어서 확인해보세요.
table(midwest$percasiantotal)
qplot(midwest$percasiantotal)