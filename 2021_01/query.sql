select split_part(bike_store, ' - ', 1) as store,
    split_part(bike_store, ' - ', 2) as bike,
    order_id,
    customer_age,
    bike_value,
    existing_customer,
    date_part('day', date_col) as day_col,
    date_part('quarter', date_col) as quarter_col
from public.preppin_data_2021_01