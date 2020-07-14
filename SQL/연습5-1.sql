-- PRACTICE 1
SELECT LAST_NAME || ' earns ' || TO_CHAR(SALARY, 'fm$99,000.00') ||
       ' monthly but wants ' || TO_CHAR(SALARY*3, 'fm$99,000.00') || '.' AS "Dream Salaries"
FROM EMPLOYEES;


-- PRACTICE 2
SELECT LAST_NAME, HIRE_DATE, TO_CHAR(NEXT_DAY(ADD_MONTHS(HIRE_DATE, 6), '¿ù¿äÀÏ'),
       'fmDay, "the" Dspth "of" Month, YYYY', 'NLS_DATE_LANGUAGE=AMERICAN') AS REVIEW
FROM EMPLOYEES;


-- PRACTICE 3
SELECT LAST_NAME, NVL(TO_CHAR(COMMISSION_PCT), 'No Commission') AS COMM
FROM EMPLOYEES;


-- PRACTICE 4
SELECT JOB_ID, 
  CASE JOB_ID
       WHEN 'AD_PRES' THEN 'A'
       WHEN 'ST_MAN'  THEN 'B'
       WHEN 'IT_PROG' THEN 'C'
       WHEN 'SA_REP'  THEN 'D'
       WHEN 'ST_CLERK' THEN 'E'
       ELSE '0'
   END AS GRADE
FROM EMPLOYEES;


-- PRACTICE 5
SELECT JOB_ID, 
  CASE WHEN JOB_ID = 'AD_PRES' THEN 'A'
       WHEN JOB_ID = 'ST_MAN'  THEN 'B'
       WHEN JOB_ID = 'IT_PROG' THEN 'C'
       WHEN JOB_ID = 'SA_REP'  THEN 'D'
       WHEN JOB_ID = 'ST_CLERK' THEN 'E'
       ELSE '0'
   END AS GRADE
FROM EMPLOYEES;


-- PRACTICE 6
SELECT JOB_ID, 
       DECODE(JOB_ID, 'AD_PRES', 'A',
                      'ST_MAN',  'B',
                      'IT_PROG', 'C',
                      'SA_REP',  'D',
                      'ST_CLERK', 'E',
                      '0') AS GRADE
FROM EMPLOYEES;