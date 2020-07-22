/*
Q1. CUSTOMERS, BLACKLIST 테이블 이용 
    2008년도에 블랙리스트에 등록된 고객 정보를 다음과 같이 검색 

검색 결과 

   CUST_ID CUST_FNAME   CUST_LNAME   COUNTRY_NAME    REASON_CODE UPDATE_DATE        
---------- ------------ ------------ --------------- ----------- -------------------
       101 Constantin   Welles       Argentina                 1 2008/08/03 00:00:00
       109 Christian    Cage         Poland                    3 2008/02/13 00:00:00
       119 Maurice      Hasan        Italy                     1 2008/05/10 00:00:00
       144 Sivaji       Landis       Spain                     1 2008/05/30 00:00:00
*/
SELECT C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME, C.COUNTRY_NAME,
       B.REASON_CODE, B.UPDATE_DATE
FROM CUSTOMERS C 
JOIN ( SELECT *
       FROM BLACKLIST
       WHERE UPDATE_DATE BETWEEN TO_DATE('20080101', 'YYYYMMDD')
                             AND TO_DATE('20090101', 'YYYYMMDD') - 1/86400 ) B
  ON C.CUST_ID = B.CUST_ID;


SELECT C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME, C.COUNTRY_NAME,
       B.REASON_CODE, B.UPDATE_DATE
FROM CUSTOMERS C JOIN BLACKLIST B
  ON C.CUST_ID = B.CUST_ID
WHERE UPDATE_DATE BETWEEN TO_DATE('20080101', 'YYYYMMDD')
                      AND TO_DATE('20090101', 'YYYYMMDD') - 1/86400;



/*
Q2. CUSTOMERS, BLACKLIST 테이블 이용
	블랙리스트에 등록된 이유(REASON_CODE)가 2인 고객 정보를 검색 

검색 결과 

   CUST_ID CUST_FNAME   CUST_LNAME  DATE_OF_BIRTH       COUNTRY_NAME  
---------- ------------ ----------- ------------------- --------------
       103 Manisha      Taylor      1983/03/22 00:00:00 Argentina     
       170 Harry Dean   Fonda       1988/04/15 00:00:00 Italy         
*/
SELECT C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME, C.DATE_OF_BIRTH, C.COUNTRY_NAME
FROM CUSTOMERS C JOIN BLACKLIST B
  ON C.CUST_ID = B.CUST_ID
WHERE REASON_CODE = 2;

SELECT CUST_ID, CUST_FNAME, CUST_LNAME, DATE_OF_BIRTH, COUNTRY_NAME
FROM CUSTOMERS
WHERE CUST_ID IN ( SELECT CUST_ID 
                   FROM BLACKLIST
                   WHERE REASON_CODE = 2 );


/*
Q3. CUSTOMERS, DORMANT_HIST 테이블을 이용
    현재 휴면계정 중 2010년 이전에 등록된 휴면계정을 검색하시오.
				   
   CUST_ID CUST_FNAME           CUST_LNAME           DATE_OF_BIRTH       COUNTRY_NAME                             START_DATE         
---------- -------------------- -------------------- ------------------- ---------------------------------------- -------------------
       195 Sean                 Olin                 1986/06/09 00:00:00 Poland                                   2009/03/17 08:34:58
       833 Alec                 Moranis              1964/10/17 00:00:00 Australia                                2009/08/16 12:52:53
       335 Margrit              Garner               1982/12/05 00:00:00 Spain                                    2008/03/23 12:02:20
       184 Mary Beth            Roberts              1957/11/11 00:00:00 United States of America                 2008/02/15 07:56:40
       131 Doris                Dutt                 1976/07/14 00:00:00 United States of America                 2008/01/03 06:25:59
       827 Alain                Siegel               1973/06/19 00:00:00 Poland                                   2008/02/22 06:30:27
       215 Orson                Perkins              1985/05/24 00:00:00 United States of America                 2009/05/07 18:02:03
       930 Buster               Jackson              1954/07/08 00:00:00 Germany                                  2008/02/23 20:18:42
       174 Blake                Seignier             1988/06/14 00:00:00 United States of America                 2009/05/26 11:47:15
       845 Ally                 Fawcett              1974/05/25 00:00:00 Germany                                  2009/09/04 19:30:10
       849 Alonso               Kaurusmdki           1980/08/13 00:00:00 France                                   2009/05/07 08:13:24
       132 Doris                Spacek               1987/07/25 00:00:00 Brazil                                   2009/05/16 18:26:41

12개 행이 선택되었습니다. 
*/
SELECT C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME, C.DATE_OF_BIRTH, C.COUNTRY_NAME,
       D.START_DATE
FROM CUSTOMERS C 
JOIN ( SELECT *
       FROM DORMANT_HIST
       WHERE START_DATE < TO_DATE('20100101', 'YYYYMMDD') - 1/86400
                                   AND END_DATE IS NULL ) D
  ON C.CUST_ID = D.CUST_ID;

SELECT C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME, C.DATE_OF_BIRTH,
       C.COUNTRY_NAME, D.START_DATE
FROM ( SELECT CUST_ID, CUST_FNAME, CUST_LNAME, 
              DATE_OF_BIRTH, COUNTRY_NAME
	   FROM CUSTOMERS
       WHERE DORMANT = 'Y') C 
JOIN ( SELECT *
       FROM DORMANT_HIST
	   WHERE START_DATE < TO_DATE('20100101','YYYYMMDD') ) D 
  ON C.CUST_ID = D.CUST_ID;


/*
Q4. CUSTOMERS, DORMANT_HIST 테이블을 이용
    휴면 상태가 아닌 고객 중, 2번 이상 휴면 상태를 갖았던 고객 정보를 검색하시오.

   CUST_ID CUST_FNAME           CUST_LNAME           DATE_OF_BIRTH       COUNTRY_NAME   
---------- -------------------- -------------------- ------------------- ---------------
       363 Kathy                Lambert              1956/08/31 00:00:00 Brazil         
       101 Constantin           Welles               1972/02/20 00:00:00 Argentina      
*/
SELECT C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME, C.DATE_OF_BIRTH, C.COUNTRY_NAME
FROM CUSTOMERS C 
JOIN ( SELECT CUST_ID, COUNT(END_DATE) AS CNT
       FROM DORMANT_HIST
       GROUP BY CUST_ID
       HAVING COUNT(END_DATE) >= 2 ) D
  ON C.CUST_ID = D.CUST_ID;

SELECT CUST_ID, CUST_FNAME, CUST_LNAME,
       DATE_OF_BIRTH, COUNTRY_NAME
FROM CUSTOMERS C
WHERE DORMANT = 'N'
  AND 2 <= ( SELECT COUNT(*)
             FROM DORMANT_HIST
             WHERE CUST_ID = C.CUST_ID);


/*
Q5. CUSTOMERS, DORMANT_HIST 테이블을 이용
    휴면 상태가 아닌 고객 중, 2번 이상 휴면 상태를 갖았던 고객 정보와 그 횟수를 검색하시오.
	
   CUST_ID CUST_FNAME           CUST_LNAME           DATE_OF_BIRTH       COUNTRY_NAME          CNT
---------- -------------------- -------------------- ------------------- -------------- ----------
       363 Kathy                Lambert              1956/08/31 00:00:00 Brazil                  2
       101 Constantin           Welles               1972/02/20 00:00:00 Argentina               2
*/
SELECT C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME, C.DATE_OF_BIRTH, C.COUNTRY_NAME, D.CNT
FROM CUSTOMERS C 
JOIN ( SELECT CUST_ID, COUNT(END_DATE) AS CNT
       FROM DORMANT_HIST
       GROUP BY CUST_ID
       HAVING COUNT(END_DATE) >= 2 ) D
  ON C.CUST_ID = D.CUST_ID;



/*
Q6. CUSTOMERS, DORMANT_HIST 테이블을 이용
    휴면 상태가 아닌 고객 중, 2번 이상 휴면 상태를 갖았던 고객 정보와 휴면 기간을 함께 검색하시오.

   CUST_ID CUST_FNAME           CUST_LNAME           COUNTRY_NAME   START_DATE          END_DATE           
---------- -------------------- -------------------- -------------- ------------------- -------------------
       101 Constantin           Welles               Argentina      2008/01/07 13:16:53 2008/03/29 08:01:09
       101 Constantin           Welles               Argentina      2009/01/28 07:09:02 2010/06/04 02:30:59
       363 Kathy                Lambert              Brazil         2008/07/23 09:35:59 2008/11/17 22:47:59
       363 Kathy                Lambert              Brazil         2009/01/28 13:20:00 2009/11/23 17:25:13
*/
SELECT C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME, C.COUNTRY_NAME, 
       D.START_DATE, D.END_DATE
FROM CUSTOMERS C 
JOIN ( SELECT H.CUST_ID, H.START_DATE, H.END_DATE, SUM(A.CNT)
       FROM DORMANT_HIST H JOIN ( SELECT CUST_ID, COUNT(END_DATE) AS CNT
                                  FROM DORMANT_HIST
                                  WHERE END_DATE IS NOT NULL
                                  GROUP BY CUST_ID ) A
         ON H.CUST_ID = A.CUST_ID
       GROUP BY H.CUST_ID, H.START_DATE, H.END_DATE
       HAVING SUM(A.CNT) >= 2 ) D
  ON C.CUST_ID = D.CUST_ID
ORDER BY 1, 5;

SELECT C.CUST_ID, C.CUST_FNAME, C.CUST_LNAME, C.COUNTRY_NAME,
       D.START_DATE, D.END_DATE
FROM ( SELECT * 
       FROM CUSTOMERS 
       WHERE DORMANT = 'N' ) C 
JOIN ( SELECT * 
       FROM DORMANT_HIST 
       WHERE CUST_ID IN ( SELECT CUST_ID
                          FROM DORMANT_HIST
                          GROUP BY CUST_ID 
                          HAVING COUNT(*) >= 2 ) ) D 
  ON C.CUST_ID = D.CUST_ID 
ORDER BY C.CUST_ID, D.START_DATE;