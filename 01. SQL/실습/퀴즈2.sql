/*
Q. DEPT ���̺��� �μ� ������ �˻��ϸ鼭, 
   �ش� �μ��� �ٹ��ϴ� ����� ��/���� Ȯ�� 
   
    DEPTNO DNAME          LOC             EMP 
---------- -------------- -------------   ------
        10 ACCOUNTING     NEW YORK         YES 
        20 RESEARCH       DALLAS           YES 
        30 SALES          CHICAGO          YES 
        40 OPERATIONS     BOSTON           NO 
*/
SELECT D.DEPTNO, D.DNAME, D.LOC, 
  CASE WHEN COUNT(E.DEPTNO) > 0 THEN 'YES' ELSE 'NO' 
   END AS EMP
FROM DEPT D LEFT JOIN EMP E
  ON D.DEPTNO = E.DEPTNO
GROUP BY D.DEPTNO, D.DNAME, D.LOC
ORDER BY 1;


SELECT DISTINCT D.DEPTNO, D.DNAME, D.LOC, 
	   NVL2(E.DEPTNO, 'YES', 'NO') AS EMP
FROM DEPT D LEFT OUTER JOIN EMP E
  ON D.DEPTNO = E.DEPTNO
ORDER BY D.DEPTNO;


SELECT D.*, NVL(( SELECT 'YES'
                  FROM EMP
                  WHERE DEPTNO = D.DEPTNO
                    AND ROWNUM = 1 ), 'NO') AS EMP
FROM DEPT D;