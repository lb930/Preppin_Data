with concat as (
	select 
	case
		when city in ('Londoon', 'Londin', 'nodonL', 'Lond0n', 'london', 'Londen') then 'London'
		when city in ('Edenburgh', 'Edinborgh', 'edinborgh', 'Ed!nburgh', '3d!nburgh', 'edinburgh', 'Ed1nburgh') then 'Edinburgh'
		else city
		end,
		date,
		metric || ' - ' || measure AS new_metric,
		value
from public.preppin_data_2019_02)
select city,
		to_date(date, 'dd/mm/yyyy'),
		MIN(CASE WHEN new_metric = 'Wind Speed - mph' THEN value END) AS Wind_Speed_mph,
		MIN(CASE WHEN new_metric = 'Max Temperature - Celsius' THEN value END) AS Max_Temperature_Celsius,
		MIN(CASE WHEN new_metric = 'Min Temperature - Celsius' THEN value END) AS Min_Temperature_Celsius,
		MIN(CASE WHEN new_metric = 'Precipitation - mm' THEN value END) AS Precipitation_mm	
from concat
group by city, date
order by city, date