--즐겨찾기가 가장 많은 식당 정보 출력하기, lv3
with max_table as (SELECT FOOD_TYPE, max(FAVORITES) as FAVORITES
from REST_INFO 
group by FOOD_TYPE)
select a.FOOD_TYPE,	a.REST_ID,	a.REST_NAME,a.FAVORITES
from REST_INFO a, max_table b
where a.FOOD_TYPE = b.FOOD_TYPE
and a.FAVORITES = b.FAVORITES
order by a.FOOD_TYPE desc

--식품분류별 가장 비싼 식품의 정보 조회하기, lv4
with result as 
(SELECT CATEGORY, max(PRICE) as price
from FOOD_PRODUCT
where CATEGORY in ('과자', '국', '김치', '식용유')
group by CATEGORY
)
select b.CATEGORY,	b.price,	a.PRODUCT_NAME
from FOOD_PRODUCT a, result b
where a.CATEGORY = b.CATEGORY
and a.price = b.price
order by b.price desc
;

--대여 횟수가 많은 자동차들의 월별 대여 횟수 구하기, lv3
select EXTRACT(MONTH FROM START_DATE) as month, CAR_ID, count(*) as records
from CAR_RENTAL_COMPANY_RENTAL_HISTORY
where CAR_ID in 
(SELECT car_id
from CAR_RENTAL_COMPANY_RENTAL_HISTORY
where to_char(START_DATE,'YYYY-MM') >= '2022-08'
and to_char(START_DATE,'YYYY-MM') <= '2022-10'
group by car_id
having count(*) >= 5)
and to_char(START_DATE,'YYYY-MM') >= '2022-08'
and to_char(START_DATE,'YYYY-MM') <= '2022-10'
group by EXTRACT(MONTH FROM START_DATE), CAR_ID
order by month, CAR_ID desc
;

--카테고리 별 도서 판매량 집계하기, lv3
select category, sum(sales) as TOTAL_SALES
from BOOK a, BOOK_SALES b
where a.BOOK_ID = b.BOOK_ID
and to_char(b.SALES_DATE,'YYYY-MM') = '2022-01'
group by category
order by category


--자동차 대여 기록에서 대여중 / 대여 가능 여부 구분하기, lv3
WITH USED_LIST AS (
    SELECT
        CAR_ID
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    WHERE TO_DATE('2022-10-16', 'YYYY-MM-DD') BETWEEN START_DATE AND END_DATE
) 
SELECT DISTINCT A.CAR_ID, 
CASE WHEN B.CAR_ID IS NULL THEN '대여 가능'
ELSE '대여중'
END as AVAILABILITY
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY A
LEFT JOIN USED_LIST B
ON A.CAR_ID = B.CAR_ID
order by A.CAR_ID desc

--조건에 맞는 사용자와 총 거래금액 조회하기, lv3
with result as
(SELECT WRITER_ID, sum(price) as TOTAL_SALES
from USED_GOODS_BOARD 
where status = 'DONE'
group by WRITER_ID
having sum(price) >= 700000
)
select b.USER_ID, b.NICKNAME, a.TOTAL_SALES
from result a, USED_GOODS_USER b
where a.WRITER_ID = b.USER_ID
order by a.TOTAL_SALES
;

--자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기, lv2
SELECT CAR_TYPE, count(*) as	CARS
from CAR_RENTAL_COMPANY_CAR 
where OPTIONS like '%통풍시트%'
or OPTIONS like '%열선시트%'
or OPTIONS like '%가죽시트%'
group by CAR_TYPE
order by CAR_TYPE;

--저자 별 카테고리 별 매출액 집계하기, lv4
with book_author as
(select a.BOOK_ID,	a.CATEGORY, a.AUTHOR_ID, a.PRICE, b.AUTHOR_NAME
from BOOK a, AUTHOR b
where a.AUTHOR_ID = b.AUTHOR_ID
),
result as 
(select BOOK_ID, sum(SALES) as counting
from BOOK_SALES
where to_char(SALES_DATE,'YYYY-MM') = '2022-01'
group by BOOK_ID )
select AUTHOR_ID,	AUTHOR_NAME, CATEGORY, sum(TOTAL_SALES)
from (
select a.author_id, a.AUTHOR_NAME, a.CATEGORY, b.counting * a.price as TOTAL_SALES 
from book_author a, result b
where a.BOOK_ID = b.BOOK_ID
)
group by AUTHOR_ID,	AUTHOR_NAME, CATEGORY
order by author_id, CATEGORY desc

--진료과별 총 예약 횟수 출력하기, lv2
SELECT MCDP_CD as 진료과코드, count(*) as 월예약건수
from APPOINTMENT
where to_char(APNT_YMD, 'YYYY-MM') = '2022-05'
group by MCDP_CD
order by 월예약건수, 진료과코드;

--성분으로 구분한 아이스크림 총 주문량, lv2
SELECT ingredient_type, sum(total_order) as TOTAL_ORDER
from FIRST_HALF a, ICECREAM_INFO b
where a.FLAVOR = b.FLAVOR
group by ingredient_type
order by TOTAL_ORDER
;

-- 고양이와 개는 몇 마리 있을까, lv2
SELECT ANIMAL_TYPE, count(*)
from ANIMAL_INS 
group by ANIMAL_TYPE
order by ANIMAL_TYPE;

-- 동명 동물 수 찾기, lv2
SELECT NAME, count(*) as COUNT
from ANIMAL_INS
where name is not null
group by name
having count(*) >=2
order by name;

--년, 월, 성별 별 상품 구매 회원 수 구하기, lv4
SELECT TO_CHAR(SALES_DATE,'YYYY') YEAR, TO_NUMBER(TO_CHAR(SALES_DATE,'MM')) MONTH,
    GENDER, COUNT(DISTINCT A.USER_ID) USERS
FROM ONLINE_SALE A INNER JOIN USER_INFO B ON(A.USER_ID = B.USER_ID)
WHERE GENDER IS NOT NULL
GROUP BY TO_CHAR(SALES_DATE,'YYYY'), TO_NUMBER(TO_CHAR(SALES_DATE,'MM')), GENDER
ORDER BY YEAR, MONTH, GENDER

-- 입양 시각 구하기(1), lv2
SELECT hour(datetime) as HOUR, count(*) as COUNT
from ANIMAL_OUTS
group by hour(datetime)
having hour >= 9 and hour < 20
order by HOUR;

-- 입양 시각 구하기(2), lv4
-- a에는 테이블에서의 시간별 count를 b에서는 connect by로 만든 임의 테이블에 0~23의 값 삽입
-- 그 이후, b를 기준으로 a와 outer join 수행 하고 값이 없는 시간대는 case로 0을 삽입
with 
a as (
select to_char(DATETIME,'HH24') as hour , count(*) as COUNT
from ANIMAL_OUTS 
group by to_char(DATETIME,'HH24')
),
b as (
SELECT rownum - 1 as HOUR
from dual
connect by rownum <= 24
) 
select b.hour,
case when a.count >=1 then a.count
else 0 end count
from a, b
where b.hour = a.hour(+)
order by b.hour;

--가격대 별 상품 개수 구하기, lv2
SELECT trunc(PRICE/10000)*10000 as PRICE_GROUP, count(*)
from PRODUCT 
group by trunc(PRICE/10000)*10000
order by PRICE_GROUP;