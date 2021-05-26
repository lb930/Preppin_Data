select all_tbl.training,
    all_tbl.contact_email,
    all_tbl.contact_name,
    all_tbl.client,
    all_tbl.client_id,
    all_tbl.account_manager,
    all_tbl.from_date
from (
        select training,
            contact_email,
            contact_name,
            client,
            client_id,
            max(from_date) as max_date
        from "ANALYTICS"."PREPPIN_DATA_2"."PD_2021_05"
        group by 1, 2, 3, 4, 5
    ) as max_tbl
    inner join "ANALYTICS"."PREPPIN_DATA_2"."PD_2021_05" all_tbl on max_tbl.training = all_tbl.training
    and max_tbl.contact_email = all_tbl.contact_email
    and max_tbl.client = all_tbl.client
    and max_tbl.contact_name = all_tbl.contact_name
    and max_tbl.client_id = all_tbl.client_id
    and max_tbl.max_date = all_tbl.from_date