#------------ R로 만들 수 있는 그래프 살펴보기 ------------#
install.packages("ggplot2")
library(ggplot2)

#------------ 산점도 - 변수 간 관계 표현하기 ------------#
'  x축 y축 지정  '
ggplot(data = mpg, aes(x = displ, y = hwy))

'  배경에 산점도 추가  '
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

'  축 범위 지정  '
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6)

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlim(3, 6) +
  ylim(10, 30)

#------------ 실습 ------------#
'
Q1. mpg 데이터의 cty(도시 연비)와 hwy(고속도로 연비) 간에 
  어떤 관계가 있는지 알아보려고 합니다.
  x축은 cty, y축은 hwy로 된 산점도를 만들어보세요.
'
ggplot(data = mpg, aes(x = cty, y = hwy)) +
  geom_point()

'
Q2. 미국 지역별 인구통계 정보를 담은 ggplot2 패키지의 midwest 데이터를 이용해
  전체 인구와 아시아인 인구 간에 어떤 관계가 있는지 알아보려고 합니다.
  x축은 poptotal(전체 인구), y축은 popasian(아시아인 인구)으로 구성된 산점도를 만들어 보세요.
  전체 인구는 50만 명 이하, 아시아인 인구는 1만 명 이하인 지역만 산점도에 표시되게 설정하세요.
'
ggplot(data = midwest, aes(x = poptotal, y = popasian)) +
  geom_point() + 
  xlim(0, 500000) +
  ylim(0, 10000)

#------------ 막대 그래프 - 집단 간 차이 표현하기 ------------#
install.packages("dplyr")
library(dplyr)

mpg <- as.data.frame(ggplot2::mpg)

'  집단별 평균표 만들기  '
df_mpg <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))

df_mpg

'  그래프 생성하기  '
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()

'  크기 순으로 정렬하기  '
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()

'  빈도 막대 그래프 만들기  '
ggplot(data = mpg, aes(x = drv)) + geom_bar()

ggplot(data = mpg, aes(x = hwy)) + geom_bar()

#------------ 실습 ------------#
'
Q1. 어떤 회사에서 생산한 "suv" 차종의 도시 연비가 높은지 알아보려고 합니다.
  "suv"차종을 대상으로 평균 cty(도시 연비)가 가장 높은 회사 다섯 곳을 막대 그래프로 표현해 보세요.
  막대는 연비가 높은 순으로 정렬하세요.
'
mpg %>% head()

df_mpg <- mpg %>% 
  filter(class == "suv") %>% 
  group_by(manufacturer) %>% 
  summarise(cty_mean = mean(cty)) %>% 
  arrange(desc(cty_mean)) %>% 
  head(5)


ggplot(data = df_mpg, aes(x = reorder(manufacturer, -cty_mean), y = cty_mean)) + geom_col()


'
Q2. 자동차 중에서 어떤 class(자동차 종류)가 가장 많은지 알아보려고 합니다.
  자동차 종류별 빈도를 표현한 막대 그래프를 만들어 보세요.
'
ggplot(data = mpg, aes(x=class))+geom_bar()

#------------ 선 그래프 - 시간에 따라 달라지는 데이터 표현하기 ------------#
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

#------------ 실습 ------------#
'
Q1. psavert(개인 저축률)가 시간에 따라 어떻게 변해 왔는지 알아보려고 합니다.
    시간에 따른 개인 저축률의 변화를 나타낸 시계열 그래프를 만들어보세요.
'
ggplot(data = economics, aes(x = date, y = psavert)) + geom_line()

#------------ 상자 그림 - 집단 간 분포 차이 표현하기 ------------#
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()

#------------ 실습 ------------#
'
Q1. class(자동차 종류)가 "compact", "subcompact", "suv"인 자동차의 
    cty(도시 연비)가 어떻게 다른지 비교해 보려고 합니다.
    세 차종의 cty를 나타낸 상자 그림을 만들어 보세요.
'
df_mpg <- mpg %>% 
            filter(class %in% c("compact", "subcompact", "suv"))

ggplot(data = df_mpg, aes(x = class, y = cty)) + geom_boxplot()

#------------ 정리하기 ------------#
'  1. 산점도  '
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

'  축 설정 추가  '
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() +
  xlim(3,6) +
  ylim(10,30)

'  2. 평균 막대 그래프  '
'  1단계. 평균표 만들기  '
df_mpg <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))


'  2단계. 그래프 생성하기, 크기순 정렬하기  '
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()


'  3. 빈도 막대 그래프  '
ggplot(data = mpg, aes(x = drv)) + geom_bar()


'  4. 선 그래프  '
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()


'  5. 상자 그림  '
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()
