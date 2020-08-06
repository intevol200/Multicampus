#문제1
x1 <- c(1:3) #변수 x1에 1에서 3까지를 가진 벡터 할당
x2 <- rep(c(4,5), each=2) #변수 x2에 4,5를 두번씩 반복하는 벡터 할당
x3 <- seq(1, 5, by=0.5) #변수 x3에 1부터 5까지 0.5씩 커지는 벡터 할당
y <- c(x1, x2) #변수 y에 x1과 x2의 요소를 할당
length(x1) #변수 x1의 요소의 개수


#문제2
X <- c(1,4, 2,1, 3,4) 
X <- matrix(X, ncol=3) #열의 숫자를 3으로 하는 행렬을 X에 할당

dim(X) #행과 열의 크기
#[1] 2 3

t(X)  #행과 열 위치 변경
#[,1] [,2]
#[1,]    1    4
#[2,]    2    1
#[3,]    3    4


#문제3
A <- 1:4 #변수 A에 1부터 4까지의 요소 할당
B <- c(3,5,7,9) #변수 B에 3,5,7,9를 가진 벡터 할당
C <- rep(2, 4) #변수 C에 2를 4번 반복하여 할당
rbind(A, B, C)  #A, B, C변수를 행단위로 묶음
#[,1] [,2] [,3] [,4]
#A    1    2    3    4
#B    3    5    7    9
#C    2    2    2    2


#문제4
#첫번째 열을 헤더로 지정하여 데이터 로드
Titanic <- read.csv("data/titanic.csv", header=TRUE)

head(Titanic)  #첫 6개 데이터 출력
dim(Titanic) #행렬의 길이
nrow(Titanic) #행의 개수

#열 이름 할당
names(Titanic) <- c("생존", "총인원", "위치", "나이", "성별") 
names(Titanic) #열 이름 출력


#문제5
A <- 1:4
B <- c(3,5,7,9)
C <- rep(2, 4)
x <- data.frame(A, B, C)
dim(x)
#[1] 4 3

#변수 A에는 1에서 4까지의 숫자,
#변수 B에는 3,5,7,9의 벡터
#변수 C에는 2를 4번 반복하는 숫자를 할당하고
#X에 A,B,C 변수를 각각의 열로 쓰는 데이터프레임을 생성


#문제6
library(readxl)

sur <- read_xlsx(path="data/설문조사.xlsx")
sur$성별 = factor(sur$성별,
                  labels=c("남","여"))

cnt = table(sur$소속, sur$성별,
            useNA = "ifany")

colnames(cnt)[3] = "무응답"
cnt


#문제7
sur <- read_xlsx(path="data/설문조사.xlsx")
sur$지원동기 = factor(sur$지원동기,
                      labels=c("합격가능성","장학금","사회적평판","졸업후진로",
                               "교육제도및시설","학문적흥미와적성","학사교류제도"))

out = table(sur$지원동기, sur$소속,
            useNA="ifany")

rownames(out)[8] = "무응답"
out = round(prop.table(out),2)
out


# 제목을 한번에 줄때 사용
# out = table(sur$지원동기, sur$소속,
#             useNA="ifany",
#             dnn = c("지원동기", "소속"))
