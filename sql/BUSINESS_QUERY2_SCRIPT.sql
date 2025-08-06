SELECT 
    s.speed_category,
    l.road_type,
    d.time_of_day,
    COUNT(DISTINCT f.crash_id) AS crash_count,
    SUM(f.number_fatalities) AS total_fatalities,
    ROUND(SUM(f.number_fatalities) * 1.0 / COUNT(DISTINCT f.crash_id), 2) AS fatalities_per_crash
FROM 
    fact_fatalities f
JOIN 
    speed_dim s ON f.SpeedKey = s.SpeedKey
JOIN 
    location_dim l ON f.LocationKey = l.LocationKey
JOIN 
    date_dim d ON f.DateKey = d.DateKey
WHERE 
    s.speed_category != 'Missing' AND
    l.road_type != 'Missing' AND
    d.time_of_day != 'Missing'
GROUP BY 
    s.speed_category, l.road_type, d.time_of_day
ORDER BY 
    total_fatalities DESC, 
    s.speed_category, 
    l.road_type, 
    d.time_of_day;