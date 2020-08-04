## 1. SQL vs MongoDB

| SQL | MongoDB |
|:---:|:---:|
| Database | Database |
| Table | Collection |
| Row | Document |
| Column | Field |
| Join | Embeded Document & Linking |
| Index | Index |

## 2. JSON
* JSON(JavaScript Objects Notation)
    - xml을 대체하기 위해 탄생
        + 대용량 데이터의 전송하려는 경우 xml은 용량이 급격히 늘어나 부적합한데, 이를 해결하기 위한 것이 JSON
    - 데이터 타입 : 딕셔너리
        + { "키" : 값,
            "키" : 값 }


## 3. MongoDB 문법
| 명령어 | 동작 |
|---|---|
| mongod | 서버 |
| mongo | 클라이언트 |
| use (데이터베이스명) | 데이터베이스 생성 또는 접속 |
| db.createCollection("테이블명") | 테이블 생성 |
| show collections | 생성된 테이블 확인 |
| db.dept.insert({"deptno" : 100, "deptname" : "aa"}) | 데이터 삽입 |
| db.dept.find({"deptno" : 100}) | 데이터 검색 |
| db.dept.delete({"deptno" : 100}) | 데이터 삭제 |