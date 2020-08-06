#6-2 조건에 맞는 데이터만 추출하기
library(dplyr)
exam <-  read.csv("data/csv_exam.csv")
colnames(exam)

exam[exam$class==1,]
exam %>% filter(class==1)

emp=read.csv("c:/TEMP/emp.csv")
str(emp)

table(emp$department_id)      

emp %>% filter(department_id==50)
emp %>% filter(salary>=15000)


#여러 조건을 충족하는 행 추출
emp %>% filter(department_id==10 | department_id==20)
emp %>% filter(department_id==20 & salary > 10000)

emp %>% filter(department_id %in% c(10,20))
exam %>% filter(class %in% c(1,2,3))


#추출한 행으로 데이터 만들기
df1 = exam %>% filter(class==1)
df2 = exam %>% filter(class==2)

mean1 = mean(df1$math)
mean2 = mean(df2$math)

ifelse(mean1>mean2, "1반이 승리",
       ifelse(mean1==mean2, "동점", "2반이 승리"))


emp50 = emp %>% filter(department_id == 50)
emp80 = emp %>% filter(department_id == 80)
mean1 = mean(emp50$salary)
mean2 = mean(emp80$salary)

ifelse(mean1>mean2, paste(round(mean1,2), ": 50부서가 높다"),
       ifelse(mean1==mean2, "동점", paste(round(mean2,2), ": 80부서가 높다")))



df_emp = read.csv("C:/TEMP/emp.csv")
df_dept = read.csv("c:/TEMP/dept.csv")
str(df_emp)
str(df_dept)

table(df_dept$department_id)
colnames(df_emp)

install.packages("stringr")
library(stringr)

str_trim(df_emp$JOB_ID, c("both"))

df_emp %>% filter(str_trim(JOB_ID)=='IT_PROG')
df_emp %>% filter(str_trim(FIRST_NAME)=='Alexander')

df_emp %>% filter(str_trim(JOB_ID)=='IT_PROG' &
                    SALARY >= 5000)


#혼자서 해보기
df_find = ggplot2::mpg

dis4 = df_find %>% filter(displ <= 4)
dis5 = df_find %>% filter(displ >= 5)

m1 = mean(dis4$hwy)
m2 = mean(dis5$hwy)

ifelse(m1>m2,"4가 더 크다",
       ifelse(m1==m2, "같다", "5가 더 크다"))


audi = df_find %>% filter(manufacturer == "audi")
toyo = df_find %>% filter(manufacturer == "toyota")

am = mean(audi$cty)
tm = mean(toyo$cty)

ifelse(am>tm, paste(round(am, 2), ": audi better"), 
       ifelse(am==tm, "same", paste(round(tm,2), ": toyota better")))


hwyme = df_find %>% filter(manufacturer %in% c("chevrolet", "ford", "honda"))
mean(hwyme$hwy)


#6-3 필요한 변수만 추출하기
df2 = df_emp %>% filter(DEPARTMENT_ID %in% c(60,80,90)
                        %>%  select(FIRST_NAME, SALARY):df2)
mean(df2$SALARY)


View(df_mpg)
df_mpg = ggplot2::mpg
mpg3 = df_mpg %>% filter(manufacturer %in% 
                           c("chevrolet", "ford", "honda")) %>% 
                  select(manufacturer, hwy, cty)

exam %>% filter(class %in% c(1,2)) %>% 
         select(class, math, english) %>% head

#혼자서 해보기
nmpg = ggplot2::mpg

df = nmpg %>% select(class, cty)
head(df)


df_suv = df %>%  filter(class=="suv") %>% select(cty)
df_compact = df %>% filter(class=="compact")

mean(df_suv$cty)
mean(df_compact$cty)


#6-4 순서대로 정렬하기
df = ggplot2::mpg
df %>%  filter(class=="suv") %>% 
        arrange(year, displ)

df %>%  filter(class=="suv") %>% 
  arrange(desc(year), displ)

exam %>% filter(class==1) %>% 
         arrange(desc(english), desc(science)) %>% 
         select(id, english, science)

df_sort = exam[exam$class==1, c('id', "english", "science")]
df_sort[order(-df_sort$english, df_sort$science), ]

#혼자서 해보기
audi = ggplot2::mpg
audi %>%  filter(manufacturer == "audi" ) %>% 
 arrange(desc(hwy)) %>% 
  select(model, year, cty, hwy) %>% head(5)


#6-5 파생변수 추가하기
exam %>% mutate(total = math + english + science,
         mean = (math + english + science)/3) %>%
         head

exam$total = exam$math + exam$english + exam$science
exam$mean = exam$math + exam$english + exam$science/3

exam %>% mutate(total2 = math+english+science,
                mean2 = (math+english+science)/3) %>% 
         arrange(desc(total2)) %>% 
         select(total, total2, mean, mean2) %>%
         head(5)

#혼자서 해보기
mpg = ggplot2::mpg
new = mpg
new = new %>%  mutate(total = hwy + cty)
new = new %>%  mutate(mean = total/2)

View(new)

new %>% arrange(desc(mean)) %>% head(3)

mpg %>% mutate(total = hwy + cty, mean = total/2) %>% 
        arrange(desc(mean)) %>% 
        head(3)


#6-6 집단별로 요약하기
exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))

exam %>%  filter(class<=3) %>% 
  group_by(class) %>% 
  summarise(total = sum(math, english, science),
            건수 = n()) %>% 
  arrange(desc(total))

mpg %>% 
  group_by(manufacturer, drv) %>% 
  summarise(도시연비평균=mean(cty)) %>% 
  arrange(desc(도시연비평균)) %>% 
  head(5)

#직책별 salary 합계, 평균
df_emp %>% 
  group_by(DEPARTMENT_ID, JOB_ID) %>% 
  summarise(total_sal = sum(SALARY),
            mean_sal = mean(SALARY),
            count_emp = n()) %>% 
  arrange(DEPARTMENT_ID)
  
#혼자서 해보기
mpg = ggplot2::mpg
mpg %>% 
  group_by(class) %>% 
  summarise(mean_cty = mean(cty))

mpg %>% 
  group_by(class) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty))

mpg %>% 
  group_by(manufacturer) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(3)

mpg %>% 
  filter(class=="compact") %>% 
  group_by(manufacturer) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count))


#6-7 데이터 합치기
df1 = data.frame(id=c(1,2,3,4,5),
                 midterm=c(100,99,88,76,66))
df2 = data.frame(id=c(1,5,3,4,2),
                 finalterm=c(10,20,30,40,50))

total <- left_join(df1, df2, by="id")
total


df_emp$department_id
df_dept$department_id

df_emp = rename(df_emp, department_id=DEPARTMENT_ID)

colnames(df_dept)
colnames(df_emp)

comb = left_join(df_emp, df_dept, by="department_id")
colnames(comb)

nrow(comb)
count(comb)
comb %>% filter(str_trim(department_name)=='Marketing') %>% 
  mutate(dname=str_trim(department_name), fname=str_trim(FIRST_NAME)) %>% 
  select(dname, fname)


#다른 데이터를 활용해 변수 추가하기
exa
teacher = data.frame(class=c(1,2,3,4,5),
          teacher=c("홍","김","양","박","현"))

left_join(exam, teacher, by="class")

#세로로 합치기
df1 = data.frame(id=c(1,2,3,4,5),
                 score=c(10,20,30,40,50))
df2 = data.frame(id=c(6,7,8,9,10),
                 score=c(100,200,300,400,500))

bind_rows(df1, df2)


#혼자서 해보기
fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F)
fuel
mpg <- ggplot2::mpg

mpg = left_join(mpg, fuel, by="fl")

mpg %>% 
  select(model, fl, price_fl) %>% 
  head(5)