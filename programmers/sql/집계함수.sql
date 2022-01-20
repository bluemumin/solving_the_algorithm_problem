-- 최댓값 구하기
SELECT max(datetime)
from ANIMAL_INS;
	
-- 최솟값 구하기
SELECT min(datetime)
from ANIMAL_INS;

-- 동물 수 구하기
SELECT count(*) 
from ANIMAL_INS;

-- 중복 제거하기
-- distinct로 먼저 중복을 제거하고, null은 count에서 계산되지 않음
select count(distinct(name))
from ANIMAL_INS;