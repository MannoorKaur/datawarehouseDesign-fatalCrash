SELECT 
    l.state,
    d.day_type,
    d.time_of_day,
    COUNT(*) AS total_fatalities
FROM fact_fatalities f
JOIN date_dim d ON f.datekey = d.datekey
JOIN location_dim l ON f.locationkey = l.locationkey
WHERE d.day_type != 'Missing'
  AND d.time_of_day != 'Missing'
GROUP BY l.state, d.day_type, d.time_of_day
ORDER BY total_fatalities DESC, l.state, d.day_type, d.time_of_day;