-- PRACTICE 1
DECLARE
    V_DEPTNO NUMBER := 50;
    
    CURSOR C_EMP_CURSOR IS
        SELECT LAST_NAME, SALARY, MANAGER_ID
        FROM   EMPLOYEES
        WHERE  DEPARTMENT_ID = V_DEPTNO;
BEGIN
    FOR EMP_RECORD IN C_EMP_CURSOR
    LOOP
        IF EMP_RECORD.SALARY < 5000
           AND (EMP_RECORD.MANAGER_ID = 101 OR EMP_RECORD.MANAGER_ID = 124) THEN
           DBMS_OUTPUT.PUT_LINE(EMP_RECORD.LAST_NAME || ' DUE FOR A RAISE');
        ELSE
           DBMS_OUTPUT.PUT_LINE(EMP_RECORD.LAST_NAME || ' NOT DUE FOR A RAISE');
        END IF;
    END LOOP;
END;
/


-- PRACTICE 2
DECLARE
    CURSOR C_DEPT_CURSOR IS
        SELECT   DEPARTMENT_ID, DEPARTMENT_NAME
        FROM     DEPARTMENTS
        WHERE    DEPARTMENT_ID < 100
        ORDER BY DEPARTMENT_ID;
    
    CURSOR C_EMP_CURSOR(V_DEPTNO NUMBER) IS
        SELECT LAST_NAME, JOB_ID, HIRE_DATE, SALARY
        FROM   EMPLOYEES
        WHERE  DEPARTMENT_ID = V_DEPTNO 
          AND  EMPLOYEE_ID < 120;
    
    V_CURRENT_DEPTNO DEPARTMENTS.DEPARTMENT_ID%TYPE;
    V_CURRENT_DNAME  DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    V_ENAME          EMPLOYEES.LAST_NAME%TYPE;
    V_JOB            EMPLOYEES.JOB_ID%TYPE;
    V_HIREDATE       EMPLOYEES.HIRE_DATE%TYPE;
    V_SAL            EMPLOYEES.SALARY%TYPE;
BEGIN
    OPEN C_DEPT_CURSOR;
    LOOP
        FETCH C_DEPT_CURSOR INTO V_CURRENT_DEPTNO, V_CURRENT_DNAME;
        EXIT WHEN C_DEPT_CURSOR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('DEPARTMENT NUMBER : ' || V_CURRENT_DEPTNO 
                             || ' / ' || ' DEPARTMENT NAME : ' || V_CURRENT_DNAME);
    END LOOP;
    
    IF c_emp_cursor%ISOPEN THEN
        CLOSE c_emp_cursor;
    END IF;
    OPEN c_emp_cursor (v_current_deptno);
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
        LOOP
            FETCH c_emp_cursor INTO v_ename,v_job,v_hiredate,v_sal;
            EXIT WHEN c_emp_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE (v_ename || ' ' || v_job
                                  || ' ' || v_hiredate || ' ' || v_sal);
         END LOOP;
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    CLOSE c_emp_cursor;
END;
/


-- PRACTICE 3
DECLARE
    V_NUM   NUMBER(3) := 5;
    V_SAL   EMPLOYEES.SALARY%TYPE;
    
    CURSOR  C_EMP_CURSOR IS
        SELECT SALARY
        FROM EMPLOYEES
        ORDER BY SALARY DESC;
BEGIN
    OPEN C_EMP_CURSOR;
    FETCH C_EMP_CURSOR INTO V_SAL;
    WHILE C_EMP_CURSOR%ROWCOUNT <= V_NUM AND C_EMP_CURSOR%FOUND 
        LOOP
            INSERT INTO TOP_SALARIES (SALARY)
            VALUES (V_SAL);
            
            FETCH C_EMP_CURSOR INTO V_SAL;
        END LOOP;
    CLOSE C_EMP_CURSOR;
END;
/

SELECT *
FROM TOP_SALARIES;