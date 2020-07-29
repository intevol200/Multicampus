-- PRACTICE 1
DECLARE
    V_COUNTRYID      VARCHAR(2) := 'UK';
    V_COUNTRY_RECORD COUNTRIES%ROWTYPE;
BEGIN
    SELECT * INTO V_COUNTRY_RECORD
    FROM COUNTRIES
    WHERE COUNTRY_ID = UPPER(V_COUNTRYID);
    
    DBMS_OUTPUT.PUT_LINE ('COUNTRY ID : ' || V_COUNTRY_RECORD.COUNTRY_ID || ' / ' ||
                          'COUNTRY NAME : ' || V_COUNTRY_RECORD.COUNTRY_NAME || ' / ' ||
                          'REGION : ' || V_COUNTRY_RECORD.REGION_ID);
END;
/


-- PRACTICE 2
DECLARE
    TYPE DEPT_TABLE_TYPE 
    IS TABLE OF DEPARTMENTS.DEPARTMENT_NAME%TYPE
    INDEX BY PLS_INTEGER;
    
    MY_DEPT_TABLE   DEPT_TABLE_TYPE;
    F_LOOP_COUNT    NUMBER(2) := 10;
    V_DEPTNO        NUMBER(4) := 0;
BEGIN
    FOR i IN 1..F_LOOP_COUNT
    LOOP
        V_DEPTNO := V_DEPTNO + 10;
        
        SELECT DEPARTMENT_NAME INTO MY_DEPT_TABLE(i)
        FROM DEPARTMENTS
        WHERE DEPARTMENT_ID = V_DEPTNO;
    END LOOP;
    
    FOR i IN 1..F_LOOP_COUNT
    LOOP
        DBMS_OUTPUT.PUT_LINE(MY_DEPT_TABLE(i));
    END LOOP;
END;
/


-- PRACTICE 3
DECLARE
    TYPE DEPT_TABLE_TYPE
    IS TABLE OF DEPARTMENTS%ROWTYPE;
    INDEX BY PLS_INTEGER;
    
    MY_DEPT_TABLE   DEPT_TABLE_TYPE;
    F_LOOP_COUNT    NUMBER(2) := 10;
    V_DEPTNO        NUMBER(4) := 0;
    
    FOR i IN 1..F_LOOP_COUNT
    LOOP
    V_DEPTNO := V_DEPTNO + 10;
    
    SELECT * INTO MY_DEPT_TABLE(i)
        FROM DEPARTMENTS
        WHERE DEPARTMENT_ID = V_DEPTNO;
    END LOOP;
    
    FOR i IN 1..f_loop_count
    LOOP
        DBMS_OUTPUT.PUT_LINE ('Department Number: ' ||  my_dept_table(i).department_id
    || ' Department Name: ' || my_dept_table(i).department_name
    || ' Manager Id: '|| my_dept_table(i).manager_id
    || ' Location Id: ' || my_dept_table(i).location_id);
    END LOOP;
END;
/