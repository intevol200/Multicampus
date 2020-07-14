-- practice 1
SELECT SYSDATE AS "Date"
FROM DUAL;


-- practice 2 & 3
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, ROUND(SALARY*1.155, 0) AS "New Salary"
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID;


-- practice 4
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, 
       ROUND(SALARY*1.155, 0) AS "New Salary", 
       ROUND(SALARY*1.155, 0) - SALARY AS "Increase"
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID;


-- practice 5-a
SELECT LAST_NAME AS "Name", LENGTH(LAST_NAME) AS "Length"
FROM EMPLOYEES
WHERE LAST_NAME LIKE 'J%' OR LAST_NAME LIKE 'A%' OR LAST_NAME LIKE 'M%'
ORDER BY LAST_NAME;


-- practice 5-b
SELECT LAST_NAME AS "Name", LENGTH(LAST_NAME) AS "Length"
FROM EMPLOYEES
WHERE LAST_NAME LIKE '&FIRST_NAME%'
ORDER BY LAST_NAME;


-- practice 5-c
SELECT LAST_NAME AS "Name", LENGTH(LAST_NAME) AS "Length"
FROM EMPLOYEES
WHERE LAST_NAME LIKE UPPER('&FIRST_NAME%')
ORDER BY LAST_NAME;


-- practice 6
SELECT LAST_NAME, 
       ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE), 0) AS MONTH_WORKED
FROM EMPLOYEES
ORDER BY 2;


-- practice 7
SELECT LAST_NAME, LPAD(SALARY, 15, '$') AS SALARY
FROM EMPLOYEES;


-- practice 8
SELECT LAST_NAME, RPAD(' ', TRUNC(SALARY/1000), '*') AS EMPLOYEES_AND_SALARIES
FROM EMPLOYEES
ORDER BY SALARY DESC;


-- practice 9
SELECT LAST_NAME, TRUNC((SYSDATE - HIRE_DATE)/7) AS TENURE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 90
ORDER BY 2 DESC;