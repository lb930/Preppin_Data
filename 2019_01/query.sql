select dealership,
		red_cars,
		silver_cars,
		black_cars,
		blue_cars,
		red_cars + silver_cars + black_cars + blue_cars as total_cars,
		make_date(when_sold_year, when_sold_month, 01) as "date"
from public.preppin_data_2019_01