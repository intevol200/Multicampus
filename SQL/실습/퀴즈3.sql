/*
Q1. DEPT, EMP 테이블을 이용하여, 
    소속 부서의 평균 급여보다 더 많은 급여를 받는 MANAGER 들의 정보를 검색하시오.

검색 결과 

    DEPTNO DNAME               EMPNO ENAME             SAL
---------- -------------- ---------- ---------- ----------
        20 RESEARCH             7566 JONES            2975
        30 SALES                7698 BLAKE            2850
*/
-- 분석 함수를 이용한 방법
SELECT D.DEPTNO, D.DNAME, A.EMPNO, A.ENAME, A.SAL
FROM DEPT D
JOIN (SELECT EMPNO, ENAME, SAL, DEPTNO
      FROM (SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, E.DEPTNO,
                   AVG(SAL) OVER(PARTITION BY DEPTNO) AS AVG_SAL
            FROM EMP E)
      WHERE SAL > AVG_SAL
        AND JOB = 'MANAGER') A
  ON D.DEPTNO = A.DEPTNO;

-- 조인을 이용한 방법
SELECT DEPTNO, DNAME, EMPNO, ENAME, SAL
FROM ( SELECT *
       FROM EMP E 
       JOIN ( SELECT DEPTNO, AVG(SAL) AS COMPARE
              FROM EMP
              GROUP BY DEPTNO ) B
         ON E.DEPTNO = B.DEPTNO
       JOIN DEPT D
         ON E.DEPTNO = D.DEPTNO
      WHERE E.JOB = 'MANAGER' )
WHERE SAL > COMPARE
ORDER BY 1;

-- 서브쿼리 중첩을 이용한 방법
SELECT D.DEPTNO, D.DNAME, B.EMPNO, B.ENAME, B.SAL
FROM DEPT D
JOIN ( SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO
       FROM EMP E
       WHERE E.JOB = 'MANAGER' 
         AND E.SAL > ( SELECT AVG(SAL)
                       FROM EMP
                       WHERE DEPTNO = E.DEPTNO ) ) B
  ON D.DEPTNO = B.DEPTNO
ORDER BY 1;



/*
Q2.	SALES, CUSTS 테이블을 이용하여, 
    1980년도에 태어난 고객 중 구매 내역을 갖는 고객 정보를 다음과 같이 검색한다.

검색 결과 

   CUST_ID CUST_FIRST_NAME      CUST_LAST_NAME       CUST_CITY
---------- -------------------- -------------------- --------------------
        85 Ava                  Darr                 Bad Kreuznach
       282 Marcus               Maccarthy            Asten
       296 Atlanta              Roisston             Belmont, MI
       379 Cherie               Perez                Wadsworth
       492 Shela                Grace                Badalona
       524 Cherie               Proctor              Clifden
       613 Lincoln              Sean                 Bourges
       805 Carrol               Ridgeway             Bad Kreuznach
      1133 Polly                Ingram               Valencia
      1136 Portia               Colter               Skagen
      1148 Garnett              Lauers               Raamsdonksveer
...

129 rows selected.
*/
SELECT CUST_ID, CUST_FIRST_NAME, CUST_LAST_NAME, CUST_CITY
FROM CUSTS
WHERE CUST_YEAR_OF_BIRTH = 1980
  AND CUST_ID IN ( SELECT CUST_ID
                   FROM SALES );

SELECT C.CUST_ID, C.CUST_FIRST_NAME, C.CUST_LAST_NAME, C.CUST_CITY
FROM CUSTS C
WHERE C.CUST_YEAR_OF_BIRTH = 1980
  AND EXISTS ( SELECT *
               FROM SALES
               WHERE CUST_ID = C.CUST_ID );



/*
Q3.	EMPLOYEES 테이블을 이용하여 부서별 최대 급여를 받는 사원 정보를 검색하시오. 

검색 결과 

LAST_NAME                     SALARY JOB_ID     DEPARTMENT_ID
------------------------- ---------- ---------- -------------
Whalen                          4400 AD_ASST               10
Hartstein                      13000 MK_MAN                20
Higgins                        12008 AC_MGR               110
King                           24000 AD_PRES               90
Hunold                          9000 IT_PROG               60
Mourgos                         5800 ST_MAN                50
Abel                           11000 SA_REP                80

7 rows selected.
*/
SELECT LAST_NAME, SALARY, JOB_ID, DEPARTMENT_ID
FROM EMPLOYEES
WHERE (DEPARTMENT_ID, SALARY) 
   IN ( SELECT DEPARTMENT_ID, MAX(SALARY)
        FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID )
ORDER BY DEPARTMENT_ID;

SELECT LAST_NAME, SALARY, JOB_ID, DEPARTMENT_ID
FROM EMPLOYEES E
WHERE SALARY = ( SELECT MAX(SALARY)
                 FROM EMPLOYEES
                 WHERE DEPARTMENT_ID = E.DEPARTMENT_ID );



/*
Q4.	EMP 테이블에서 1981년도에 입사한 사원들을 입사 월별로 인원수를 검색하시오. 
     단, 사원이 없는 월도 함께 출력 

검색 결과

HIRE                 CNT
------------- ----------
1981/01                0
1981/02                2
1981/03                0
1981/04                1
1981/05                1
1981/06                1
1981/07                0
1981/08                0
1981/09                2
1981/10                0
1981/11                1
1981/12                2

12 rows selected.
*/
SELECT A.HIRE, NVL(B.CNT ,0)
FROM (SELECT '1981/'||LPAD(ROWNUM,2,'0') AS HIRE
      FROM EMP
      WHERE ROWNUM <= 12) A
LEFT JOIN
     (SELECT TO_CHAR(HIREDATE,'YYYY/MM') AS HIRE
             ,COUNT(*) AS CNT
      FROM EMP
      WHERE HIREDATE BETWEEN TO_DATE('19810101','YYYYMMDD')
                         AND TO_DATE('19820101','YYYYMMDD') - 1/86400
      GROUP BY TO_CHAR(HIREDATE,'YYYY/MM')) B
  ON A.HIRE = B.HIRE;


SELECT A.HIRE, COUNT(B.HIRE) AS CNT
FROM 
( SELECT '1981/01' AS HIRE FROM DUAL
  UNION SELECT '1981/02' FROM DUAL
  UNION SELECT '1981/03' FROM DUAL
  UNION SELECT '1981/04' FROM DUAL
  UNION SELECT '1981/05' FROM DUAL
  UNION SELECT '1981/06' FROM DUAL
  UNION SELECT '1981/07' FROM DUAL
  UNION SELECT '1981/08' FROM DUAL
  UNION SELECT '1981/09' FROM DUAL
  UNION SELECT '1981/10' FROM DUAL
  UNION SELECT '1981/11' FROM DUAL
  UNION SELECT '1981/12' FROM DUAL ) A
LEFT JOIN ( SELECT TO_CHAR(HIREDATE, 'YYYY/MM') AS HIRE
            FROM EMP
            WHERE HIREDATE BETWEEN TO_DATE('19810101','YYYYMMDD')
                               AND TO_DATE('19820101','YYYYMMDD') - 1/86400 ) B
       ON A.HIRE = B.HIRE
GROUP BY A.HIRE
ORDER BY 1;



/*
Q5. 'Asten'(CUSTOMERS.CITY)에 거주하는 고객이 
    관심 상품(WISHLIST)에 등록한 상품과 	실제 주문한 상품(ORDERS, ORDER_ITEMS)의 
	제품별 금액의 합(SUM(UNIT_PRICE*QUANTITY))을 검색하시오. 
	이때 관심 상품에만 등록 된 금액과, 관심 상품 등록 없이 주문한 제품의 금액 합도 함께 검색한다. 

검색 결과

   CUST_ID CUST_LNAME           PRODUCT_ID   WISH_TOT  ORDER_TOT
---------- -------------------- ---------- ---------- ----------
       148 Steenburgen                1910          0        117
       148 Steenburgen                1948    16035.6    10357.6
       148 Steenburgen                2289          0       4752
       148 Steenburgen                2302          0       4704
       148 Steenburgen                2308          0       2106
       148 Steenburgen                2322          0        990
       148 Steenburgen                2326          0       52.8
       148 Steenburgen                2330          0       64.9
       148 Steenburgen                2334          0       16.5
       148 Steenburgen                2335          0     4930.2
       148 Steenburgen                2340          0        994
       148 Steenburgen                2350          0   126462.6
       148 Steenburgen                2365          0       2079
       148 Steenburgen                2370          0       2520
       148 Steenburgen                2375          0       2336
       148 Steenburgen                2378          0     8966.1
       148 Steenburgen                2394          0     4197.6
       148 Steenburgen                2631         24          0
       148 Steenburgen                2721          0        425
       148 Steenburgen                2725          0       13.2
       148 Steenburgen                2761          0        494
       148 Steenburgen                2782       1210       1922
       148 Steenburgen                3193          0       13.2
       148 Steenburgen                3216          0        330
       148 Steenburgen                3234          0        612
       148 Steenburgen                3248          0     5519.8
       148 Steenburgen                3252          0        725
       148 Steenburgen                3334       1224          0
       153 Sheen                      1787          0        505
       153 Sheen                      1791        717      788.7
       153 Sheen                      1797          0       2436
       153 Sheen                      1799          0       9614
       153 Sheen                      1808          0        825
       153 Sheen                      1820          0        936
       153 Sheen                      1822          0    32965.9
       153 Sheen                      3077        711          0
       170 Fonda                      3106          0       7820
...
       326 Olin                       1806         50          0
       345 Weaver                     2384        599          0
       349 Glenn                      3139       78.2          0

52 rows selected.
*/
SELECT C.CUST_ID, C.CUST_LNAME, X.PRODUCT_ID, X.WISH_TOT, X.ORDER_TOT
FROM ( SELECT CUST_ID, CUST_LNAME
       FROM CUSTOMERS
       WHERE CITY = 'Asten') C
JOIN ( SELECT NVL(w.cust_id, o.cust_id) AS cust_id,
              NVL(w.product_id, o.product_id) AS product_id,
              NVL(w.wish_tot,0) AS wish_tot,
              NVL(o.order_tot,0) AS order_tot
       FROM ( SELECT CUST_ID, PRODUCT_ID, SUM(UNIT_PRICE * QUANTITY) AS WISH_TOT
              FROM WISHLIST
              WHERE DELETED = 'N'
              GROUP BY CUST_ID, PRODUCT_ID ) W
       FULL JOIN
            ( SELECT O.CUST_ID, I.PRODUCT_ID, SUM(I.UNIT_PRICE * I.QUANTITY) AS ORDER_TOT
              FROM ORDERS O JOIN ORDER_ITEMS I
              ON O.ORDER_ID = I.ORDER_ID
              GROUP BY O.CUST_ID, I.PRODUCT_ID ) O
       ON O.CUST_ID = W.CUST_ID AND O.PRODUCT_ID = W.PRODUCT_ID ) X
  ON C.CUST_ID = X.CUST_ID
ORDER BY C.CUST_ID, X.PRODUCT_ID;


SELECT C.CUST_ID, C.CUST_LNAME, X.PRODUCT_ID, X.WISH_TOT, X.ORDER_TOT
FROM ( SELECT CUST_ID, CUST_LNAME
       FROM CUSTOMERS
       WHERE CITY = 'Asten' ) C
JOIN ( SELECT CUST_ID, PRODUCT_ID, SUM(WISH_TOT) AS WISH_TOT, SUM(ORDER_TOT) AS ORDER_TOT
       FROM ( SELECT CUST_ID, PRODUCT_ID, (UNIT_PRICE * QUANTITY) AS WISH_TOT, 0 AS ORDER_TOT
              FROM WISHLIST
              WHERE DELETED = 'N'
              UNION ALL
              SELECT O.CUST_ID, I.PRODUCT_ID, 0, (I.UNIT_PRICE * I.QUANTITY) AS ORDER_TOT
              FROM ORDERS O JOIN ORDER_ITEMS I
                ON O.ORDER_ID = I.ORDER_ID )
       GROUP BY CUST_ID, PRODUCT_ID ) X
  ON C.CUST_ID = X.CUST_ID
ORDER BY C.CUST_ID, X.PRODUCT_ID;