a=10
a
b<-20
b
d=40; e=5

10%/%3
10%%3
10/3

mean(x <- c(1,2,3))
a = b <- 5

a**2
a^2

a <- 10
b <- 20
a+b
a-b
a+c

paste("더하기: ",a+b)
paste("빼기:", a-b)
paste("곱하기: ",a*b)

a||b

a = 60
a == 60 && a == (a2 <- 60)
a != 60 && a == (a2 <- 60)
a != 60 & a == (a3 <- 60)
a == 60 || a == (a4 <- 60)
a == 60 | a == (a5 <- 60)
a2
a3
a4
a5

########################
#data의 유형
a=10
b="문자"
c=10>20
d=NA
e=sqrt(-10)
f=NULL
1 + Inf

mode(a)
class(a)
typeof(a)

mode(b)
mode(c)


data()

a="문자"
mode(a)
class(a)
typeof(a)

x1 = 100
x2 = 100L
is.numeric(x1)
is.integer(x1)
is.numeric(x2)
is.integer(x2)

result = c(1,2,3, "r")
result = c(1,2,3, TRUE, FALSE)
result

a="100"
b=200
as.numeric(a)+b

v1 = c(10,80,50)
v2 = c(20,50,90,100)
v3 = c(v1,v2)

v1 = 1:5
v2 = 5:1
v3 = -3.3:5
v4 = seq(1,6,2)

v4 = seq(from=1, to=6, by=2)
v4 = seq(from=1, by=2, to=6)

v5 = sequence(5)

rep(c('a','b'), times=2)
rep(c('a','b'), each=2)
rep(c('a','b'), each=2, times=3)

#벡터의 속성
c1 = c(10,20,30,40,50)
mode(c1)
class(c1)
typeof(c1)
is.numeric(c1)
length(c1)
mean(c1) #평균
names(c1)

weight = c(20,60,80,40)
weight[1]
weight[1:2]
weight[c(1,3)]
weight[-c(1,3)] #해당 영역 제외

#리사이클링 규칙에 의해 벡터연산
weight = c(20,60,80,40,10,20,30,40)
weight2 = c(1,6,8)
weight + weight2

#범주형 : 성별, 국적, 
#1. 명목형
#2. 순서형
gender = c("m", "f", "f", "f", "m")
mode(gender)
class(gender)
typeof(gender)

gender_f = factor(gender)
mode(gender_f)
class(gender_f) #객체지향관점 : factor
typeof(gender_f)

gender_f2 = factor(gender, levels = c("m", "f"),
                   labels = c("남자", "여자"),
                   ordered = TRUE)

gender_f
gender_f2

sort(gender_f2)

v1 = c(10,20,30,40)
v2 = c("국어","영어","과학","사회")

m1 = cbind(v1, v2)
m1 = rbind(v1, v2)

#열우선
m3 = matrix(1:6, nrow=2, ncol=3)
#행우선
m3 = matrix(1:6, nrow=2, ncol=3, byrow=TRUE)

m3

a1 = array(1:10, dim=10)
a2 = array(1:10, dim=c(2,5))
a3 = array(1:20, dim=c(2,5,2))

#값의 개수가 부족하면 리사이클링
a4 = array(1:20, dim=c(2,2,5))

v1 = 10
v2 = c(10,20,80)
v3 = 1:5
v4 = matrix(1:10, nrow=2, ncol=5)
v5 = array(1:10, dim = c(2,5))
v6 = women
f = factor(c("m", "f", "f", "m", "m"), 
           levels = c("m", "f"),
           labels = c("남자", "여자"))
v7 = list(v1, v2, v3, v4, v5, v6)
v7
