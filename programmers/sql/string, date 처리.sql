--자동차 평균 대여 기간 구하기, lv2
SELECT CAR_ID, round(avg(end_date - start_date)+1,1) as AVERAGE_DURATION
from CAR_RENTAL_COMPANY_RENTAL_HISTORY 
group by CAR_ID
having round(avg(end_date - start_date)+1,1) >= 7
order by AVERAGE_DURATION desc, CAR_ID desc;

--자동차 대여 기록에서 장기/단기 대여 구분하기, lv1
SELECT HISTORY_ID,	CAR_ID,	to_char(START_DATE,'YYYY-MM-DD'),	to_char(END_DATE,'YYYY-MM-DD'),
case when END_DATE - START_DATE + 1 >= 30 then '장기 대여'
else '단기 대여'
end as RENT_TYPE
from CAR_RENTAL_COMPANY_RENTAL_HISTORY
where to_char(START_DATE,'YYYY-MM') = '2022-09'
order by HISTORY_ID desc;

--대여 기록이 존재하는 자동차 리스트 구하기, lv3
SELECT distinct a.CAR_ID
from CAR_RENTAL_COMPANY_CAR a
inner join CAR_RENTAL_COMPANY_RENTAL_HISTORY b
on a.CAR_ID = b.CAR_ID
where a.CAR_TYPE = '세단'
and to_char(b.start_date,'MM') = '10'
order by CAR_ID desc;

--특정 옵션이 포함된 자동차 리스트 구하기, lv1
SELECT *
from CAR_RENTAL_COMPANY_CAR
where OPTIONS like '%네비게이션%'
order by CAR_ID desc;

--조건에 맞는 사용자 정보 조회하기, lv3
select 
a.user_id, a.nickname,
CITY || ' '|| street_address1 || ' ' ||street_address2 as 전체주소,
substr(TLNO,0,3) || '-' || substr(TLNO,4,4) || '-' || substr(TLNO,8,4) as 전화번호
from USED_GOODS_USER a
inner join 
(
SELECT WRITER_ID, count(*) counting
from USED_GOODS_BOARD 
--where status = 'DONE'
group by WRITER_ID
having count(*) >= 3) b
on a.USER_ID = b.WRITER_ID
order by a.user_id desc;

--조회수가 가장 많은 중고거래 게시판의 첨부파일 조회하기, lv3
SELECT '/home/grep/src/' || B.BOARD_ID || '/' ||B.FILE_ID || B.FILE_NAME || B.FILE_EXT AS FILE_PATH
FROM USED_GOODS_BOARD A
LEFT JOIN USED_GOODS_FILE B ON A.BOARD_ID = B.BOARD_ID
WHERE A.VIEWS = (SELECT MAX(A.VIEWS) 
                FROM USED_GOODS_BOARD A)
ORDER BY B.FILE_ID DESC;

--자동차 대여 기록 별 대여 금액 구하기, lv4
with type_check as 
(select HISTORY_ID, CAR_ID, END_DATE - START_DATE + 1 as counting,
 case 
when END_DATE - START_DATE + 1 >= 90 then '90일 이상'
when END_DATE - START_DATE + 1 >= 30 then '30일 이상'
when END_DATE - START_DATE + 1 >= 7 then '7일 이상'
else 'NONE'
end as DURATION_TYPE
from CAR_RENTAL_COMPANY_RENTAL_HISTORY
)
select b.history_id, b.counting * a.daily_fee * (100-nvl(c.discount_rate,0)) / 100 as fee
from type_check b
left join CAR_RENTAL_COMPANY_CAR a
on b.CAR_ID = a.CAR_ID
left join CAR_RENTAL_COMPANY_DISCOUNT_PLAN c
on a.CAR_TYPE = c.CAR_TYPE
and b.DURATION_TYPE = c.DURATION_TYPE
where a.CAR_TYPE = '트럭'
order by fee desc, history_id desc
;

SELECT history_id, MIN(daily_fee*(1-NVL(DISCOUNT_RATE,0)/100)*(end_date-start_date+1)) AS fee
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY ccrh 
    LEFT JOIN CAR_RENTAL_COMPANY_CAR ccc
    ON ccrh.car_id = ccc.car_id 
    LEFT JOIN (SELECT * FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN) crcdp
    ON (ccc.car_type = crcdp.car_type 
        AND (end_date-start_date+1) >= REGEXP_REPLACE(duration_type, '[^0-9]+'))
WHERE ccc.car_type = '트럭'
GROUP BY history_id
ORDER BY fee DESC, history_id DESC;

--조건별로 분류하여 주문상태 출력하기, lv3
SELECT ORDER_ID,	PRODUCT_ID,	to_char(OUT_DATE,'YYYY-MM-DD'),	
case when OUT_DATE <= to_date('2022-05-01','YYYY-MM-DD') then '출고완료'
when OUT_DATE > to_date('2022-05-01','YYYY-MM-DD') then '출고대기'
else '출고미정'
end as 출고여부
from FOOD_ORDER 
order by ORDER_ID
;

--취소되지 않은 진료 예약 조회하기, lv4
SELECT c.APNT_NO,	a.PT_NAME,	a.PT_NO,	b.MCDP_CD,	b.DR_NAME,	c.APNT_YMD
from APPOINTMENT c 
inner join PATIENT a
on c.PT_NO = a.PT_NO
inner join DOCTOR b
on c.MDDR_ID = b.DR_ID
where to_char(c.APNT_YMD,'YYYY-MM-DD') = '2022-04-13'
and c.MCDP_CD = 'CS' and c.APNT_CNCL_YN ='N'
order by APNT_YMD


--조건에 부합하는 중고거래 상태 조회하기, lv2
SELECT BOARD_ID,	WRITER_ID,	TITLE,	PRICE,
case when STATUS = 'SALE' then '판매중'
when STATUS = 'RESERVED' then '예약중'
else '거래완료'
end  STATUS
from USED_GOODS_BOARD
where to_date('2022-10-05','YYYY-MM-DD') = CREATED_DATE
order by BOARD_ID desc
;

-- 루시와 엘라 찾기, lv2
SELECT ANIMAL_ID, name , sex_upon_intake
from ANIMAL_INS 
where name in ('Lucy', 'Ella', 'Pickle', 'Rogan', 'Sabrina', 'Mitty')
order by animal_id;

-- 이름에 el이 들어가는 동물 찾기, lv2
SELECT animal_id, name
from ANIMAL_INS
where lower(name) like '%el%'
and ANIMAL_TYPE = 'Dog'
order by name;

-- 중성화 여부 파악하기, lv2
SELECT ANIMAL_ID, name,
case when SEX_UPON_INTAKE like '%Neutered%' 
or SEX_UPON_INTAKE like '%Spayed%'  then 'O'
else 'X' end as 중성화
from ANIMAL_INS
order by animal_id;

-- 오랜 기간 보호한 동물(2), lv3
select ANIMAL_ID, name
from (
SELECT a.ANIMAL_ID, a.NAME, b.datetime - a.datetime as time
from ANIMAL_INS a, ANIMAL_OUTS b
where a.ANIMAL_ID = b.ANIMAL_ID
order by time desc
    )
where rownum <= 2;

--카테고리 별 상품 개수 구하기, lv2
SELECT substr(PRODUCT_CODE,0,2) as CATEGORY, count(*) as PRODUCTS
from PRODUCT
group by substr(PRODUCT_CODE,0,2)
order by CATEGORY;

-- DATETIME에서 DATE로 형 변환, lv2
SELECT ANIMAL_ID, NAME, to_char(DATETIME, 'YYYY-MM-DD') as 날짜
from ANIMAL_INS
order by animal_id;
