SELECT
    "REF_DATE" AS ref_date_string,
TO_DATE("REF_DATE" || '-01', 'YYYY-MM-DD') AS ref_date,
EXTRACT(YEAR FROM TO_DATE("REF_DATE" || '-01', 'YYYY-MM-DD'))::INT AS year,
CASE
    WHEN RIGHT("REF_DATE", 2) = '01' THEN 1
    WHEN RIGHT("REF_DATE", 2) = '04' THEN 2
    WHEN RIGHT("REF_DATE", 2) = '07' THEN 3
    WHEN RIGHT("REF_DATE", 2) = '10' THEN 4
    ELSE 0
END AS fiscal_quarter,
'Q' ||
CASE
    WHEN RIGHT("REF_DATE", 2) = '01' THEN '1'
    WHEN RIGHT("REF_DATE", 2) = '04' THEN '2'
    WHEN RIGHT("REF_DATE", 2) = '07' THEN '3'
    WHEN RIGHT("REF_DATE", 2) = '10' THEN '4'
    ELSE '0'
END || ' ' || LEFT("REF_DATE", 4) AS fiscal_period_label,
"GEO" AS province,
COALESCE("VALUE", 0) AS units
FROM {{ ref('raw_zev_registrations') }}
WHERE "REF_DATE" IS NOT NULL AND "REF_DATE" ~ '^\d{4}-\d{2}$' AND "Fuel type" = 'Battery electric'

