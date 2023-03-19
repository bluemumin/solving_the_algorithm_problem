--조건에 맞는 도서와 저자 리스트 출력하기, lv2
SELECT a.BOOK_ID,	b.AUTHOR_NAME,	to_char(a.PUBLISHED_DATE,'YYYY-MM-DD')  as PUBLISHED_DATE
from BOOK a
inner join AUTHOR b
on a.AUTHOR_ID = b.AUTHOR_ID
where a.CATEGORY = '경제'
order by PUBLISHED_DATE
;

--그룹별 조건에 맞는 식당 목록 출력하기, lv4
with group_count as 
(
SELECT MEMBER_ID, count(*) as counting
from REST_REVIEW 
group by MEMBER_ID
)
select a.MEMBER_NAME, b.REVIEW_TEXT, to_char(b.REVIEW_DATE,'YYYY-MM-DD') as REVIEW_DATE
from MEMBER_PROFILE a
inner join 
REST_REVIEW b
on a.MEMBER_ID = b.MEMBER_ID
where b.MEMBER_ID in
(select member_id
from group_count
where counting = 
(select max(counting) from group_count)
)
order by REVIEW_DATE, REVIEW_TEXT
;

--주문량이 많은 아이스크림들 조회하기, lv4
select FLAVOR
from 
(
select FIRST_HALF.flavor, FIRST_HALF.t_o + JULY.t_o as total
from 
(SELECT FLAVOR, sum(TOTAL_ORDER) as t_o
from FIRST_HALF
group by FLAVOR) FIRST_HALF 
inner join 
(SELECT FLAVOR, sum(TOTAL_ORDER) as t_o
from JULY
group by FLAVOR) JULY
on FIRST_HALF.FLAVOR = JULY.FLAVOR
order by total desc
)
where rownum <= 3
;

--특정 기간동안 대여 가능한 자동차들의 대여비용 구하기, lv4
with history_result as 
(
select distinct car_id
from CAR_RENTAL_COMPANY_RENTAL_HISTORY 
where car_id not in (
SELECT car_id
from CAR_RENTAL_COMPANY_RENTAL_HISTORY
where START_DATE <= to_date('2022-11-30','YYYY-MM-DD')
and END_DATE >= to_date('2022-11-01','YYYY-MM-DD')
)
)
select *
from
(
select a.CAR_ID, a.CAR_TYPE, a.daily_fee * (100-c.discount_rate) / 100 * 30 as FEE
from CAR_RENTAL_COMPANY_CAR a
inner join history_result b
on a.CAR_ID = b.CAR_ID
inner join CAR_RENTAL_COMPANY_DISCOUNT_PLAN c
on a.CAR_TYPE = c.CAR_TYPE
where (a.CAR_TYPE = '세단' or a.CAR_TYPE = 'SUV')
and c.duration_type = '30일 이상'
)
where fee >= 500000 and fee <= 2000000
order by fee desc, car_type, car_id desc
;

--5월 식품들의 총매출 조회하기, lv4
with result as (
SELECT a.PRODUCT_ID, a.PRODUCT_NAME, a.PRICE, sum(b.amount) as sum_amount
from FOOD_PRODUCT  a
inner join FOOD_ORDER b
on a.PRODUCT_ID = b.PRODUCT_ID
where to_char(b.PRODUCE_DATE,'YYYY-MM') = '2022-05'
group by a.PRODUCT_ID, a.PRODUCT_NAME, a.PRICE
)
select product_id, product_name, price * sum_amount as TOTAL_SALES
from result
order by TOTAL_SALES desc, product_id
;

-- 없어진 기록 찾기, lv3
select ANIMAL_ID, NAME
from ANIMAL_OUTS
where ANIMAL_ID not in (
SELECT b.ANIMAL_ID
from ANIMAL_INS a, ANIMAL_OUTS b
where a.ANIMAL_ID = b.ANIMAL_ID
    )
order by ANIMAL_ID;

-- 있었는데요 없었습니다, lv3
SELECT a.ANIMAL_ID, a.name
from ANIMAL_INS a, ANIMAL_OUTS b
where a.ANIMAL_ID = b.ANIMAL_ID
and a.datetime > b.datetime
order by a.datetime;

-- 오랜 기간 보호한 동물(1), lv3
select name, datetime
from (
select * from ANIMAL_INS
where ANIMAL_ID not in (
SELECT a.ANIMAL_ID
from ANIMAL_INS a, ANIMAL_OUTS b
where a.ANIMAL_ID = b.ANIMAL_ID
    )
order by datetime
    )
where rownum <=3;

-- 보호소에서 중성화한 동물, lv4
SELECT a.animal_id, a.animal_type, a.name
from ANIMAL_INS a, ANIMAL_OUTS b
where a.ANIMAL_ID = b.ANIMAL_ID
and a.SEX_UPON_INTAKE != b.SEX_UPON_OUTCOME
and substr(b.SEX_UPON_OUTCOME,1, 6) != 'Intact';

--상품 별 오프라인 매출 구하기, lv2
SELECT a.PRODUCT_CODE, a.PRICE * b.total as SALES
from PRODUCT a
inner join 
(select PRODUCT_ID, sum(SALES_AMOUNT) as total
from OFFLINE_SALE
group by PRODUCT_ID
) b
on a.PRODUCT_ID = b.PRODUCT_ID
order by SALES desc, PRODUCT_CODE

--상품을 구매한 회원 비율 구하기, lv5
with checking as (
SELECT USER_ID
from USER_INFO 
where to_char(JOINED,'YYYY') = '2021'
),
total as (
select distinct a.user_id, 
to_char(b.SALES_DATE,'YYYY') as year, 
to_number(to_char(b.SALES_DATE,'MM')) as month
from checking a
inner join ONLINE_SALE  b
on a.USER_ID = b.USER_ID 
)
select year, month, count(*) as PUCHASED_USERS, 
round(count(*) / (select count(*) from checking),1) as PUCHASED_RATIO
from total
group by year, month
order by year, month