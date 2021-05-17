select dep.ship_id,
    dep.departure_date,
    max_weight,
    max_volume,
    weight_allocated,
    volume_allocated,
    case
        when weight_allocated > max_weight then true
        else false
    end as max_weight_exceeded,
    case
        when volume_allocated > max_volume then true
        else false
    end as max_volume_exceeded
from public.preppin_data_2019_07_departure dep
    inner join (
        select sum(weight_allocated) as weight_allocated,
            sum(volume_allocated) as volume_allocated,
            split_part(departure_id, '-', 1) || '-' || split_part(departure_id, '-', 2) as ship_id,
            to_date(right(departure_id, 10), 'dd-mm-yyyy') as departure_date
        from public.preppin_data_2019_07_allocation
        group by ship_id,
            departure_date
    ) as allocation on dep.ship_id = allocation.ship_id
    and dep.departure_date = allocation.departure_date