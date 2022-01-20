-- 루시와 엘라 찾기
SELECT ANIMAL_ID, name , sex_upon_intake
from ANIMAL_INS 
where name in ('Lucy', 'Ella', 'Pickle', 'Rogan', 'Sabrina', 'Mitty')
order by animal_id;

-- 이름에 el이 들어가는 동물 찾기
SELECT animal_id, name
from ANIMAL_INS
where lower(name) like '%el%'
and ANIMAL_TYPE = 'Dog'
order by name;

-- 중성화 여부 파악하기
SELECT ANIMAL_ID, name,
case when SEX_UPON_INTAKE like '%Neutered%' 
or SEX_UPON_INTAKE like '%Spayed%'  then 'O'
else 'X' end as 중성화
from ANIMAL_INS
order by animal_id;

-- 오랜 기간 보호한 동물(2)
select ANIMAL_ID, name
from (
SELECT a.ANIMAL_ID, a.NAME, b.datetime - a.datetime as time
from ANIMAL_INS a, ANIMAL_OUTS b
where a.ANIMAL_ID = b.ANIMAL_ID
order by time desc
    )
where rownum <= 2;

-- DATETIME에서 DATE로 형 변환
SELECT ANIMAL_ID, NAME, to_char(DATETIME, 'YYYY-MM-DD') as 날짜
from ANIMAL_INS
order by animal_id;
