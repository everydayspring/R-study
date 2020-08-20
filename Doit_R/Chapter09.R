#------------ 데이터 분석 프로젝트 '한국인의 삶을 파악하라' ------------#
#------------ '한국복지패널데이터' 분석 준비하기 ------------#
# 데이터 준비하기
# 패키지 설치 및 로드하기
install.packages("foreign")   # foreign 패키지 설치

library(foreign)              # SPSS 파일 불러오기
library(dplyr)                # 전처리
library(ggplot2)              # 시각화
library(readxl)               # 엑셀 파일 불러오기

# 데이터 불러오기
getwd()

raw_welfare <- read.spss(file = "Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = T)

welfare <- raw_welfare

# 데이터 검토하기 
head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)

# 변수명 바꾸기
welfare <- rename(welfare,
                  sex = h10_g3,             # 성별
                  birth = h10_g4,           # 태어난 연도
                  marriage = h10_g10,       # 혼인 상태
                  religion = h10_g11,       # 종교
                  income = p1002_8aq1,      # 월급
                  code_job = h10_eco9,      # 직업 코드
                  code_region = h10_reg7)   # 지역 코드

#------------ 성별에 따른 월급 차이 ------------#
#------------ 성별 변수 검토 및 전처리 ------------#
# 변수 검토하기
class(welfare$sex)
table(welfare$sex)

# 전처리
' 이상치 확인 '
table(welfare$sex)
' 이상치 결측 처리 '
welfare$sex <- ifelse(welfare$sex == 9, NA, welfare$sex)
' 결측치 확인 '
table(is.na(welfare$sex))
' 성별 항목 이름 부여 '
welfare$sex <- ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)
qplot(welfare$sex)

#------------ 월급 변수 검토 및 전처리 ------------#
# 변수 검토하기
class(welfare$income)
summary(welfare$income)
qplot(welfare$income) + xlim(0, 1000)

# 전처리
' 이상치 확인 '
summary(welfare$income)
' 이상치 결측 처리 '
welfare$income <- ifelse(welfare$income %in% c(0, 9999), NA, welfare$income)
' 결측치 확인 '
table(is.na(welfare$income))

#------------ 성별에 따른 월급 차이 분석하기 ------------#
# 성별 월급 평균표 만들기
sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(mean_income = mean(income))

sex_income
# 그래프 만들기
ggplot(data = sex_income, aes(x = sex, y = mean_income)) + geom_col()
