# 8-2 산점도
library(ggplot2)

# x 축 displ, y 축 hwy 로 지정해 배경 생성
ggplot(data = mpg, aes(x = displ, y = hwy))

# 배경에 산점도 추가
ggplot(data = mpg, aes(x=displ, y=hwy)) + 
  geom_point()

ggplot(data = mpg, aes(x=displ, y=hwy)) + 
  geom_point() +
  xlim(3, 6) + #x축 범위 설정
  ylim(10, 30) #y축 범위 설정


#혼자서 해보기
ggplot(data = mpg, aes(x=cty, y=hwy)) + 
  geom_point()

ggplot(data = midwest, aes(x=poptotal, y=popasian)) + 
  geom_point() +
  xlim(0, 500000) +
  ylim(0,10000)



# 8-3 막대그래프
library(dplyr)

mpg = ggplot2::mpg

df_mpg <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + 
  geom_col()

#크기순으로 정렬
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + 
  geom_col()


# 8-4 빈도막대그래프 
# x 축 범주 변수, y 축 빈도
ggplot(data = mpg, aes(x = drv)) + geom_bar()

# x 축 연속 변수, y 축 빈도
ggplot(data = mpg, aes(x = hwy)) + geom_bar()

#혼자서 해보기
df <- mpg %>%
  filter(class == "suv") %>%
  group_by(manufacturer) %>%
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty)) %>%
  head(5)

ggplot(data = df, aes(x = reorder(manufacturer, -mean_cty),
                      y = mean_cty)) + geom_col()

ggplot(data = mpg, aes(x = class)) + geom_bar()

a = sort(table(mpg$class), decreasing = TRUE)
b = names(a)
c = factor(mpg$class, levels = b)

mpg2 = within(mpg, class <- c)
ggplot(data = mpg2, aes(x=class)) + geom_bar()


# 8-4 시계열 그래프
# 시간에 따른 실업률
ggplot(data = economics, aes(x = date, y = unemploy)) + 
  geom_line()

# 시간에 따른 개인 저축률
ggplot(data = economics, aes(x = date, y = psavert)) + 
  geom_line()


# 8-5 상자 그림
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()

class_mpg <- mpg %>%
  filter(class %in% c("compact", "subcompact", "suv"))

ggplot(data = class_mpg, aes(x = class, y = cty)) + geom_boxplot()
