select 
	   make_date(2019, 3, 1) as month_col,
	   country, 
	   category, 
	   total_units_sold * (price_per_unit - cost_per_unit) as profit	   
from (select country, 
	  		category,
		    sum(units_sold) as total_units_sold
     from public.preppin_data_2019_06_england
     group by country, category) as e
inner join (select *,
			TRIM (TRAILING FROM type) || ' Soap' as type_new
			from public.preppin_data_2019_06_soap) as s
on e.category = s.type_new
union
select *
from public.preppin_data_2019_06_company
order by country desc, month_col