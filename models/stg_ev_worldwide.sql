
select 
region_country,
category as data_type,
year,
MAKE_DATE(year,1,1) as year_date,
parameter,
mode,
powertrain,
unit,
value,
"Aggregate group" as aggregate_group
FROM public.raw_ev_worldwide
WHERE year IS NOT NULL
