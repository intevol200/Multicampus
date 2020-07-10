-- practice 1
SELECT last_name, job_id, salary AS Sal
FROM employees;

SELECT *
FROM job_grades;

SELECT employee_id, last_name, salary*12 AS "ANNUAL SALARY"
FROM employees;


-- practice 2
DESC DEPARTMENTS;

DESC EMPLOYEES;

SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, HIRE_DATE AS STARTDATE
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID;

SELECT DISTINCT JOB_ID
FROM EMPLOYEES;


-- practic 3
SELECT EMPLOYEE_ID AS "Emp #", LAST_NAME AS "Employee", JOB_ID AS "Job", HIRE_DATE AS "Hire Date"
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID;

SELECT LAST_NAME || ', ' || JOB_ID AS "Employee and Title"
FROM EMPLOYEES
ORDER BY LAST_NAME;

SELECT EMPLOYEE_ID || ',' || FIRST_NAME || ',' || LAST_NAME || ',' || EMAIL || ',' || PHONE_NUMBER || ',' ||
HIRE_DATE || ',' || JOB_ID || ',' || SALARY || ',' || COMMISSION_PCT || ',' || MANAGER_ID || ',' || DEPARTMENT_ID AS THE_OUTPUT
FROM EMPLOYEES;
