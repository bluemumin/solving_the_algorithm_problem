-- 우유와 요거트가 담긴 장바구니
SELECT distinct a.cart_id
from CART_PRODUCTS a, CART_PRODUCTS b
where a.cart_id = b.cart_id
and ((a.NAME = 'Yogurt' and b.NAME = 'Milk')
or (a.NAME = 'Milk' and b.NAME = 'Yogurt'))
order by a.cart_id;

-- 헤비 유저가 소유한 장소
select *
from places
where host_id in (
SELECT host_id
from PLACES 
group by host_id
having count(*) >= 2
    )
order by id;