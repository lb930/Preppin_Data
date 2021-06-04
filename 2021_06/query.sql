select measure,
       round(PGA, 0),
       round(LPGA, 0),
       round(LPGA - PGA, 0) as difference
from (
      select 
          measure,
          sum(case when tour = 'PGA' then value_col end) as PGA,
          sum(case when tour = 'LPGA' then value_col end) as LPGA
      from
          (select 
              'Number of players' as measure, 
               tour, 
               count(distinct(player)) as value_col
          from "ANALYTICS"."PREPPIN_DATA_2"."PD_2021_06"
          group by measure, tour
          union all
          select 
              'Number of events' as measure, 
               tour, 
               sum(events) as value_col
          from "ANALYTICS"."PREPPIN_DATA_2"."PD_2021_06"
          group by measure, tour
          union all
          select 
              'Total prize money' as measure, 
               tour, 
               sum(money) as value_col
          from "ANALYTICS"."PREPPIN_DATA_2"."PD_2021_06"
          group by measure, tour
          union all
          select 
                'Avg prize money' as measure,
                 tour, 
                 avg(money/events) as value_col
          from "ANALYTICS"."PREPPIN_DATA_2"."PD_2021_06"
          group by measure, tour
          UNION ALL
          SELECT
              'Avg rank' as measure,
               tour,
               avg(overall_rank-rank_per_tour) as value_col
          FROM (
              SELECT 
                  player, 
                  money,
                  tour,
                  ROW_NUMBER() OVER (partition by tour ORDER BY money desc) as rank_per_tour,
                  ROW_NUMBER() OVER (ORDER BY money desc) as overall_rank
              from "ANALYTICS"."PREPPIN_DATA_2"."PD_2021_06")
          group by measure, tour)
      group by measure)