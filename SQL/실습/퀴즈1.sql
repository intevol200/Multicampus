/*
Q1. SALES �μ��� �ٹ��ϰ�, 1981�� ��ݱ�(1��-6��)�� �Ի��� ��� ������ �˻��Ͻÿ�. 
    �̶� Ŀ�̼��� ���� �޿�(SAL + COMM)�� �Բ� �˻��ϰ� �Ի� ���� ������ �����մϴ�.
    �˻� ��� �÷�: empno, ename, hiredate, sal + comm
*/
SELECT E.EMPNO, E.ENAME, E.HIREDATE, NVL(E.SAL, 0) + NVL(E.COMM, 0) AS TOTAL_SAL
FROM EMP E JOIN DEPT D
  ON E.DEPTNO = D.DEPTNO
WHERE D.DNAME = 'SALES' 
  AND E.HIREDATE BETWEEN TO_DATE('19810101', 'YYYYMMDD') 
                     AND TO_DATE('19810701', 'YYYYMMDD') - 1/86400
ORDER BY 3;

-- ������ ����ϸ� ���ʿ��� ���̺��� �������� �� �ҷ����� ������
-- �ʿ��� �÷��� ���� �� ���̺��� ��� ������ ������ų �� �ֵ��
-- ���������� ����ϴ� ���� �� ���� ����
SELECT EMPNO, ENAME, HIREDATE, NVL(SAL, 0) + NVL(COMM,0)
FROM EMP 
WHERE HIREDATE BETWEEN TO_DATE('19810101','YYYYMMDD')
                   AND TO_DATE('19810701','YYYYMMDD') - 1/86400
  AND DEPTNO = ( SELECT DEPTNO 
                 FROM DEPT 
                 WHERE DNAME = 'SALES' )
ORDER BY 3; 


/*
Q2. JOB�� 'MANAGER'�� ������� �μ� ���� �� ��� ������ �˻��Ͻÿ�. 
    �˻� ��� �÷�: DEPTNO, DNAME, EMPNO, ENAME, JOB, SAL 
*/
-- �÷��� ��� ���̺��� �÷����� ������ָ� ���� ��� ������ �� �� ����
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
FROM DEPT D JOIN EMP E
  ON D.DEPTNO = E.DEPTNO
WHERE E.JOB = 'MANAGER';


/*
Q3. 'Canada'���� �ٹ� ���� ��� ������ ������ ���� �˻��Ͻÿ�.
    �˻� ��� �÷�: first_name, last_name, salary, job_id, country_name
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
Q4. CUSTOMERS, ORDERS ���̺��� ����Ͽ�, ���� �ֹ� �ݾ��� �հ踦 �˻��Ͻÿ�. 
    �˻� ��� �÷�: CUST_ID, CUST_FNAME, CUST_LNAME, SUM(orders.order_total)
*/
SELECT C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME, SUM(O.ORDER_TOTAL) AS SUM
FROM CUSTOMERS C JOIN ORDERS O
  ON C.CUST_ID = O.CUST_ID
GROUP BY C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME;


/*
Q5. DEPT, EMP ���̺��� ����Ͽ�, ���� ����� �˻��Ͻÿ�. 

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