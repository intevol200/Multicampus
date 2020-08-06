getwd()
setwd("C:/education")
#상대경로: 기준이 현재의 위치
#절대경로: C:/~

id=1:5
name=c("kim", "yang", "park", "lee", "hyun")
gender=c("m", "f", "f", "m", "m")
salary=c(500,400,700,900,100)
df = data.frame(id, name, gender, salary)

df = data.frame(id, name, gender, salary,
                stringsAsFactors = FALSE)

df

df$gender = factor(df$gender,
                   levels=c("m", "f"),
                   labels=c("남","녀"))

str(df)
table(df$gender)
barplot(table(df$gender))
plot(df$gender, df$salary)

#문자를 factor로 만들지 않는다.
#일반적으로 변동이 없는 데이터만 FACTOR 적용 
df = data.frame(mycol=rep("test",5),
                stringsAsFactors = FALSE)

#문자를 factor로 만든다.
df = data.frame(mycol=rep("test",5),
                stringsAsFactors = TRUE)

str(df)
df$mycol[1]='RR'


nrow(df)
ncol(df)

colnames(df)
rownames(df)
rownames(df) = paste("R",1:5, sep="")

paste("R", 1:5)


df$mycol[1]
df["R1", "mycol"] #이름으로 가져오기
df["R1", ] #해당열의 전부 가져오기
df[1] #순서로 가져오기


df2 = data.frame(id, name, gender, salary,
                 stringsAsFactors = FALSE)
nrow(df2)
ncol(df2)
colnames(df2)
rownames(df2)
rownames(df2) = paste("row",1:nrow(df2),sep="")

#먼저 테스트해보고 적용
paste("row",1:nrow(df2),sep="")


#칼럼 가져오기
df2$name
df2[1]

#row 가져오기
df2[1, ]
df2["row1", ]

#특정값만 가져오기
df2[1,2]
df2[1,"name"] #일반적인 방법
df2["row1","name"]

#행렬 표시
dim(df2)
dimnames(df2)
str(df2)


search()
searchpaths()
install.packages("ggplot2") #패키지 다운로드 및 설치
library(ggplot2) #패키지 적용
help(package=ggplot2)


#data 읽기
getwd()
df1 = read.table(file = "./data/survey_blank.txt") #상대경로1
df2 = read.table(file = "data/survey_blank.txt") #상대경로2
df3 = read.table(file = "C:/education/data/survey_blank.txt",
                 header=TRUE, 
                 sep = " ") #절대경로

#콤마로 구분
df3 = read.table(file = "data/survey_comma.txt",
                 header=TRUE, 
                 sep = ",")

#탭으로 구분
df3 = read.table(file = "data/survey_tab.txt",
                 header=TRUE, 
                 sep = "\t")
df5$major
df5[1,2]


#csv(콤마로 구분된 데이터)
#예시: 100,aa,bb
#xml 예시: <customer><id>100</id><name>aa</name></customer>
#JSON, DICTIONARY 예시: {"id":100, "name":"aa", "major":"bb"}

#csv(comma seperated value)의 경우 sep를 주지 않아도 됨
df4 = read.csv(file = "data/csv_exam.csv") 

df5 = read.csv(file = "data/인구주택총조사2015.csv",
               header=TRUE)


install.packages("readxl")
library(readxl)


df5 = read_excel("data/인구주택총조사2015.xlsx")
df6 = read_excel(path = "data/인구주택총조사2015.xlsx",
                 sheet="Data") #시트 지정
nrow(df6)
ncol(df6)

#메모리 영역 저장
save(df5, file = "work.RDATA") #특정 개체만 저장
load("work.RDATA")

a=10
b="R언어"

save.image(file = "myAll.RDATA") #모든 개체 저장
load("myAll.RDATA")


#데이터 저장
df5
write.csv(df5, file = "backup.csv")
read.csv(file = "backup.csv")


install.packages("openxlsx")
library(openxlsx)
write.xlsx(df5, file = "backup.xlsx")
read_xlsx(path = "backup.xlsx")

#패키지 = 함수 + data ....
data()
data(package=.packages(all.available = TRUE)) #사용 가능한 패키지
data(package="ggplot2") #특정 패키지에서 사용 가능한 데이터셋

mode(iris)
class(iris)
typeof(iris)

nrow(iris)
ncol(iris)
str(iris)

iris$Species 
iris[1,1]
iris[1,]
iris[1,"Species"]

write.csv(iris, file = "iris.csv")
read.csv("iris.csv")


#데이터 목록 표시
ls()

b = "rrrrr"
rm(b) #데이터 삭제
rm(list = ls()) #전체 삭제

data(package="ggplot2")
str(ggplot2::diamonds)
str(diamonds)

colnames(diamonds)
View(diamonds) #전체 데이터 보기
head(diamonds, n=2) #몇 개 데이터만 보기
head(diamonds, 2)

read.csv("iris.csv", TRUE)
read.csv(file = "iris.csv",
         sep = ",",
         header = TRUE)

diamonds[,1]
diamonds[,"carat"] #이름을 알고 있음
diamonds[,2:5] #연속
diamonds[,c("cut","color","clarity")] #이름을 여러개 알고 있음
diamonds[,seq(2,5,2)] #규칙

#본래의 타입을 유지
class(diamonds[,1])
diamonds[,1,drop=FALSE]

#본래의 타입이 아닌 값을 반환
diamonds[,1,drop=TRUE]
typeof(diamonds[,1,drop=TRUE])


#정규표현식(REGULAR EXPRESSION)
#^ : 시작
#$ : 끝
#[] : 선택
#[0-9] : 범위

grep("^c",colnames(diamonds))
diamonds[, grep("^c",colnames(diamonds))] #c로 시작하는 컬럼 추출
diamonds[,c(1,2,3,4)]

grep("e$",colnames(diamonds)) #e로 끝나는 컬럼 추출
diamonds[, grep("e$",colnames(diamonds))]

grep("^[cp]",colnames(diamonds)) #c이거나 p로 시작하는 컬럼 추출
diamonds[, grep("^[cp]",colnames(diamonds))]


# \문자 : 제어문자(\t, \n, \\)
# \w : 0-9, a-z, A-Z
# + : 1개 이상
# * : 0개 이상
grep("ca\\w+", colnames(diamonds))
grep("ca", colnames(diamonds))
grep("ca[0-9a-zA-Z]", colnames(diamonds))

read.csv(file = "data/csv_exam.csv")

cols = colnames(diamonds)
typeof(cols)

grep(".a\\w+", cols)

#t를 포함한 컬럼
diamonds[, grep('t', colnames(diamonds))]

str(diamonds)
table(diamonds$cut)
diamonds[diamonds$cut == 'Fair', ]

df = data.frame(mycol=c(100,200,300))
df[c(TRUE, FALSE, TRUE), ]
df[(df$mycol==100) | (df$mycol==300), ]

(df$mycol==100) || (df$mycol==300)
(df$mycol==100) | (df$mycol==300)


# || : 첫번째만 수행.. 결과 1
# | : 모두 수행
c(TRUE, FALSE, FALSE) &&
c(FALSE, FALSE, TRUE)
df[c(TRUE, FALSE, TRUE), ]

diamonds$cut == "Fair"
diamonds[diamonds$price >= 18000, ]
df = diamonds[diamonds$cut == "Fair" & diamonds$price >= 18000, ]

df$price
df$cut

c(1,2,3) + 
c(4,5,6,7,8,9)

diamonds[1:5, c("carat", "x", "y", "z")]
diamonds$xyz.sum = diamonds$x + diamonds$y + diamonds$z
diamonds$xyz.mean = (diamonds$x + diamonds$y + diamonds$z)

diamonds[diamonds$price >= 18000, 'price'] = 18000
diamonds[diamonds$price==18000, 'price']


table(diamonds$cut)

diamonds[diamonds$cut == "Fair" & diamonds$price, 'x'] = NA

as.logical(0)
as.logical(100)

diamonds[c(1,2,3)]
diamonds[-c(1),]
diamonds[!c(1),]

diamonds[diamonds$cut == "Fair", "cut"]
diamonds[!(diamonds$cut == "Fair"), "cut"]
diamonds[diamonds$cut != "Fair", "cut"]

diamonds[c(1,2,3), ]

a = subset(diamonds, cut == c("Fair", "Good"))
b = subset(diamonds, (cut == "Fair") | (cut == "Good"))
c = diamonds[diamonds$cut == "Fair", ]
d = diamonds[diamonds$cut == "Good", ]

nrow(a) #3263
nrow(b) #6516
nrow(c) #1610
nrow(d) #4906

v1 = c(100,200)
aa = "Premium"
bb = "Fair"
b1 = aa ==c("Premium","Fair");b1
b2 = bb ==c("Premium","Fair");b2
v1[b1]
v1[b2]
c(b1,b2)
v1[c(b1,b2)]

#count 사용
install.packages("dplyr")
library(dplyr)


#정렬
diamonds[order(diamonds$price), c("carat", "color", "price")]
diamonds[order(diamonds$price, decreasing=TRUE), c("carat", "color", "price")]
diamonds[order(diamonds$color,
               diamonds$price, decreasing=TRUE), c("carat", "color", "price")]


#ifelse
diamonds$price.group = ifelse(diamonds$price>=5000, "이상", "이하")
diamonds[1000:1100, c("price", "price.group")]
tail(diamonds[c("price", "price.group")], 10)

diamonds[diamonds$price.group == '이상', c("price", "price.group")]


a=10
if(a>=10){
  print("a는 10보다 크다.")
  }else {
  print("a는 10보다 작다.")
  }
print("end")


#90~100 : A
#80~89  : B
#70~79  : C
#60~69  : D
#나머지 : F
score = 50
grade = 'F'

if(score>=90){
  grade='A'
}else if(score>=80){
  grade='B'
}else if(score>=70){
  grade='C'
}else if(score>=60){
  grade='D'
}

print(paste("점수는", score, "학점은", grade))
print("end")


#반복문
total = 0
for(i in 1:10){
  print(paste(i, "Hello"))
  total = total + i #누적
}
print(total)


total = 0
for(i in seq(10,100,10)){
  print(paste(i, "Hello"))
  total = total + i #누적
}
print(total)


total = 0
for(i in sequence(10)){
  print(paste(i, "Hello"))
  total = total + i #누적
}
print(total)

names = c("홍길동","박길동","김길동")
paste(names, collapse = "**")


arr <- c("m", "m", "f", "f", "f", "e")
table(arr)
qplot(arr)

?mpg
?qplot
str(mpg)
table(mpg$drv)

#x축만 지정하면 y축은 알아서 count로 생성됨
qplot(data = mpg, x=hwy)
qplot(data = mpg, x=cty)
qplot(data = mpg, x=drv, y=hwy) #산포도
qplot(data = mpg, x=drv, y=hwy, geom = "line")
qplot(data = mpg, x=drv, y=hwy, geom = "boxplot")

#drv 마다 색상을 다르게 부여
qplot(data = mpg, x=drv, y=hwy, geom = "boxplot", color=drv)


x = c(80,60,70,50,90)
x
mean(x)
score <- mean(x)
score

sales = data.frame(fruit = c("사과", "딸기", "수박"),
                   price = c(1800,1500,3000),
                   volume = c(24,38,13))
sales

mean(sales$price)
mean(sales$volume)

df_exam_novar <- read_excel("data/excel_exam_novar.xlsx", col_names = F)
df_exam_novar

df_exam_sheet <- read_excel("data/excel_exam_sheet.xlsx", sheet = 3)
df_exam_sheet
