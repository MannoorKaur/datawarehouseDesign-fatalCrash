SELECT 
    l.lga_name,
    l.state,
    ct.crash_type,
    s.speed_category,
    COUNT(DISTINCT f.crash_id) AS crash_count,
    SUM(f.number_fatalities) AS total_fatalities,
    ROUND(SUM(f.number_fatalities) * 100.0 / SUM(SUM(f.number_fatalities)) OVER (PARTITION BY l.lga_name), 1) AS pct_of_lga_fatalities,
    ROUND(AVG(f.number_fatalities), 2) AS avg_fatalities_per_crash
FROM 
    fact_fatalities f
JOIN 
    location_dim l ON f.LocationKey = l.LocationKey
JOIN 
    crash_type_dim ct ON f.CrashTypeKey = ct.CrashTypeKey
JOIN 
    speed_dim s ON f.SpeedKey = s.SpeedKey
WHERE 
    l.lga_name != 'Missing' AND
    ct.crash_type != 'Missing' AND
    s.speed_category != 'Missing'
GROUP BY 
    l.lga_name, l.state, ct.crash_type, s.speed_category
HAVING 
    COUNT(DISTINCT f.crash_id) >= 5  -- Focusing on patterns with sufficient data\
ORDER BY 
    SUM(f.number_fatalities) DESC,
    l.lga_name, 
    ct.crash_type, 
    s.speed_category;