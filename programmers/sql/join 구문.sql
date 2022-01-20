-- 없어진 기록 찾기
select ANIMAL_ID, NAME
from ANIMAL_OUTS
where ANIMAL_ID not in (
SELECT b.ANIMAL_ID
from ANIMAL_INS a, ANIMAL_OUTS b
where a.ANIMAL_ID = b.ANIMAL_ID
    )
order by ANIMAL_ID;

-- 있었는데요 없었습니다
SELECT a.ANIMAL_ID, a.name
from ANIMAL_INS a, ANIMAL_OUTS b
where a.ANIMAL_ID = b.ANIMAL_ID
and a.datetime > b.datetime
order by a.datetime;

-- 오랜 기간 보호한 동물(1)
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

-- 보호소에서 중성화한 동물
SELECT a.animal_id, a.animal_type, a.name
from ANIMAL_INS a, ANIMAL_OUTS b
where a.ANIMAL_ID = b.ANIMAL_ID
and a.SEX_UPON_INTAKE != b.SEX_UPON_OUTCOME
and substr(b.SEX_UPON_OUTCOME,1, 6) != 'Intact';