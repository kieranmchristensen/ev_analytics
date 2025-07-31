SELECT
    ref_date AS ref_date_string,
    TO_DATE(ref_date || '-01', 'YYYY-MM-DD') AS ref_date,
    EXTRACT(YEAR FROM TO_DATE(ref_date || '-01', 'YYYY-MM-DD'))::INT AS year,
    CASE
        WHEN RIGHT(ref_date, 2) = '01' THEN 1
        WHEN RIGHT(ref_date, 2) = '04' THEN 2
        WHEN RIGHT(ref_date, 2) = '07' THEN 3
        WHEN RIGHT(ref_date, 2) = '10' THEN 4
        ELSE 0
    END AS fiscal_quarter,
    'Q' ||
    CASE
        WHEN RIGHT(ref_date, 2) = '01' THEN '1'
        WHEN RIGHT(ref_date, 2) = '04' THEN '2'
        WHEN RIGHT(ref_date, 2) = '07' THEN '3'
        WHEN RIGHT(ref_date, 2) = '10' THEN '4'
        ELSE '0'
    END || ' ' || LEFT(ref_date, 4) AS fiscal_period_label,
    geo AS province,
    COALESCE(value, 0) AS units
FROM public.raw_zev_registrations
WHERE ref_date IS NOT NULL AND ref_date ~ '^\d{4}-\d{2}$'
