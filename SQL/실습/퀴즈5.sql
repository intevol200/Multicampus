/*
Q1. SOURCE_DATA 테이블을 이용하여, 
    13~16 주차에 요일별 판매 수량의 합계를 검색
    단, WEEK_ID 순으로 정렬

   WEEK_ID SUM(SALES_MON) SUM(SALES_TUE) SUM(SALES_WED) SUM(SALES_THUR) SUM(SALES_FRI)
---------- -------------- -------------- -------------- --------------- --------------
        13           2248           1453           2209            1182           2408
        14           2033           3701           1591            2206           1693
        15           1194           1515           1654            2500           1352
        16           2383            985           1717            2623           1866
*/
SELECT WEEK_ID, SUM(SALES_MON),
                SUM(SALES_TUE), 
                SUM(SALES_WED), 
                SUM(SALES_THUR), 
                SUM(SALES_FRI)
  FROM SOURCE_DATA
 WHERE WEEK_ID BETWEEN 13 AND 16
GROUP BY WEEK_ID
ORDER BY WEEK_ID;



/*
Q2. SALES_INFO 테이블을 이용하여, 
    13~16 주차에 요일별 판매 수량의 합계를 검색
    단, WEEK_ID, 요일 순으로 정렬
	
   WEEK_ID DAY  SUM(SALES_QTY)
---------- ---- --------------
        13 MON            2248
        13 TUE            1453
        13 WED            2209
        13 THUR           1182
        13 FRI            2408
        14 MON            2033
        14 TUE            3701
        14 WED            1591
        14 THUR           2206
        14 FRI            1693
        15 MON            1194
        15 TUE            1515
        15 WED            1654
        15 THUR           2500
        15 FRI            1352
        16 MON            2383
        16 TUE             985
        16 WED            1717
        16 THUR           2623
        16 FRI            1866

20개 행이 선택되었습니다. 
*/
SELECT WEEK_ID, DAY, SUM(SALES_QTY)
  FROM SALES_INFO                
 WHERE WEEK_ID BETWEEN 13 AND 16
GROUP BY WEEK_ID, DAY
ORDER BY WEEK_ID, CASE DAY WHEN 'MON' THEN 0
                           WHEN 'TUE' THEN 1
                           WHEN 'WED' THEN 2
                           WHEN 'THUR' THEN 3
                           WHEN 'FRI' THEN 4
                  ELSE 5 END;



/*
Q3. 13~16주차의 SOURCE_DATA 테이블의 데이터를 다음과 같이 검색 

     EMPNO       YEAR    WEEK_ID DAY   SALES_QTY
---------- ---------- ---------- ---- ----------
      7521       2016         14 MON         809
      7521       2016         14 TUE         939
      7521       2016         14 WED         268
      7521       2016         14 THUR        390
      7521       2016         14 FRI         329
      7521       2016         15 MON          84
      7521       2016         15 TUE         395
      7521       2016         15 WED         938
      7521       2016         15 THUR        824
      7521       2016         15 FRI         197
      7654       2016         15 MON         275
      7654       2016         15 TUE         780
      7654       2016         15 WED         431
      7654       2016         15 THUR        537
      7654       2016         15 FRI          49
      7654       2016         16 MON         692
      7654       2016         16 TUE         246
      7654       2016         16 WED         762
...

80개 행이 선택되었습니다. 
*/
SELECT S.EMPNO, S.YEAR, S.WEEK_ID,
       CASE NUM WHEN 1 THEN 'MON'
                WHEN 2 THEN 'TUE'
                WHEN 3 THEN 'WED'
                WHEN 4 THEN 'THUR'
                WHEN 5 THEN 'FRI' 
            END AS DAY,
       CASE NUM WHEN 1 THEN SALES_MON
                WHEN 2 THEN SALES_TUE
                WHEN 3 THEN SALES_WED
                WHEN 4 THEN SALES_THUR
                WHEN 5 THEN SALES_FRI
            END AS SALES_QTY
FROM ( SELECT * 
         FROM SOURCE_DATA
        WHERE WEEK_ID BETWEEN 13 AND 16 ) S
CROSS JOIN
     ( SELECT LEVEL AS NUM
         FROM DUAL
      CONNECT BY LEVEL <= 5 ) D
ORDER BY S.EMPNO, S.WEEK_ID, D.NUM;