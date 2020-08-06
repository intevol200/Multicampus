관리자 계정에서 UNLOCK 계정 생성
```SQL
ALTER USER (계정명) IDENTIFIED BY (비밀번호) ACCOUNT UNLOCK;
```

SPOOL 활성화
* 검색된 데이터를 별도의 파일로 저장
```SQL
-- 저장옵션 설정
SET colsep ','
SET pagesize 0
SET trimspool ON
SET linesize 9999

-- 데이터 저장 위치 지정
SPOOL c:/temp/emp.csv

-- 저장할 데이터 검색
SELECT employee_id, first_name,last_name,
       salary, department_id
  FROM employees;

-- 저장 종료
SPOOL OFF
```