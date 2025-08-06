SELECT 
    l.road_type,
    l.remoteness,
    CASE 
        WHEN d.christmas_period = 1 THEN 'Christmas Period'
        WHEN d.easter_period = 1 THEN 'Easter Period'
        ELSE 'Regular Day'
    END AS period_type,
    d.time_of_day,
    COUNT(DISTINCT f.crash_id) AS crash_count,
    SUM(f.number_fatalities) AS total_fatalities
FROM 
    fact_fatalities f
JOIN 
    location_dim l ON f.LocationKey = l.LocationKey
JOIN 
    date_dim d ON f.DateKey = d.DateKey
WHERE 
    l.road_type != 'Missing' AND
    l.remoteness != 'Missing' AND
    d.time_of_day != 'Missing'
GROUP BY 
    l.road_type,
    l.remoteness,
    CASE 
        WHEN d.christmas_period = 1 THEN 'Christmas Period'
        WHEN d.easter_period = 1 THEN 'Easter Period'
        ELSE 'Regular Day'
    END,
    d.time_of_day
ORDER BY 
    period_type,
    total_fatalities DESC;