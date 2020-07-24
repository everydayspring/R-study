#------------ 데이터 프레임 ------------# 
english <- c(90, 80, 60, 70)
english

math <- c(50, 60, 100, 20)
math

class <- c(1, 1, 2, 2)
class

df_midterm <- data.frame(english, math, class)
df_midterm

mean(df_midterm$english)
mean(df_midterm$math)

df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm

#------------ 외부 데이터 가져오기 ------------# 
install.packages("readxl")
library(readxl)

getwd()     # 웨킹 디렉토리 확인
setwd("C:/Users/multicampus/Documents/R/workspace/data")

df_exam <- read_excel("excel_exam.xlsx")
df_exam

mean(df_exam$english)
mean(df_exam$science)

df_exam_novar <- read_excel("excel_exam_novar.xlsx", col_names = F)
df_exam_novar

df_exam_sheet <- read_excel("excel_exam_sheet.xlsx", sheet = 3)
df_exam_sheet

df_csv_exam <- read.csv("csv_exam.csv")
df_csv_exam <- read.csv("csv_exam.csv", stringsAsFactors = F)
df_csv_exam

#------------ 데이터 내보내기 ------------# 
df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm

write.csv(df_midterm, file = "df_midterm.csv")

#------------ RData 파일 활용하기 ------------#

save(df_midterm, file = "df_midterm.rda")

rm(df_midterm)

df_midterm

load("df_midterm.rda")

df_midterm

# 변수에 할당
df_exam <- read_excel("excel_exam.xlsx")
df_csv_exam <- read.csv("csv_exam.csv")
# Rda 파일 : 데이터 프레임 자동 생성
load("df_midterm.rda")