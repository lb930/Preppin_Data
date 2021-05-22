-- Sales by Brand and Store
select
	   unnest(REGEXP_MATCHES(model, '([a-zA-Z]+)')) as brand,
	   store,
	   sum(qty * value_per_bike) as order_value,
	   sum(qty) as qty_sold,
	   round(avg(shipping_date - order_date), 1) as time_to_ship
from public.preppin_data_2021_02
group by 1, 2
order by brand, store