/*
Q1. DEPT, EMP ���̺��� ����Ͽ� �� �μ��� �Ҽ� ��� ������ Ȯ���ϴ� �˻� ����� ����ÿ�.
    EMP �÷��� �Ҽ� ����� ������ �� 'YES', �ƴϸ� 'NO'�� �˻��մϴ�.

���� ��� 
	
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
Q2. CUSTOMERS, ORDERS, WISHLIST ���̺��� �̿��Ͽ�, ���ɻ�ǰ ��� ������ �ִ� 
    ���� �ֹ� �հ�(SUM(orders.order_total))�� ������ ���� �˻��Ͻÿ�.
    * WISHLIST.DELETED �÷��� 'N'�� ���� ���� ���ɻ�ǰ�� ��ϵ� ������ 

���� ��� 

   CUST_ID CUST_FNAME           CUST_LNAME           ORDER_TOTAL
---------- -------------------- -------------------- -----------
       120 Diane                Higgins                      416	
...

42�� ���� ���õǾ����ϴ�.
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
Q3. CUSTOMERS, ORDERS, WISHLIST ���̺��� �̿��Ͽ�, 
    ���� �ֹ� �ݾ��� �հ�(SUM(order_total))�� ���� ���ɻ�ǰ ����� �հ�(SUM(unit_price*quantity))�� �˻��Ͻÿ�.

    * WISHLIST.DELETED �÷��� 'N'�� ���� ���� ���ɻ�ǰ�� ��ϵ� ������ 

   CUST_ID CUST_FNAME           CUST_LNAME              ORD_TOT   WISH_TOT
---------- -------------------- -------------------- ---------- ----------
       120 Diane                Higgins                     416        448
...

42�� ���� ���õǾ����ϴ�. 
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