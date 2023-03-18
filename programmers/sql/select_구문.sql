--3월에 태어난 여성 회원 목록 출력하기, lv2
SELECT MEMBER_ID, MEMBER_NAME, GENDER, TO_CHAR(DATE_OF_BIRTH,'YYYY-MM-DD')
FROM MEMBER_PROFILE 
WHERE to_char(DATE_OF_BIRTH, 'MM') = '03'
AND GENDER = 'W'
AND TLNO IS NOT NULL
ORDER BY MEMBER_ID;

--서울에 위치한 식당 목록 출력하기, lv4
SELECT B.REST_ID, A.REST_NAME, A.FOOD_TYPE, A.FAVORITES, A.ADDRESS, ROUND(B.REVIEW_SCORE,2) AS SCORE
FROM REST_INFO A, 
(SELECT REST_ID, AVG(REVIEW_SCORE) AS REVIEW_SCORE
 FROM REST_REVIEW 
 GROUP BY REST_ID) B
WHERE A.REST_ID = B.REST_ID
AND ADDRESS LIKE '서울%'
ORDER BY SCORE DESC, A.FAVORITES DESC;

--과일로 만든 아이스크림 고르기, lv1
SELECT a.flavor
from FIRST_HALF a, ICECREAM_INFO b
where a.FLAVOR = b.FLAVOR
and a.TOTAL_ORDER >= 3000
and b.INGREDIENT_TYPE = 'fruit_based'
order by a.TOTAL_ORDER desc;

--조건에 부합하는 중고거래 댓글 조회하기, lv1
SELECT a.TITLE, a.BOARD_ID, b.REPLY_ID, b.WRITER_ID, b.CONTENTS, to_char(b.CREATED_DATE, 'YYYY-MM-DD')
from USED_GOODS_BOARD a, USED_GOODS_REPLY b
where a.BOARD_ID = b.BOARD_ID
and to_char(a.CREATED_DATE, 'YYYY-MM') = '2022-10'
order by b.CREATED_DATE, a.TITLE;

--12세 이하인 여자 환자 목록 출력하기, lv1
SELECT PT_NAME, PT_NO, GEND_CD, AGE,
nvl(TLNO, 'NONE') as TLNO
from PATIENT
where age <= 12
and GEND_CD = 'W'
order by age desc, pt_name;

--흉부외과 또는 일반외과 의사 목록 출력하기, lv1
SELECT DR_NAME,	DR_ID,	MCDP_CD, to_char(HIRE_YMD,'YYYY-MM-DD')
from DOCTOR
where MCDP_CD = 'CS' or MCDP_CD = 'GS'
order by HIRE_YMD desc, DR_NAME;

--평균 일일 대여 요금 구하기, lv1
SELECT round(avg(DAILY_FEE),0) as AVERAGE_FEE
from CAR_RENTAL_COMPANY_CAR 
where CAR_TYPE = 'SUV';

--인기있는 아이스크림, lv1
SELECT FLAVOR
FROM FIRST_HALF
ORDER BY TOTAL_ORDER DESC, SHIPMENT_ID;

--조건에 맞는 도서 리스트 출력하기, lv1
SELECT BOOK_ID, TO_CHAR(PUBLISHED_DATE,'YYYY-MM-DD')
FROM BOOK
WHERE PUBLISHED_DATE >= TO_DATE('20210101','YYYYMMDD') 
AND PUBLISHED_DATE < TO_DATE('20220101','YYYYMMDD') 
AND CATEGORY = '인문'
ORDER BY PUBLISHED_DATE;

--강원도에 위치한 생산공장 목록 출력하기
SELECT FACTORY_ID,	FACTORY_NAME,	ADDRESS
from FOOD_FACTORY 
where address like '강원도%'
order by FACTORY_ID;

--모든 레코드 조회하기, lv1
SELECT * from ANIMAL_INS 
order by ANIMAL_ID;

--재구매가 일어난 상품과 회원 리스트 구하기, lv2
SELECT USER_ID, PRODUCT_ID
from ONLINE_SALE 
group by USER_ID, PRODUCT_ID
having count(*) >= 2
order by USER_ID, PRODUCT_ID desc;

--오프라인/온라인 판매 데이터 통합하기, lv4
SELECT TO_CHAR(SALES_DATE,'YYYY-MM-DD') AS TEMP_DATE, PRODUCT_ID, USER_ID, SALES_AMOUNT
FROM (SELECT USER_ID,	PRODUCT_ID,	SALES_AMOUNT,	SALES_DATE
FROM ONLINE_SALE 
WHERE TO_CHAR(SALES_DATE,'YYYYMM') = '202203'
UNION ALL
SELECT NULL AS  USER_ID, PRODUCT_ID,	SALES_AMOUNT,	SALES_DATE
FROM OFFLINE_SALE  
WHERE TO_CHAR(SALES_DATE,'YYYYMM') = '202203'
) A
ORDER BY TEMP_DATE, PRODUCT_ID, USER_ID;

--역순 정렬하기, lv1
SELECT name, datetime
from ANIMAL_INS 
order by ANIMAL_ID desc;

-- 아픈 동물 찾기, lv1
SELECT ANIMAL_ID, name
from ANIMAL_INS 
where INTAKE_CONDITION = 'Sick'
order by animal_id;

-- 어린 동물 찾기, lv1
SELECT ANIMAL_ID, name
from ANIMAL_INS
where INTAKE_CONDITION <> 'Aged'
order by ANIMAL_ID;

-- 동물의 아이디와 이름, lv1
SELECT animal_id, name
from ANIMAL_INS 
order by ANIMAL_ID;

-- 여러 기준으로 정렬하기, lv1
SELECT animal_id, name, datetime
from ANIMAL_INS
order by name, datetime desc;

-- 상위 n개 레코드, lv1
select name
from
(
SELECT name, datetime
from ANIMAL_INS
order by datetime
    )
where rownum <= 1;

--조건에 맞는 회원수 구하기, lv1
SELECT count(*)
from USER_INFO
where JOINED >= TO_DATE('20210101', 'YYYYMMDD') and
JOINED < TO_DATE('20220101', 'YYYYMMDD') 
and age >= 20 and age <= 29;