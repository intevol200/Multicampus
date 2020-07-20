/*
Q1. DEPT, EMP 테이블을 사용하여 각 부서의 소속 사원 유무를 확인하는 검색 결과를 만드시오.
    EMP 컬럼은 소속 사원이 존재할 때 'YES', 아니면 'NO'를 검색합니다.

실행 결과 
	
    DEPTNO DNAME          LOC           EMP
---------- -------------- ------------- ---
        10 ACCOUNTING     NEW YORK      YES
        20 RESEARCH       DALLAS        YES
        30 SALES          CHICAGO       YES
        40 OPERATIONS     BOSTON        NO 
*/
SELECT D.DEPTNO, D.DNAME, D.LOC,
       NVL(( SELECT DISTINCT 'YES'
             FROM EMP
             WHERE DEPTNO = D.DEPTNO ), 'NO') AS EMP
FROM DEPT D
ORDER BY 1;



/*
Q2. CUSTOMERS, ORDERS, WISHLIST 테이블을 이용하여, 관심상품 등록 내용이 있는 
    고객의 주문 합계(SUM(orders.order_total))를 다음과 같이 검색하시오.
    * WISHLIST.DELETED 컬럼이 'N'인 행이 현재 관심상품에 등록된 정보임 

실행 결과 

   CUST_ID CUST_FNAME           CUST_LNAME           ORDER_TOTAL
---------- -------------------- -------------------- -----------
       120 Diane                Higgins                      416	
...

42개 행이 선택되었습니다.
*/
SELECT C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME, SUM(O.ORDER_TOTAL) AS ORDER_TOTAL
FROM CUSTOMERS C JOIN ORDERS O
ON C.CUST_ID  = O.CUST_ID
WHERE C.CUST_ID IN ( SELECT CUST_ID
                     FROM WISHLIST
                     WHERE DELETED = 'N' )
GROUP BY C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME
ORDER BY 1;


SELECT C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME, SUM(O.ORDER_TOTAL) AS ORDER_TOTAL
FROM ORDERS O
JOIN ( SELECT * 
       FROM CUSTOMERS 
	   WHERE CUST_ID IN ( SELECT CUST_ID 
                          FROM WISHLIST
                          WHERE DELETED = 'N' ) ) C
  ON C.CUST_ID = O.CUST_ID 				 
GROUP BY C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME
ORDER BY 1;  


SELECT C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME, O.ORDER_TOTAL
FROM ( SELECT CUST_ID, CUST_FNAME, CUST_LNAME
       FROM CUSTOMERS
       WHERE CUST_ID IN ( SELECT CUST_ID
                          FROM WISHLIST
                          WHERE DELETED = 'N' ) ) C
JOIN ( SELECT CUST_ID, SUM(ORDER_TOTAL) AS ORDER_TOTAL
       FROM ORDERS
       GROUP BY CUST_ID ) O
  ON C.CUST_ID = O.CUST_ID
ORDER BY 1;



/*
Q3. CUSTOMERS, ORDERS, WISHLIST 테이블을 이용하여, 
    고객별 주문 금액의 합계(SUM(order_total))와 현재 관심상품 목록의 합계(SUM(unit_price*quantity))를 검색하시오.

    * WISHLIST.DELETED 컬럼이 'N'인 행이 현재 관심상품에 등록된 정보임 

   CUST_ID CUST_FNAME           CUST_LNAME              ORD_TOT   WISH_TOT
---------- -------------------- -------------------- ---------- ----------
       120 Diane                Higgins                     416        448
...

42개 행이 선택되었습니다. 
*/
SELECT C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME, O.ORD_TOT, W.WISH_TOT
FROM CUSTOMERS C
JOIN ( SELECT CUST_ID, SUM(ORDER_TOTAL) AS ORD_TOT
       FROM ORDERS
	   GROUP BY CUST_ID ) O
  ON C.CUST_ID = O.CUST_ID
JOIN ( SELECT CUST_ID, SUM(UNIT_PRICE * QUANTITY) AS WISH_TOT
       FROM WISHLIST
       WHERE DELETED = 'N'
       GROUP BY CUST_ID ) W
  ON C.CUST_ID = W.CUST_ID
ORDER BY 1;