-- ���� �޿��� ���� ���
SELECT EMPNO, ENAME, SAL, 
       ( SELECT SUM(SAL)
         FROM EMP
         WHERE EMPNO <= E.EMPNO ) AS ACC_SAL
FROM EMP E
ORDER BY EMPNO;

SELECT EMPNO, ENAME, 
       SUM(SAL) OVER(ORDER BY EMPNO)
FROM EMP;


-- �μ��� �޿��� �� ���
SELECT EMPNO, ENAME, 
       SUM(SAL) OVER(PARTITION BY DEPTNO)
FROM EMP;


-- �� �̷��� 2�� �̻��� ���� ���� ���
SELECT *
FROM ( SELECT D.*, COUNT(*) OVER(PARTITION BY CUST_ID) AS CNT 
       FROM DORMANT_HIST D )
WHERE CNT >= 2;