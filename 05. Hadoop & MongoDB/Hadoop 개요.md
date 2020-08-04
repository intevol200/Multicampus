## 1. Hadoop 소개
* Hadoop : 대용량 분산 처리 시스템
    - HDFS(Hadoop Distributed File System) : 분산 데이터 저장
        + 블록 단위로 파일 보관
        + 분산 파일 시스템
        + 장애 복구를 위한 애플리케이션
    - MapReduce : 분산 처리

* 하둡 기반 처리
    - DB 기반 + 파일 기반
    - 저비용으로 대량의 데이터를 빠르게 로드

* 빅데이터 프로세스
    1. 데이터 소스
    2. 수집
    3. 저장
    4. 처리
    5. 분석
    6. 표현


## 2. 하둡 유사분산모드 설정 방법
1. Hadoop 다운로드
2. JDK 8 설치
3. 환경변수 추가

| 변수 이름 | 변수 값 |
|---|---|
| HADOOP_HOME | C:\hadoop-2.7.1 |
| JAVA_HOME | C:\PROGRA~1\Java\jdk1.8.0_251 |
| PATH(1) | C:\hadoop-2.7.1\bin |
| PATH(2) | C:\hadoop-2.7.1\sbin |
| PATH(3) | C:\Program Files\Java\jdk1.8.0_251\bin |

4. 디렉토리 생성
    - namenode : C:\hadoop-2.7.1\data\namenode
    - datanode : C:\hadoop-2.7.1\data\datanode
    - Secondary namenode : C:\hadoop-2.7.1\data\namesecondary
    - Yarn local dir : C:\hadoop-2.7.1\data\tmp

5. CMD 관리자 권한 실행
6. Namenode 초기화
```
C:\hadoop-2.7.1\bin\hdfs namenode -format
```

7. Hadoop 시작
```
C:\hadoop-2.7.1\sbin\start-all.cmd
```

8. 서비스 정상 작동 확인
* jps : 어떤 데몬이 실행중인지 확인하는 명령어
* 리소스 매니저 GUI : http://localhost:8088/cluster
* Namenode GUI : http://localhost:50070


9. HDFS 명령어

| 명령어 | 동작 내용 |
|---|---|
| whoami | 접속 PC 정보 |
| hdfs dfs -mkdir -p /user/(사용자) | HDFS 사용자 홈 디렉토리 |
| hdfs dfs -mkdir (폴더명) | 하위 디렉토리에 폴더 생성 |
| hdfs dfs -ls -R / | 디렉토리 정보 확인 |
| hdfs dfs -copyFromLocal (대상 폴더)\* input | 대상 폴더 데이터를 복제하여 업로드 |
| hdfs dfs -ls (폴더명) | 대상 폴더 내용 확인 |
| yarn jar C:\hadoop-2.7.1\share\hadoop\mapreduce\hadoop-mapreduce-examples-2.7.1.jar wordcount (대상 폴더) (출력 폴더) | jar 파일에서 모듈을 불러와 대상 폴더에 저장된 파일의 문자 사용 빈도 계산 |
| hdfs dfs -cat (폴더명)/* | 해당 폴더의 모든 내용을 정리해서 출력 |