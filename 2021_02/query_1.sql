-- Sales by Brand and Type
select *,
    order_value / qty_sold as avg_order_value
from (
        select unnest(REGEXP_MATCHES(model, '([a-zA-Z]+)')) as brand,
            bike_type,
            sum(qty * value_per_bike) as order_value,
            sum(qty) as qty_sold
        from public.preppin_data_2021_02
        group by 1,2
        order by brand,
            bike_type
    ) as model_table