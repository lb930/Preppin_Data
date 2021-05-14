create view preppin_data_2019_04_clean as(
    with base as(
        select *,
            case
                when date_col like '%Oct%'
                or date_col like '%Nov%'
                or date_col like '%Dec%' then '2018' || ' ' || replace(date_col, '"', '')
                else '2019' || ' ' || replace(date_col, '"', '')
            end as new_date
        from public.preppin_data_2019_04
    )
    select case
            when opponent like 'vs%' then replace(opponent, 'vs', '')
            when opponent like '@%' then replace(opponent, '@', '')
        end as opponent_clean,
        split_part(hi_points, ' ', 1) as hi_points_player,
        split_part(hi_points, ' ', 2) as hi_points,
        split_part(hi_rebounds, ' ', 1) as hi_rebounds_player,
        split_part(hi_rebounds, ' ', 2) as hi_rebounds,
        split_part(hi_assists, ' ', 1) as hi_assists_player,
        split_part(hi_assists, ' ', 2) as hi_assists,
        left(result, 1) as win_or_loss,
        case
            when opponent like 'vs%' then 'Home'
            when opponent like '@%' then 'Away'
        end as home_or_away,
        to_date(new_date, 'yyyy Dy, Mon DD') as true_date
    from base
)