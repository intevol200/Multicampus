/*
Q1. SALES 부서에 근무하고, 1981년 상반기(1월-6월)에 입사한 사원 정보를 검색하시오. 
    이때 커미션을 합한 급여(SAL + COMM)를 함께 검색하고 입사 일자 순으로 정렬합니다.
    검색 대상 컬럼: empno, ename, hiredate, sal + comm
*/
SELECT E.EMPNO, E.ENAME, E.HIREDATE, NVL(E.SAL, 0) + NVL(E.COMM, 0) AS TOTAL_SAL
FROM EMP E JOIN DEPT D
  ON E.DEPTNO = D.DEPTNO
WHERE D.DNAME = 'SALES' 
  AND E.HIREDATE BETWEEN TO_DATE('19810101', 'YYYYMMDD') 
                     AND TO_DATE('19810701', 'YYYYMMDD') - 1/86400
ORDER BY 3;

-- 조인을 사용하면 불필요한 테이블의 정보까지 다 불러오기 때문에
-- 필요한 컬럼을 보고 한 테이블에서 모든 조건을 만족시킬 수 있디면
-- 서브쿼리를 사용하는 것이 더 나은 습관
SELECT EMPNO, ENAME, HIREDATE, NVL(SAL, 0) + NVL(COMM,0)
FROM EMP 
WHERE HIREDATE BETWEEN TO_DATE('19810101','YYYYMMDD')
                   AND TO_DATE('19810701','YYYYMMDD') - 1/86400
  AND DEPTNO = ( SELECT DEPTNO 
                 FROM DEPT 
                 WHERE DNAME = 'SALES' )
ORDER BY 3; 


/*
Q2. JOB이 'MANAGER'인 사원들의 부서 정보 및 사원 정보를 검색하시오. 
    검색 대상 컬럼: DEPTNO, DNAME, EMPNO, ENAME, JOB, SAL 
*/
-- 컬럼명에 어느 테이블의 컬럼인지 명시해주면 성능 향상에 도움이 될 수 있음
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
FROM DEPT D JOIN EMP E
  ON D.DEPTNO = E.DEPTNO
WHERE E.JOB = 'MANAGER';


/*
Q3. 'Canada'에서 근무 중인 사원 정보를 다음과 같이 검색하시오.
    검색 대상 컬럼: first_name, last_name, salary, job_id, country_name
*/
SELECT E.FIRST_NAME, E.LAST_NAME, E.SALARY, E.JOB_ID, C.COUNTRY_NAME
FROM EMPLOYEES E JOIN DEPARTMENTS D
  ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L
  ON D.LOCATION_ID = L.LOCATION_ID
JOIN COUNTRIES C
  ON L.COUNTRY_ID = C.COUNTRY_ID
WHERE C.COUNTRY_NAME = 'Canada';


/*
Q4. CUSTOMERS, ORDERS 테이블을 사용하여, 고객별 주문 금액의 합계를 검색하시오. 
    검색 대상 컬럼: CUST_ID, CUST_FNAME, CUST_LNAME, SUM(orders.order_total)
*/
SELECT C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME, SUM(O.ORDER_TOTAL) AS SUM
FROM CUSTOMERS C JOIN ORDERS O
  ON C.CUST_ID = O.CUST_ID
GROUP BY C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME;


/*
Q5. DEPT, EMP 테이블을 사용하여, 다음 결과를 검색하시오. 

   DEPTNO DNAME             ANALYST      CLERK    MANAGER  PRESIDENT   SALESMAN
---------- -------------- ---------- ---------- ---------- ---------- ----------
        10 ACCOUNTING                      1300       2450       5000           
        20 RESEARCH             6000       1900       2975                      
        30 SALES                            950       2850                  5600
        40 OPERATIONS    
*/
SELECT D.DEPTNO, D.DNAME, 
       SUM(DECODE(E.JOB, 'ANALYST', E.SAL, 0)) AS ANALYST,
       SUM(DECODE(E.JOB, 'CLERK', E.SAL, 0)) AS CLERK,
       SUM(DECODE(E.JOB, 'MANAGER', E.SAL, 0)) AS MANAGER,
       SUM(DECODE(E.JOB, 'PRESIDENT', E.SAL, 0)) AS PRESIDENT,
       SUM(DECODE(E.JOB, 'SALESMAN', E.SAL, 0)) AS SALESMAN
FROM DEPT D LEFT JOIN EMP E
  ON D.DEPTNO = E.DEPTNO
GROUP BY D.DEPTNO, D.DNAME
ORDER BY 1;

SELECT D.DEPTNO, D.DNAME, 
       SUM(CASE E.JOB WHEN 'ANALYST' THEN E.SAL ELSE 0 END) AS ANALYST,
       SUM(CASE E.JOB WHEN 'CLERK' THEN E.SAL ELSE 0 END) AS CLERK,
       SUM(CASE E.JOB WHEN 'MANAGER' THEN E.SAL ELSE 0 END) AS MANAGER,
       SUM(CASE E.JOB WHEN 'PRESIDENT' THEN E.SAL ELSE 0 END) AS PRESIDENT,
       SUM(CASE E.JOB WHEN 'SALESMAN' THEN E.SAL ELSE 0 END) AS SALESMAN
FROM DEPT D LEFT JOIN EMP E
  ON D.DEPTNO = E.DEPTNO
GROUP BY D.DEPTNO, D.DNAME
ORDER BY 1;
