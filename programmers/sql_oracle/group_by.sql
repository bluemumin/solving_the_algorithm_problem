-- 고양이와 개는 몇 마리 있을까
SELECT ANIMAL_TYPE, count(*)
from ANIMAL_INS 
group by ANIMAL_TYPE
order by ANIMAL_TYPE;

-- 동명 동물 수 찾기
SELECT NAME, count(*) as COUNT
from ANIMAL_INS
where name is not null
group by name
having count(*) >=2
order by name;

-- 입양 시각 구하기(1)
SELECT hour(datetime) as HOUR, count(*) as COUNT
from ANIMAL_OUTS
group by hour(datetime)
having hour >= 9 and hour < 20
order by HOUR;

-- 입양 시각 구하기(2)
-- a에는 테이블에서의 시간별 count를 b에서는 connect by로 만든 임의 테이블에 0~23의 값 삽입
-- 그 이후, b를 기준으로 a와 outer join 수행 하고 값이 없는 시간대는 case로 0을 삽입
with a as (
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