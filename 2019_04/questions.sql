-- In games won by the Spurs, which player most often scores the most points?
select hi_points_player, count(hi_points_player) as most_points
from public.preppin_data_2019_04_clean
where win_or_loss = 'W'
group by hi_points_player
order by most_points desc
limit 1

-- In games lost by the Spurs, which player most often scores the most points?
select hi_points_player, count(hi_points_player) as most_points
from public.preppin_data_2019_04_clean
where win_or_loss = 'L'
group by hi_points_player
order by most_points desc
limit 1

-- Which player is the second most frequent at gaining the most assists in a game?
select 
	hi_assists_player, 
	count(hi_assists_player) as most_assists,
	home_or_away,
	count(home_or_away)
from public.preppin_data_2019_04_clean
group by hi_assists_player, home_or_away
order by most_assists desc
limit 2
offset 2

-- Which player scored the most points in games in October 2018 the most frequently?
select hi_points_player, count(hi_points_player) as most_points
from public.preppin_data_2019_04_clean
where date_part('month', true_date) = 10 and date_part('year', true_date) = 2018
group by hi_points_player
order by most_points desc
limit 1