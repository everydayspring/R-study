#------------ 데이터 전처리 ------------# 
library(dplyr)
exam <- read.csv("csv_exam.csv")
exam

# [Ctrl+Shit+M]
exam %>% filter(class == 1)
exam %>% filter(class == 2)
exam %>% filter(class != 1)
exam %>% filter(class != 3)

exam %>% filter(math > 50)
exam %>% filter(English < 80)

exam %>% filter(class == 1 & math >= 50)
exam %>% filter(math >= 90 | English >=90)

exam %>% filter(class == 1 | class == 3| class == 5)
exam %>% filter(class %in% c(1,3,5))


# 추출한 행으로 데이터 만들기
class1 <- exam %>% filter(class == 1)
class2 <- exam %>% filter(class == 2)

mean(class1$math)
mean(class2$math)

#------------ 실습 ------------# 

"
Q1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다. 
    displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 
    어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 알아보세요.
"
mpg <- as.data.frame(ggplot2::mpg)
mpg

mpg_1 <- mpg %>% filter(displ <= 4)
mpg_2 <- mpg %>% filter(displ > 5)
mean(mpg_1$hwy)
mean(mpg_2$hwy)

"
Q2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 합니다.
    \"audi\"와 \"toyota\" 중 어느 manufacturer(자동차 제조 회사)의 
    cty(도시 연비)가 평균적으로 더 높은지 알아보세요.
"
mpg_audi <- mpg %>% filter(manufacturer == "audi")
mpg_toyota <- mpg %>% filter(manufacturer == "toyota")
mean(mpg_audi$cty)
mean(mpg_toyota$cty)

mean((mpg %>% filter(manufacturer == "audi"))$cty)

"
Q3. \"chevrolet\",\"ford\",\"honda\"자동타의 고속도로 연비 평균을 알아보려고 합니다.
    이 회사들의 자동차를 추출한 뒤 hwy 전체 평균을 구해보세요.
"
mpg_3 <- mpg %>% filter(manufacturer %in% c("chevrolet","ford","honda"))
mean(mpg_3$hwy)


#------------ 필요한 변수만 추출하기 ------------# 
exam %>% select(math)
exam %>% select(math, english)

exam %>% select(-math)
exam %>% select(-math, -english)

exam %>% filter(class == 1) %>% select(english)
exam %>%
  filter(class == 1) %>% 
  select(english)

exam %>%
  select(id, math) %>%
  head(10)

#------------ 실습 ------------# 

'
Q1. mpg데이터는 11개 변수로 구성되어 있습니다. 
    이 중 일부만 추출해서 분석에 활용하려고 합니다. 
    mpg 데이터에서 class(자동차 종류), cty(도시 연비) 변수를 추출해 새로운 데이터를 만드세요. 
    새로 만든 데이터의 일부를 출력해서 두 변수로만 구성되어 있는지 확인하세요.
'
mpg_sub <- mpg %>% 
  select(class, cty)
head(mpg_sub)
dim(mpg_sub)

'
Q2. 자동차 종류에 따라 도시 연비가 다른지 알아보려고 합니다. 
    앞에서 추출한 데이터를 이용해서 class(자동차 종류)가 
    "suv"인 자동차와 "compact"인 자동차 중 어떤 자동차의 cty(도시 연비)가 더 높은지 알아보세요.
'
mpg_suv <- mpg_sub %>% filter(class == "suv")
mpg_compact <- mpg_sub %>% filter(class == "compact")
mean(mpg_suv$cty)
mean(mpg_compact$cty)

#------------ 순서대로 정렬하기 ------------# 

exam %>% arrange(math)		# math 오름차순 정렬
exam %>% arrange(desc(math))	# descend

exam %>% arrange(class, math)


#------------ 실습 ------------# 

# "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 합니다.
# "audi"에서 생산한 자동차 중 hwy가 1 ~ 5위에 해당하는 자동차의 데이터를 출력하세요.
mpg_audi %>% 
  arrange(desc(hwy)) %>% 
  head(5)

#------------ 새로운 변수 추가하기 ------------# 
exam %>%
  mutate(total = math + english + science) %>%
  head

exam %>%
  mutate(total = math + english + science,
         mean = (math + english + science)/3) %>%
  head

exam %>%
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>%
  head

exam %>%
  mutate(total = math + english + science) %>%
  arrange(total) %>%
  head


#------------ 실습 ------------#

# Q1. mpg데이터 복사본을 만들고, cty와 hwy를 더한 '합산 연비 변수'를 추가하세요.
mpg_new <- as.data.frame(ggplot2::mpg)
mpg_new <- mpg_new %>% 
  mutate(total = cty + hwy)

# Q2. 앞에서 만든 '합산 연비 변수'를 2 로 나눠 '평균 연비 변수'를 추가하세요.
mpg_new <- mpg_new %>% 
  mutate(mean = total/2)

# Q3. '평균 연비 변수'가 가장 높은 자동차를 3 종의 데이터를 출력하세요.
mpg_new %>%  
  arrange(desc(mean)) %>% 
  head(3)

# Q4. 1~3번 문제를 해결할 수 있는 하나로 연결된 dplyr 구문을 만들어 출력하세요 
# 데이터는 복사본 대신 mpg원본을 이용하세요.
mpg %>% 
  mutate(total = cty+hwy,
         mean = total/2) %>% 
  arrange(desc(mean)) %>% 
  head(3)


#------------ 집단별로 요약하기 ------------#

exam %>% summarise(mean_math = mean(math))

exam %>%
  group_by(class) %>%
  summarise(mean_math = mean(math))

exam %>%
  group_by(class) %>%
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            median_math = median(math),
            n = n())

mpg %>%
  group_by(manufacturer, drv) %>%
  summarise(mean_cty = mean(cty)) %>%
  head(10)

"
- dplyr 조합하기
회사별로 \"suv\" 자동차의 도시 및 고속도로 통합 연비 평균을 구해 내림차순으로 정렬하고, 1~5위까지 출력하기
  | 절차 | 기능 | dplyr 함수 |
  | 1 | 회사별로 분리 | group_by() |
  | 2 | suv 추출 | filter() |
  | 3 | 통합 연비 변수 생성 | mutate() |
  | 4 | 통합 연비 평균 산출 | summarise() |
  | 5 | 내림차순 정렬 | arrange() |
  | 6 | 1~5위까지 출력 | head() |
"
mpg <- as.data.frame(ggplot2::mpg)
mpg

mpg %>% 
  group_by(manufacturer) %>% 
  filter(class == "suv") %>% 
  mutate(total = cty+hwy) %>% 
  summarise(mean = mean(total)) %>% 
  arrange(desc(mean)) %>% 
  head()



#------------ 실습 ------------#

# Q1. mpg 데이터의 class는 "suv","compact"등 자동차를 특징에 따라 일곱 종류로 분류한 변수입니다. 
#     어떤 차종의 연비가 높은지 비교해보려고 합니다. class별 cty평균을 구해보세요.
mpg %>% 
  group_by(class) %>% 
  summarise(mean_cty = mean(cty))

# Q2. 앞 문제의 출력 결과는 class값 알파벳 순으로 정렬되어 있습니다. 
#     어떤 차종의 도시 연비가 높은지 쉽게 알아볼 수 있도록 cty평균이 높은 순으로 정렬해 출력하세요.
mpg %>% 
  group_by(class) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty))

# Q3. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려고 합니다. 
#     hwy 평균이 가장 높은 회사 세 곳을 출력하세요.
mpg %>% 
  group_by(manufacturer) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(3)

# Q4. 어떤 회사에서 "compact"(경차) 차종을 가장 많이 생산하는지 알아보려고 위해 
#     각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.
mpg %>% 
  filter(class == "compact") %>% 
  group_by(manufacturer) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n))


#------------ 데이터 합치기 ------------#

#------------ 가로로 합치기 ------------#

test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterm = c(60, 80, 70, 90, 85))

test2 <- data.frame(id = c(1, 2, 3, 4, 5),
                    final = c(70, 83, 65, 95, 80))

total <- left_join(test1, test2, by = "id")
total

name <- data.frame(class = c(1, 2, 3, 4, 5),
                   teacher = c("kim", "lee", "park", "choi", "jung"))
name

exam_new <- left_join(exam, name, by = "class")
exam_new


#------------ 세로로 합치기 ------------#

group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(60, 80, 70, 90, 85))
group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))

group_all <- bind_rows(group_a, group_b)
group_all


#------------ 실습 ------------#
"
mpg 데이터의 fl변수는 자동차에 사용하는 연료(fuel)를 의미합니다. 
아래는 자동차 연료별 가격을 나타낸 표입니다.
  | fl | 연료 종류   | 가격(갤런당 USD) |
  
  | c  | CNG         | 2.35             |
  | d  | diesel      | 2.38             |
  | e  | ethanol E85 | 2.11             |
  | p  | premium     | 2.76             |
  | r  | regular     | 2.22             |
"

fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F)
fuel
# Q1. mpg데이터에는 연료 종류를 나타낸 fl 변수는 있지만 연료 가격을 나타낸 변수는 없습니다.
#     위에서 만든 fuel 데이터를 이용해서 mpg데이터에 price_fl(연료 가격) 변수를 추가하세요.
mpg <- left_join(mpg, fuel, by="fl")
mpg

# Q2. 연료 가격 변수가 잘 추가됐는지 확인하기 위해서 
#     model, fl, price_fl 변수를 추출해 앞부분 5 행을 출력해 보세요.
mpg %>% 
  select(model, fl, price_fl) %>% 
  head(5)

#------------ 정리하기 ------------#

# 1.조건에 맞는 데이터만 추출하기
exam %>% filter(english >= 80)

# 여러 조건 동시 충족
exam %>% filter(class == 1 & math >= 50)

# 여러 조건 중 하나 이상 충족
exam %>% filter(math >= 90 | english >= 90)
exam %>% filter(class %in% c(1,3,5))

# 2.필요한 변수만 추출하기
exam %>% select(math)
exam %>% select(class, math, english)

# 3.함수 조합하기, 일부만 출력하기
exam %>% 
  select(id, math) %>% 
  head(10)

# 4.순서대로 정렬하기
exam %>% arrange(math)
exam %>% arrange(desc(math))
exam %>% arrange(class, math)

# 5.파생변수 추가하기
exam %>% mutate(total = math, english, science)

# 여러 파생변수 한 번에 추가하기
exam %>% 
  mutate(total = math + english + science,
         mean = total/3)

# mutate()에 ifelse() 적용하기
exam %>% mutate(test = ifelse(science >= 60, "pass", "fail"))

# 추가한 변수를 dplyr 코드에 바로 활용하기
exam %>% 
  mutate(total = math + english + science) %>% 
  arrange(total)

# 6.집단별로 요약하기
exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))

# 각 집단별로 다시 집단 나누기
mpg %>% 
  group_by(manufacturer, drv) %>% 
  summarise(mean_cty = mean(cty))

# 7.데이터 합치기
# 가로로 합치기
total <- left_join(test1, test2, by = "id")

# 세로로 합치기
group_all <- bind_rows(group_a, group_b)

#------------ 실습 ------------#
"
미국 동북중부 437개 지역의 인구통계 정보를 담고 있는 
midwest 데이터를 사용해 데이터 분석 문제를 해결해 보세요. 
midwest는 ggplot2패키지에 들어 있습니다.
"


# 문제1. popadults는 해당 지역의 성인 인구, poptotal은 전체 인구를 나타냅니다. 
#         midwest데이터에 '전체 인구 대비 미성년 인구 백분율' 변수를 추가하세요.
midwest <- as.data.frame(ggplot2::midwest)
midwest

midwest %>% 
  select(popadults, poptotal)

midwest <- midwest %>% 
  mutate(percchild = ((poptotal-popadults)/poptotal)*100)

# 문제2. 미성년 인구 백분율이 가장 높은 상위 5개 county(지역)의 미성년 인구 백분율을 출력하세요.
midwest %>%
  select(county, percchild) %>% 
  arrange(desc(percchild)) %>% 
  head(5)

"
  문제3. 분류표의 기준에 따라 미성년 비율 등급 변수를 추가하고, 각 등급에 몇 개의 지역이 있는지 알아보세요.
  | 분류 | 기준 | 
  
  | large | 40% 이상 |
  | middle | 30% ~ 40% 미만 |
  | small | 30% 미만 |
"
midwest <- midwest %>% 
  mutate(gradechild = ifelse(percchild >= 40, "large",
                             ifelse(percchild >=30, "middle", "small")))
table(midwest$gradechild)

# 문제4. popasian은 해당 지역의 아시아인 인구를 나타냅니다. 
# '전체 인구 대비 아시아인 백분율' 변수를 만들고 
# state, county, 아시아인 백분율을 출력하세요.

midwest <- midwest %>% 
  mutate(percasian = (popasian/poptotal)*100) %>% 
  select(state, county, percasian)

midwest