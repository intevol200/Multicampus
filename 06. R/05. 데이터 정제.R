library(ggplot2)
library(dplyr)

#결측치
df = data.frame(gender=c("m","f",NA,"m","f"),
                score=c(100,200,NA,300,400))

is.na(df)
sum(is.na(df))

sum(is.na(df$gender))
sum(is.na(df$score))


#결측치 제거
mean(df$score)

sum(df$score, na.rm = T)
mean(df$score, na.rm = T)

df[is.na(df$score),]
df[!is.na(df$score),]
df[!is.na(df$score) & !is.na(df$gender),]

df %>% filter(!is.na(df$score) & !is.na(df$gender)) %>% 
  summarise(total=sum(score))


df_emp = read.csv("data/emp.csv")
colnames(df_emp)
str(df_emp)
sum(is.na(df_emp$DEPARTMENT_ID))

df_emp[is.na(df_emp$DEPARTMENT_ID),c("FIRST_NAME", "SALARY","DEPARTMENT_ID")]

mean(df_emp$SALARY)
sum(df_emp$DEPARTMENT_ID)

sum(df_emp$DEPARTMENT_ID, na.rm = T)

table(is.na(df_emp$DEPARTMENT_ID))
table(is.na(df_emp$COMMISSION_PCT))

df_emp %>% 
  filter(!is.na(COMMISSION_PCT)) %>% 
  select(FIRST_NAME, COMMISSION_PCT)


#NA를 포함하는 행 계산
sum(is.na(df_emp)) # <- 컬럼 개수

rowSums(is.na(df_emp)) # <- 행별로 계산
sum(rowSums(is.na(df_emp))>0) # <- 행별로 계산

sum(is.na(df_emp[1,])) #칼럼별로 몇개 있을까
sum(is.na(df_emp["DEPARTMENT_ID"]))
sum(is.na(df_emp["COMMISSION_PCT"]))
sum(is.na(df_emp["MANAGER_ID"]))


#칼럼별 결측치 
myF = function(col){
    return (sum(is.na(col)))
}

sapply(df_emp, myF)
sapply(df, myF)


#NA 검색
df_emp %>% 
  filter(DEPARTMENT_ID==NA) #실행 불가능

df_emp %>% 
  filter(is.na(DEPARTMENT_ID))


#결측치가 하나라도 있으면 제거하기
# na.omit 사용시 필요한 데이터까지 삭제될 가능성이 있음
df_nomiss2 <- na.omit(df) 
df_nomiss2


df_exam = read.csv("data/csv_exam.csv")
sum(is.na(df_exam))

df_exam[c(3,8,15), "math"] = NA
sum(df_exam)

#결측치가 포함된 평균 계산
mean(df_exam$math, na.rm = T)
df_exam %>%
  summarise(mean_math = mean(math, na.rm = T))


#결측치 대체하기
#결측치가 많을 경우 모두 제외하면 데이터 손실이 큼
df_exam[c(3,8,15), "math"] = NA

mean(df_exam$math)
mean_math = as.integer(round(mean(df_exam$math, na.rm = T),0))
mean_math

df_exam$math <- ifelse(is.na(df_exam$math), mean_math, df_exam$math)
table(is.na(df_exam$math))
df_exam


#혼자서 해보기
mpg = ggplot2::mpg
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA
sum(mpg$hwy)

table(is.na(mpg$drv))
table(is.na(mpg$hwy))
sapply(mpg, myF)

mpg %>% 
  filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))


mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T))

#부서별, job_id 별 salary 합계
df_emp[c(1,2,3), "SALARY"] = NA
sum(is.na(df_emp$SALARY))

df_emp %>% 
  filter(!is.na(SALARY) & !is.na(DEPARTMENT_ID)) %>% 
  group_by(DEPARTMENT_ID, JOB_ID) %>% 
  summarise(sum_sal = sum(SALARY))

df_emp %>% 
  group_by(DEPARTMENT_ID, JOB_ID) %>% 
  summarise(sum_sal = sum(SALARY, na.rm = T))


#이상치 정제
outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1),
                      score = c(5, 4, 3, 4, 2, 6))
outlier

table(outlier$sex)
table(outlier$score)

# sex 가 3 이면 NA 할당
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier

# sex 가 1~5 아니면 NA 할당
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier


#상자그림
boxplot(mpg$hwy)
boxplot(mpg$hwy)$stats #상자그림 통계치 출력

hwy_stat = boxplot(mpg$hwy)$stats
hwy_stat[1]
hwy_stat[5]

mpg = ggplot2::mpg
boxplot(mpg$hwy)$stats
mpg[mpg$hwy<12 | mpg$hwy>37,"hwy"]

ifelse(mpg$hwy<hwy_stat[1] |
       mpg$hwy>hwy_stat[5], NA, mpg$hwy)

mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

boxplot(mpg$hwy)
table(is.na(mpg$hwy))
mpg[is.na(mpg$hwy),"hwy"]


#혼자서 해보기
mpg <- as.data.frame(ggplot2::mpg)
mpg[c(10, 14, 58, 93), "drv"] <- "k" 
mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42)

table(mpg$drv, useNA = "always")

mpg$drv = ifelse(mpg$drv %in% c("4", "f", "r"), mpg$drv, NA)
table(mpg$drv, useNA = "always")


cty_stats = boxplot(mpg$cty)$stats
cty_stats[1]
cty_stats[5]

mpg$cty = ifelse(mpg$cty<cty_stats[1] |
                 mpg$cty>cty_stats[5], NA, mpg$cty)

mpg$cty <- ifelse(mpg$cty < 9 | mpg$cty > 26, NA, mpg$cty)
boxplot(mpg$cty)

mpg %>%
  filter(!is.na(drv) & !is.na(cty)) %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(cty))


################
df_emp = read.csv("data/emp.csv")
str(df_emp)

library(stringr)
df_emp$FIRST_NAME = str_trim(df_emp$FIRST_NAME)
df_emp$LAST_NAME = str_trim(df_emp$LAST_NAME)

library(dplyr)

#이름이 Steven인 직원
df_emp %>% 
  filter(FIRST_NAME=="Steven") %>% 
  select(FIRST_NAME,HIRE_DATE,SALARY)

#St로 시작하는 직원
df_emp %>% 
  filter(str_sub(FIRST_NAME,1,2)=="St") %>% 
  select(FIRST_NAME,HIRE_DATE,SALARY)

#소문자로 변환후 검색
df_emp %>% 
  filter(str_to_lower(str_sub(FIRST_NAME,1,2))=="st") %>% 
  select(FIRST_NAME,HIRE_DATE,SALARY)


#패턴에 맞는 데이터만 추출
phone = "나의 연락처는 010-9999-9999 비상용 010-1234-5678"
pattern = "[01]{3}-[0-9]{4}-[0-9]{4}"

str_extract_all(phone, pattern)
str_match_all(phone, pattern)

str_match_all(df_emp$FIRST_NAME, "St\\w+")

# ^     : 시작
# []    : 선택
# +     : 1개 이상
# *     : 0개 이상
# ?     : 0,1
# \d    : 숫자 [0-9]
# w     : 숫자, 문자[0-9a-zA-Z]
# {3}   : 3자리수
# {3,}  : 3자리 이상
# {3,4} : 3~4자리수


df_emp[
  str_extract_all(df_emp$FIRST_NAME, "St\\w+", simplify = TRUE) != "",
  c("FIRST_NAME","HIRE_DATE")]



#년도별 입사자 수
df_emp %>% 
  mutate(year=str_sub(HIRE_DATE,1,4)) %>% 
  group_by(year) %>% 
  summarise(count = n(), sumsal=sum(SALARY)) %>% 
  arrange(desc(year))

df_emp %>%
  filter(str_sub(HIRE_DATE,1,4)=='2002') %>% 
  select(FIRST_NAME,SALARY,HIRE_DATE)

#입사한지 며칠?
#오늘
Sys.Date() 

#타입변환
df_emp$HIRE_DATE = as.Date(df_emp$HIRE_DATE)

(Sys.Date() - df_emp$HIRE_DATE)/365
