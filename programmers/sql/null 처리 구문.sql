-- 이름이 없는 동물의 아이디
SELECT ANIMAL_ID
from ANIMAL_INS 
where name is null
order by ANIMAL_ID;

-- 이름이 있는 동물의 아이디
SELECT animal_id
from ANIMAL_INS 
where name is not null
order by ANIMAL_id;

-- NULL 처리하기
SELECT animal_type, 
case when name is null then 'No name'
else name end AS NAME,
SEX_UPON_INTAKE
from ANIMAL_INS
order by ANIMAL_ID;