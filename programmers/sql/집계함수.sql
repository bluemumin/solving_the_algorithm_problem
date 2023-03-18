--가격이 제일 비싼 식품의 정보 출력하기, lv2
SELECT PRODUCT_ID,	PRODUCT_NAME,	PRODUCT_CD,	CATEGORY,price
from FOOD_PRODUCT
where price = (
select max(price)
from FOOD_PRODUCT);

--가장 비싼 상품 구하기, lv1
SELECT max(price)
from PRODUCT;

-- 최댓값 구하기, lv1
SELECT max(datetime)
from ANIMAL_INS;
	
-- 최솟값 구하기, lv2
SELECT min(datetime)
from ANIMAL_INS;

-- 동물 수 구하기, lv2
SELECT count(*) 
from ANIMAL_INS;

-- 중복 제거하기
-- distinct로 먼저 중복을 제거하고, null은 count에서 계산되지 않음 , lv2
select count(distinct(name))
from ANIMAL_INS;