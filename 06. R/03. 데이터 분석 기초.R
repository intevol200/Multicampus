### DB 데이터를 csv 파일로 추출하여 사용 ###
emp = read.csv(file = "c:/TEMP/emp.csv")
str(emp)
table(emp$department_id)


exam = read.csv("data/csv_exam.csv")
summary(exam) #요약 통계량
View(exam) #뷰어에서 데이터 보기
table(exam$class)

library(ggplot2)
mpg
str(mpg)
head(mpg,3)
tail(mpg,2)

install.packages("dplyr")
library(dplyr)

df_raw = data.frame(var1=c(1,2,1),
                    var2=c(2,3,1))

#데이터 복사, 한쪽이 바뀌면 다른쪽에 영향 없음
df_new = df_raw

#데이터 값 변경
df_new[1, 'var1'] = 99

#열 이름 변경
df_new = rename(df_new, score = var1)
df_new


df_mpg_original = ggplot2::mpg
dim(df_mpg_original)

df_mpg_new=df_mpg_original

df_mpg_new = rename(df_mpg_new, city = cty, highway=hwy)
colnames(df_mpg_new)

head(df_mpg_new,2)
str(df_mpg_new)
summary(df_mpg_new)


# 파생변수 만들기
df_new$total = df_new$score + df_new$var2
df_new

df_mpg_new$total = (df_mpg_new$city + df_mpg_new$highway)/2
View(df_mpg_new)

#히스토그램으로 표현
hist(df_mpg_new$total)

#조건문으로 판정변수 만들기
df_mpg_new$test = ifelse(df_mpg_new$total >= 20, "pass", "fail")

table(df_mpg_new$test) #도수분포표
qplot(df_mpg_new$test) #막대그래프 빈도


#중첩 조건문
df_mpg_new$grade = ifelse(df_mpg_new$total>=30,"A",
                          ifelse(df_mpg_new$total>=20,"B","C"))

table(df_mpg_new$grade)
qplot(df_mpg_new$grade)


#5장 분석도전
df_mid = ggplot2::midwest
str(df_mid)

df_mid = rename(df_mid, total = poptotal, asian = popasian)
colnames(df_mid)

df_mid$ratio = df_mid$asian/df_mid$total*100
hist(df_mid$ratio)

mean(df_mid$ratio)
df_mid$check = ifelse(df_mid$ratio>mean(df_mid$ratio), "large", "small")

table(df_mid$check)
qplot(df_mid$check)
