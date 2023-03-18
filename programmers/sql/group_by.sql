--즐겨찾기가 가장 많은 식당 정보 출력하기, lv3
with max_table as (SELECT FOOD_TYPE, max(FAVORITES) as FAVORITES
from REST_INFO 
group by FOOD_TYPE)
select a.FOOD_TYPE,	a.REST_ID,	a.REST_NAME,a.FAVORITES
from REST_INFO a, max_table b
where a.FOOD_TYPE = b.FOOD_TYPE
and a.FAVORITES = b.FAVORITES
order by a.FOOD_TYPE desc

--자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기, lv2
SELECT CAR_TYPE, count(*) as	CARS
from CAR_RENTAL_COMPANY_CAR 
where OPTIONS like '%통풍시트%'
or OPTIONS like '%열선시트%'
or OPTIONS like '%가죽시트%'
group by CAR_TYPE
order by CAR_TYPE;



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