--경기도에 위치한 식품창고 목록 출력하기, lv1
SELECT WAREHOUSE_ID,	WAREHOUSE_NAME,	ADDRESS,
nvl(FREEZER_YN, 'N')
from FOOD_WAREHOUSE 
where ADDRESS like '경기도%'
order by WAREHOUSE_ID;

-- 이름이 없는 동물의 아이디, lv1
SELECT ANIMAL_ID
from ANIMAL_INS 
where name is null
order by ANIMAL_ID;

-- 이름이 있는 동물의 아이디, lv1
SELECT animal_id
from ANIMAL_INS 
where name is not null
order by ANIMAL_id;

-- NULL 처리하기, lv2
SELECT animal_type, 
case when name is null then 'No name'
else name end AS NAME,
SEX_UPON_INTAKE
from ANIMAL_INS
order by ANIMAL_ID;

--나이 정보가 없는 회원 수 구하기, lv1
SELECT count(*) as USERS
from USER_INFO 
where age is null;