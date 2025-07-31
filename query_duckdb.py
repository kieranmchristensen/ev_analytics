import duckdb
import pandas as pd

con = duckdb.connect('dev.duckdb')

df = con.execute("""
    SELECT
        REF_DATE,
        GEO,
        "Zero-Emission Vehicles Fuel Type" AS fuel_type,
        "Vehicle type" AS vehicle_type,
        VALUE
    FROM stg_zev_registrations
    WHERE GEO IN ('Canada', 'British Columbia')
    ORDER BY REF_DATE DESC
    LIMIT 20
""").fetchdf()

print(df)
